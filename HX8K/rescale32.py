import magma as m
import mantle
from mantle.util.edge import falling, rising
from mantle import I0, I1
from uart import UART


# input image dimensions (height and width)
wi = 352
hi = 288

# output image dimenstions
wo = 32
ho = 32

# downscale factor/window size (11 x 9)
a = wi//wo
b = hi//ho

# size of buffer for storing image n rows at a time
buf_size = wi * b  # 3168

# width of pixel data
width = 16

#threshold for determining black/white 
THRESH = 750  # (max = 125 * 16 = 2000)

# mask for high byte of row data
HIGH_MASK = m.bits(0xFF00, 16)

# mask for low byte of row data
LOW_MASK = m.bits(0x00FF, 16)


def reverse(bits):
    n = len(bits)
    return m.bits([bits[n-1-i] for i in range(n)])


class Rescale(m.Circuit):
    name = "Rescale"
    IO = ['CLK', m.In(m.Clock), 'LOAD', m.In(m.Bit), 'DATA', m.In(m.Bits(width)),
          'SCK', m.In(m.Bit),
          'WADDR', m.Out(m.Bits(5)), 'O', m.Out(m.Bits(32)), 
          'VALID', m.Out(m.Bit), 'DONE', m.Out(m.Bit), 'UART', m.Out(m.Bit),
          'T0', m.Out(m.Bit), 'T1', m.Out(m.Bit), 'T2', m.Out(m.Bit)]

    @classmethod
    def definition(io):
        load = io.LOAD
        baud = rising(io.SCK) | falling(io.SCK)

        valid_counter = mantle.CounterModM(buf_size, 12, has_ce=True)
        m.wire(load & baud, valid_counter.CE)

        valid_list = [wi * (b - 1) + i * a - 1 for i in range(1, wo + 1)]  # len = 32

        valid = m.GND

        for i in valid_list:
            valid = valid | mantle.Decode(i, 12)(valid_counter.O)

        # register on input
        st_in = mantle.Register(width, has_ce=True)
        st_in(io.DATA)
        m.wire(load, st_in.CE)

        # --------------------------DOWNSCALING----------------------------- #
        # downscale the image from 352x288 to 32x32
        Downscale = m.DeclareCircuit(
                    'Downscale',
                    "I_0_0", m.In(m.Array(1, m.Array(1, m.Array(width, m.Bit)))),
                    "WE", m.In(m.Bit), "CLK", m.In(m.Clock),
                    "O", m.Out(m.Array(width, m.Bit)), "V", m.Out(m.Bit))

        dscale = Downscale()

        m.wire(st_in.O, dscale.I_0_0[0][0])
        m.wire(1, dscale.WE)
        m.wire(load, dscale.CLK)

        add16 = mantle.Add(width)  # needed for Add16 definition

        # --------------------------FILL IMG RAM--------------------------- #
        # each valid output of dscale represents an entry of 32x32 binary image
        # accumulate each group of 32 entries into a 32-bit value representing a row
        col = mantle.CounterModM(32, 6, has_ce=True) 
        col_ce = rising(valid) 
        m.wire(col_ce, col.CE)

        # shift each bit in one at a time until we get an entire row
        px_bit = mantle.ULE(16)(dscale.O, m.uint(THRESH, 16)) & valid
        row_reg = mantle.SIPO(32, has_ce=True)
        row_reg(px_bit)
        m.wire(col_ce, row_reg.CE)

        # reverse the row bits since the image is flipped
        row = reverse(row_reg.O)

        rowaddr = mantle.Counter(6, has_ce=True)

        img_full = mantle.SRFF(has_ce=True)
        img_full(mantle.EQ(6)(rowaddr.O, m.bits(32, 6)), 0)
        m.wire(falling(col.COUT), img_full.CE)
        row_ce = rising(col.COUT) & ~img_full.O
        m.wire(row_ce, rowaddr.CE)

        waddr = rowaddr.O[:5]

        rdy = col.COUT & ~img_full.O
        pulse_count = mantle.Counter(2, has_ce=True)
        we = mantle.UGE(2)(pulse_count.O, m.uint(1, 2))
        pulse_count(CE=(we|rdy))

        # ---------------------------UART OUTPUT----------------------------- #

        row_load = row_ce
        row_baud = mantle.FF()(baud)
        uart_row = UART(32)
        uart_row(CLK=io.CLK, BAUD=row_baud, DATA=row, LOAD=row_load)

        uart_addr = UART(5)
        uart_addr(CLK=io.CLK, BAUD=row_baud, DATA=waddr, LOAD=row_load)

        m.wire(waddr, io.WADDR)
        m.wire(img_full, io.DONE) #img_full
        m.wire(uart_row, io.UART) #uart_st
        m.wire(row, io.O)
        m.wire(we, io.VALID)

        m.wire(valid, io.T0)
        m.wire(uart_addr, io.T1)


