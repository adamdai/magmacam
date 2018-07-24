from magma import *
from magma.bitutils import int2seq
from mantle import *
from rom import ROM8
from loam.boards.icestick import IceStick
from uart import UART


icestick = IceStick()
icestick.Clock.on()
for i in range(8):
    icestick.J3[i].output().on()

main = icestick.main()

# "test" data
init = [uint(n, 8) for n in range(16)]
printf = Counter(4, has_ce=True)
rom = ROM8(4, init, printf.O)

# baud for uart output
clock = CounterModM(103, 8)
baud = clock.COUT

bit_counter = Counter(4, has_ce=True)
wire(baud, bit_counter.CE)

load = Decode(0, 4)(bit_counter.O)

#valid_counter = CounterModM(4800, 13, has_ce=True)
valid_counter = CounterModM(8, 3, has_ce=True)
wire(load&baud, valid_counter.CE)

valid = Decode(5,3)(valid_counter.O) | Decode(7,3)(valid_counter.O)

wire(load&baud, printf.CE)

px_val = rom.O

st_in = Register(8, has_ce=True)
st_in(px_val)
wire(load, st_in.CE)

#---------------------------STENCILING-----------------------------#

STEN = DeclareCircuit('STEN', 
			"I_0_0", In(Array(1, Array(1, Array(8, Bit)))),
			"O", Out(Array(8, Bit)),
			"WE", In(Bit),
			"V", Out(Bit),
			"CLK", In(Clock),
			"CLKOut", Out(Clock),
			"L00", Out(Array(8, Bit)),
			"L01", Out(Array(8, Bit)),
			"L10", Out(Array(8, Bit)),
			"L11", Out(Array(8, Bit)),
			)

stencil = STEN()

wire(st_in.O, stencil.I_0_0[0][0])
wire(1, stencil.WE)
wire(load, stencil.CLK)

#---------------------------UART OUTPUT-----------------------------#

uart_px = UART(8)
uart_px(CLK=main.CLKIN, BAUD=baud, DATA=px_val, LOAD=load)

uart_st = UART(8)
uart_st(CLK=main.CLKIN, BAUD=baud, DATA=stencil.O, LOAD=load)

uart_L00 = UART(8)
uart_L00(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L00, LOAD=load)

uart_L01 = UART(8)
uart_L01(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L01, LOAD=load)

uart_L10 = UART(8)
uart_L10(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L10, LOAD=load)

uart_L11 = UART(8)
uart_L11(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L11, LOAD=load)

uart_reg = UART(8)
uart_reg(CLK=main.CLKIN, BAUD=baud, DATA=st_in.O, LOAD=load)

wire(valid, main.J3[0])
wire(stencil.CLKOut, main.J3[1])
wire(uart_px.O, main.J3[2]) # change to main.TX to stream to UART
wire(uart_st.O, main.J3[3]) # change to main.TX to stream to UART
wire(uart_L00.O, main.J3[4])
wire(uart_L01.O, main.J3[5])
wire(uart_L10.O, main.J3[6])
wire(uart_L11.O, main.J3[7])
