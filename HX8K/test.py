import magma as m
import mantle
from loam.boards.hx8kboard import HX8KBoard
from uart import UART

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[3].output().on()
hx8kboard.J2[4].output().on()
hx8kboard.J2[5].output().on()
# hx8kboard.J2[8].output().on()
# hx8kboard.J2[9].output().on()

main = hx8kboard.main()

# baud for uart output
clock = mantle.CounterModM(100, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)

valid_counter = mantle.CounterModM(10000, 14)
#m.wire(load & baud, valid_counter.CE)

m.wire(baud, main.J2_3)
m.wire(load, main.J2_4)
m.wire(valid_counter.COUT, main.J2_5) 