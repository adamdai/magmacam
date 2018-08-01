import magma as m
import mantle
from mantle.util.edge import falling, rising, falling_ce, rising_ce
from loam.boards.hx8kboard import HX8KBoard
from uart import UART

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()
hx8kboard.J2[13].output().on()

main = hx8kboard.main()

# baud for uart output
clock = mantle.CounterModM(100, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)


valid_counter = mantle.CounterModM(4800, 13, has_ce=True)
m.wire(load & baud, valid_counter.CE)

valid_list = [10*i for i in range(16)]  # len = 16

valid = m.GND

for i in valid_list:
    valid = valid | mantle.Decode(i, 13)(valid_counter.O)

col = mantle.CounterModM(16, 4, has_ce=True)
col_ce = rising(valid) #& ~row_full.O
m.wire(col_ce, col.CE)

m.wire(baud, main.J2_9)
m.wire(load, main.J2_10)
m.wire(valid, main.J2_11) 
m.wire(col_ce, main.J2_12)
m.wire(col.COUT, main.J2_13) 