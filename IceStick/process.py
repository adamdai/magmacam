from magma import *
from magma.bitutils import int2seq
from mantle.util.edge import rising, falling
from mantle import *
from uart import UART


RMASK = bits(0b1111100000000000, 16)
GMASK = bits(0b0000011111100000, 16)
BMASK = bits(0b0000000000011111, 16)

zeros = bits(0, 8)

class Process(Circuit):
    name = "Process"
    IO = ['CLK', In(Clock), 'SCK', In(Bit), 'DATA', In(Bits(8)), 'VALID', In(Bit),
          'PXV', Out(Bits(16)), 'UART', Out(Bit)]
    @classmethod
    def definition(io):
      edge_r = rising(io.SCK)
      edge_f = falling(io.SCK)

      # pixels come 16 bits (high and low byte) at a time
      bit_counter = Counter(4, has_ce=True, has_reset=True)
      wire(edge_r, bit_counter.CE)

      # find when the high and low byte are valid
      low = Decode(15, 4)(bit_counter.O)
      high = Decode(7, 4)(bit_counter.O)

      # shift registers to store high and low byte
      low_byte = PIPO(8, has_ce=True)
      high_byte = PIPO(8, has_ce=True)

      low_byte(0, io.DATA, low)
      high_byte(0, io.DATA, high)

      wire(low, low_byte.CE)
      wire(high, high_byte.CE)

      # assemble the 16-bit RGB565 value
      px_bits = (uint(LSL(16,8)(uint(concat(high_byte.O, zeros)))) 
                 + uint(concat(low_byte.O, zeros)))

      # extract the values for each color
      r_val = uint(LSR(16,11)(px_bits & RMASK))
      g_val = uint(LSR(16,5)(px_bits & GMASK))
      b_val = uint(px_bits & BMASK)

      # sum them to get grayscale (0 to 125)
      px_val = (r_val + g_val + b_val)

      #---------------------------UART OUTPUT-----------------------------#

      # run 16-bit UART at 2x speed
      baud = edge_r | edge_f

      # reset at start of pixel transfer
      ff1 = FF(has_ce=True)
      wire(baud, ff1.CE)
      u_reset = LUT2(I0 & ~I1)(io.VALID, ff1(io.VALID))
      wire(u_reset, bit_counter.RESET)

      # generate load signal 
      ff2 = FF(has_ce=True)
      wire(baud, ff2.CE)
      load = io.VALID & LUT2(I0 & ~I1)(high, ff2(high))

      uart = UART(16)
      uart(CLK=io.CLK, BAUD=baud, DATA=px_val, LOAD=load)

      wire(px_val, io.PXV)
      wire(uart,   io.UART) 

