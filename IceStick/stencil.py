from magma import *
from magma.bitutils import int2seq
from mantle import *
from rom import ROM8
from loam.boards.icestick import IceStick

'''
Convert a 1D array or stream of bytes representing RGB565 pixels to a set of greyscale
pixels by summing the R,G,B values and normalizing
'''

icestick = IceStick()
icestick.Clock.on()
#icestick.TX.output().on()
for i in range(5):
    icestick.J3[i].output().on()

main = icestick.main()

valid = 1

RMASK = bits(0b1111100000000000, 16)
GMASK = bits(0b0000011111100000, 16)
BMASK = bits(0b0000000000011111, 16)

zeros = bits(0, 8)

#test RGB565 data
# init = [array(int2seq(0x01, 8)), array(int2seq(0x02, 8)), #(1,1): black
#         array(int2seq(0x03, 8)), array(int2seq(0x04, 8)), #(1,2): white
#         array(int2seq(0x05, 8)), array(int2seq(0x06, 8)), #(1,3): white
#         array(int2seq(0x07, 8)), array(int2seq(0x08, 8)), #(1,4): black
#         array(int2seq(0x10, 8)), array(int2seq(0x09, 8)), #(2,1): white
#         array(int2seq(0x12, 8)), array(int2seq(0xD7, 8)), #(2,2): black
#         array(int2seq(0x34, 8)), array(int2seq(0xD2, 8)), #(2,3): black
#         array(int2seq(0x23, 8)), array(int2seq(0x10, 8)), #(2,4): white
#         array(int2seq(0x43, 8)), array(int2seq(0x13, 8)), #(3,1): white
#         array(int2seq(0x78, 8)), array(int2seq(0xD3, 8)), #(3,2): black
#         array(int2seq(0x21, 8)), array(int2seq(0xD8, 8)), #(3,3): black
#         array(int2seq(0x08, 8)), array(int2seq(0x12, 8)), #(3,4): white
#         array(int2seq(0x67, 8)), array(int2seq(0xD5, 8)), #(4,1): black
#         array(int2seq(0x31, 8)), array(int2seq(0x09, 8)), #(4,2): white
#         array(int2seq(0x02, 8)), array(int2seq(0x11, 8)), #(4,3): white
#         array(int2seq(0x01, 8)), array(int2seq(0xD6, 8))] #(4,4): black

init = [uint(n, 8) for n in range(32)]

# ROM to store data
printf = Counter(5, has_ce=True)
rom = ROM8(5, init, printf.O)

data = array([rom.O[0], rom.O[1], rom.O[2], rom.O[3],
              rom.O[4], rom.O[5], rom.O[6], rom.O[7]])

# baud for uart output
clock = CounterModM(103, 8)
baud = clock.COUT

bit_counter = Counter(4, has_ce=True)
wire(baud, bit_counter.CE)

low = Decode(0, 4)(bit_counter.O)
high = Decode(8, 4)(bit_counter.O)

low_byte = PIPO(8, has_ce=True)
high_byte = PIPO(8, has_ce=True)

low_byte(0, data, low)
high_byte(0, data, high)

wire(low, low_byte.CE)
wire(high, high_byte.CE)
increment = (low | high) & baud
wire(increment, printf.CE)

px_bits = uint(LSL(16,8)(uint(concat(high_byte.O, zeros)))) + uint(concat(low_byte.O, zeros))

# follow by right shift
r_val = uint(LSR(16,11)(px_bits & RMASK))
g_val = uint(LSR(16,5)(px_bits & GMASK))
b_val = uint(px_bits & BMASK)

px_val = r_val + g_val + b_val # 0 to 125 (2^5 -1 + 2^6 -1 + 2^5 - 1)
#px_val = px_bits

#---------------------------STENCILING-----------------------------#

#stencil = DeclareFromVerilogFile('stencil.v')
STEN = DeclareCircuit('STEN', 
			"I_0_0", In(Array(1, Array(1, Array(8, Bit)))),
			"O", Out(Array(8, Bit)),
			"CE", In(Bit),
			"V", Out(Bit),
			"CLK", In(Clock),
			"CLKOut", Out(Clock))

stencil = STEN()

# p = Array(8, BitIn)
# p = 

wire(stencil.I_0_0[0][0], bits(px_val[:8]))
#wire(baud, stencil.CE)

#---------------------------UART OUTPUT-----------------------------#

u_valid = 1

# u_data = array([px_val[7], px_val[6], px_val[5], px_val[4],
#                 px_val[3], px_val[2], px_val[1], px_val[0], 0])

u_data = array([stencil.O[7], stencil.O[6], stencil.O[5], stencil.O[4],
              stencil.O[3], stencil.O[2], stencil.O[1], stencil.O[0], 0])

uart = PISO(9, has_ce=True)
#load = LUT2(I0&~I1)(valid,run)
# ff = FF(has_ce=True)
# load = ff(low)
# wire(baud, ff.CE)
load = high & stencil.V
uart(1, u_data, high)
wire(baud, uart.CE)

wire(baud, main.J3[0])
wire(low, main.J3[1])
wire(high, main.J3[2])
wire(stencil.CLKOut, main.J3[3])
wire(uart, main.J3[4]) # change to main.TX to stream to UART
