import magma as m
from magma.bitutils import int2seq
from mantle.util.edge import rising, falling
from mantle import I0, I1, I2 
import mantle
from uart import UART

# bit masks for RGB565 values
RMASK = m.bits(0b1111100000000000, 16)
GMASK = m.bits(0b0000011111100000, 16)
BMASK = m.bits(0b0000000000011111, 16)

zeros = m.bits(0, 8)


class Process(m.Circuit):
    name = "Process"
    IO = ['CLK', m.In(m.Clock), 'SCK', m.In(m.Bit), 'DATA', m.In(m.Bits(8)),
          'VALID', m.In(m.Bit),
          'PXV', m.Out(m.Bits(16)), 'UART', m.Out(m.Bit), 'LOAD', m.Out(m.Bit)]

    @classmethod
    def definition(io):
        edge_r = rising(io.SCK)
        edge_f = falling(io.SCK)

        # pixels come 16 bits (high and low byte) at a time
        bit_counter = mantle.Counter(4, has_ce=True, has_reset=True)
        m.wire(edge_r, bit_counter.CE)

        # find when the high and low byte are valid
        low = mantle.Decode(15, 4)(bit_counter.O)
        high = mantle.Decode(7, 4)(bit_counter.O)

        # shift registers to store high and low byte
        low_byte = mantle.PIPO(8, has_ce=True)
        high_byte = mantle.PIPO(8, has_ce=True)

        low_byte(0, io.DATA, low)
        high_byte(0, io.DATA, high)

        m.wire(low, low_byte.CE)
        m.wire(high, high_byte.CE)

        # assemble the 16-bit RGB565 value
        px_bits = (m.uint(mantle.LSL(16)((m.uint(m.concat(high_byte.O, zeros))), m.bits(8, 4)))
                   + m.uint(m.concat(low_byte.O, zeros)))

        # extract the values for each color
        r_val = m.uint(mantle.LSR(16)((px_bits & RMASK), m.bits(11, 4)))
        g_val = m.uint(mantle.LSR(16)((px_bits & GMASK), m.bits(5, 4)))
        b_val = m.uint(px_bits & BMASK)

        # sum them to get grayscale (0 to 125)
        px_val = (r_val + g_val + b_val)

        # --------------------------UART OUTPUT---------------------------- #

        # run 16-bit UART at 2x speed
        baud = edge_r | edge_f

        # reset at start of pixel transfer
        ff1 = mantle.FF(has_ce=True)
        m.wire(baud, ff1.CE)
        u_reset = mantle.LUT2(I0 & ~I1)(io.VALID, ff1(io.VALID))
        m.wire(u_reset, bit_counter.RESET)

        # generate load signal
        ff2 = mantle.FF(has_ce=True)
        m.wire(baud, ff2.CE)
        load = mantle.LUT3(I0 & I1 & ~I2)(io.VALID, high, ff2(high))

        uart = UART(16)
        uart(CLK=io.CLK, BAUD=baud, DATA=px_val, LOAD=load)

        m.wire(px_val, io.PXV)
        m.wire(uart,   io.UART)
        m.wire(load,   io.LOAD)
