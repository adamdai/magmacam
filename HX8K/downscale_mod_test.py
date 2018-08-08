import magma as m
from magma.bitutils import int2seq
import mantle
from rom import ROM8, ROM16
from mantle.util.edge import rising, falling
from loam.boards.hx8kboard import HX8KBoard
from uart import UART
from rescale import Rescale


hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
# hx8kboard.J2[12].output().on()

# hx8kboard.J2[16].output().on()
# hx8kboard.J2[17].output().on()
# hx8kboard.J2[18].output().on()
# hx8kboard.J2[19].output().on()


main = hx8kboard.main()

# "test" data
init = [m.uint(i, 16) for i in range(16)]
printf = mantle.Counter(4, has_ce=True)
rom = ROM16(4, init, printf.O)

# # baud for uart output
# clock = mantle.CounterModM(16, 8)
# baud = clock.COUT

# bit_counter = mantle.Counter(5, has_ce=True)
# m.wire(baud, bit_counter.CE)

# load = mantle.Decode(0, 5)(bit_counter.O)

clk_counter = mantle.Counter(5)
sclk = clk_counter.O[4]

edge_r = rising(sclk)
edge_f = falling(sclk)
baud = edge_r | edge_f

bit_counter = mantle.Counter(4, has_ce=True, has_reset=True)
m.wire(edge_r, bit_counter.CE)

high = mantle.Decode(7, 4)(bit_counter.O)

ff2 = mantle.FF(has_ce=True)
m.wire(baud, ff2.CE)
load = high & ~ff2(high)

m.wire(load & baud, printf.CE)



rescale = Rescale()

# inputs
m.wire(main.CLKIN, rescale.CLK)
m.wire(rom.O, rescale.DATA)
m.wire(sclk, rescale.SCK)
m.wire(load, rescale.LOAD)

# outputs
m.wire(rescale.UART,  main.J2_9)
m.wire(load,          main.J2_10)
m.wire(rescale.VALID, main.J2_11)
# m.wire(rescale.T0,    main.J2_12)

# m.wire(rescale.T1, main.J2_16)
# m.wire(rescale.T2, main.J2_17)
# m.wire(baud, main.J2_18)
# m.wire(load, main.J2_19)
