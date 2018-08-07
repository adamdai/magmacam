import magma as m
import mantle
#from mantle.util.edge import falling, rising, falling_ce, rising_ce
from arducam import ArduCAM
from process import Process
from rescale import Rescale
from loam.boards.hx8kboard import HX8KBoard
from uart import UART

hx8kboard = HX8KBoard()
# hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()
#hx8kboard.J2[13].output().on()

main = hx8kboard.main()



