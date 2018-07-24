from magma import *
from magma.bitutils import int2seq
from mantle import *
from rom import ROM8
from loam.boards.icestick import IceStick
from uart import UART


# input image dimensions (height and width)
wi = 320
hi = 240

# output image dimenstions
wo = 16
ho = 16

# downscale factor/window size (20 x 15)
m = wi//wo
n = hi//ho

# size of buffer for storing image n rows at a time
buf_size = wi * n - 1 # 4800 - 1 = 4799

icestick = IceStick()
icestick.Clock.on()
for i in range(8):
    icestick.J3[i].output().on()

main = icestick.main()

# "test" data
init = [uint(i, 16) for i in range(wi*hi)]
for i in range(54272):
	init.append(uint(0,16))
print(len(init))
printf = Counter(17, has_ce=True)
rom = ROM8(17, init, printf.O)

# baud for uart output
clock = CounterModM(103, 8)
baud = clock.COUT

bit_counter = Counter(4, has_ce=True)
wire(baud, bit_counter.CE)

load = Decode(0, 4)(bit_counter.O)

valid_counter = CounterModM(buf_size, 13, has_ce=True)
wire(load&baud, valid_counter.CE)

valid_list = [w_in*(n-1) + i*m - 1 for i in range(1,wo+1)]  # len = 16

valid = GND

for i in valid_list:
	valid = valid | Decode(i, 13)(valid_counter.O)

wire(load&baud, printf.CE)

px_val = rom.O

# register on input
st_in = Register(16, has_ce=True)
st_in(px_val)
wire(load, st_in.CE)

#---------------------------STENCILING-----------------------------#

Downscale = DeclareCircuit('Downscale', 
			"I_0_0", In(Array(1, Array(1, Array(8, Bit)))),
			"O", Out(Array(8, Bit)),
			"WE", In(Bit),
			"V", Out(Bit),
			"CLK", In(Clock))

dscale = Downscale()

wire(st_in.O, dscale.I_0_0[0][0])
wire(1, dscale.WE)
wire(load, dscale.CLK)

#---------------------------UART OUTPUT-----------------------------#

uart_px = UART(8)
uart_px(CLK=main.CLKIN, BAUD=baud, DATA=px_val, LOAD=load)

uart_st = UART(8)
uart_st(CLK=main.CLKIN, BAUD=baud, DATA=dscale.O, LOAD=load)


wire(valid, main.J3[0])
wire(dscale.CLKOut, main.J3[1])
wire(uart_px.O, main.J3[2]) 
wire(uart_st.O, main.J3[3]) 
# wire(uart_L00.O, main.J3[4])
# wire(uart_L01.O, main.J3[5])
# wire(uart_L10.O, main.J3[6])
# wire(uart_L11.O, main.J3[7])
