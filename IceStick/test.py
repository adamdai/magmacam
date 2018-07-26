from magma import *
from magma.bitutils import int2seq
from mantle import *
from rom import ROM8, ROM16
from loam.boards.icestick import IceStick
from uart import UART

icestick = IceStick()
icestick.Clock.on()
for i in range(3):
    icestick.J3[i].output().on()

main = icestick.main()

# baud for uart output
clock = CounterModM(103, 8)
baud = clock.COUT

bit_counter = Counter(5, has_ce=True)
wire(baud, bit_counter.CE)

load = Decode(0, 5)(bit_counter.O)

valid_counter = CounterModM(1000, 10, has_ce=True)
wire(load&baud, valid_counter.CE)

wire(baud, main.J3[0])
wire(load, main.J3[1])
wire(valid_counter.COUT, main.J3[2]) 

