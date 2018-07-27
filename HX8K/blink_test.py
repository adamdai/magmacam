import magma as m
import mantle
from loam.boards.hx8kboard import HX8KBoard

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.D2.on()
hx8kboard.D3.on()
hx8kboard.D4.on()
hx8kboard.D5.on()

main = hx8kboard.main()

N = 22

counter = mantle.Counter(N)
m.wire(counter.O[N-1], main.D2)
m.wire(counter.O[N-1], main.D3)
m.wire(counter.O[N-1], main.D4)
m.wire(counter.O[N-1], main.D5)
