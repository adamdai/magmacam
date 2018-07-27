import magma as m
import mantle
from loam.boards.icestick import IceStick
from uart import UART

icestick = IceStick()
icestick.Clock.on()
for i in range(3):
    icestick.J3[i].output().on()

main = icestick.main()

# baud for uart output
clock = mantle.CounterModM(103, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)

valid_counter = mantle.CounterModM(1000, 10, has_ce=True)
m.wire(load & baud, valid_counter.CE)

m.wire(baud, main.J3[0])
m.wire(load, main.J3[1])
m.wire(valid_counter.COUT, main.J3[2]) 

