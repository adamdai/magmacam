import magma as m
from magma.bitutils import int2seq
import mantle
from rom import ROM8, ROM16
from loam.boards.hx8kboard import HX8KBoard
from uart import UART
from rescale import Rescale


hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[3].output().on()
hx8kboard.J2[4].output().on()
hx8kboard.J2[5].output().on()
hx8kboard.J2[8].output().on()
hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

main = hx8kboard.main()

# "test" data
init = [m.uint(i, 16) for i in range(16)]
printf = mantle.Counter(4, has_ce=True)
rom = ROM16(4, init, printf.O)

# baud for uart output
clock = mantle.CounterModM(16, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)

m.wire(load & baud, printf.CE)

rescale = Rescale()

# inputs
m.wire(main.CLKIN, rescale.CLK)
m.wire(rom.O, rescale.DATA)
m.wire(baud, rescale.SCK)
m.wire(load, rescale.LOAD)

# outputs
m.wire(rescale.UART, main.J2_3)
m.wire(load, main.J2_4)
m.wire(rescale.DONE, main.J2_5)
m.wire(rescale.T0, main.J2_8)

m.wire(rescale.T1, main.J2_9)
m.wire(rescale.T2, main.J2_10)
m.wire(rescale.T3, main.J2_11)
m.wire(rescale.T4, main.J2_12)
