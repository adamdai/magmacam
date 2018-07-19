from magma import *
from magma.bitutils import int2seq
from mantle.util.edge import rising, falling
from mantle import *


RMASK = bits(0b1111100000000000, 16)
GMASK = bits(0b0000011111100000, 16)
BMASK = bits(0b0000000000011111, 16)

zeros = bits(0, 8)

class Process(Circuit):
    name = "Process"
    IO = ['CLK', In(Clock), 'SCK', In(Bit), 'DATA', In(Bits(8)), 'VALID', In(Bit),
          'PXV', Out(Bits(8)), 'PXB', Out(Bit), 'UART', Out(Bit)]
    @classmethod
    def definition(io):
      edge_r = rising(io.SCK)
      bit_counter = Counter(4, has_ce=True, has_reset=True)
      wire(edge_r, bit_counter.CE)

      low = Decode(15, 4)(bit_counter.O)
      high = Decode(7, 4)(bit_counter.O)

      low_byte = PIPO(8, has_ce=True)
      high_byte = PIPO(8, has_ce=True)

      low_byte(0, io.DATA, low)
      high_byte(0, io.DATA, high)

      wire(low, low_byte.CE)
      wire(high, high_byte.CE)

      px_bits = (uint(LSL(16,8)(uint(concat(high_byte.O, zeros)))) 
                 + uint(concat(low_byte.O, zeros)))

      # follow by right shift
      r_val = uint(LSR(16,11)(px_bits & RMASK))
      g_val = uint(LSR(16,5)(px_bits & GMASK))
      b_val = uint(px_bits & BMASK)

      px_val = (r_val + g_val + b_val)[:8]

      ff = FF(has_ce=True)
      wire(edge_r, ff.CE)
      px_bit = ff(UGE(8)(px_val, uint(63,8)))

      #---------------------------UART TIMING-----------------------------#

      u_data = array([px_val[7], px_val[6], px_val[5], px_val[4],
                      px_val[3], px_val[2], px_val[1], px_val[0], 0])

      baud = edge_r 

      ff = FF(has_ce=True)
      wire(edge_r, ff.CE)
      u_reset = LUT2(I0 & ~I1)(io.VALID, ff(io.VALID))
      wire(u_reset, bit_counter.RESET)

      u_counter = CounterModM(8, 3, has_ce=True, has_reset=True)
      u_counter(CE=edge_r, RESET=u_reset)
      load = io.VALID & high

      uart = PISO(9, has_ce=True)
      uart(1, u_data, load)
      wire(baud, uart.CE)

      wire(px_val, io.PXV)
      wire(px_bit, io.PXB)
      wire(uart,   io.UART) 

