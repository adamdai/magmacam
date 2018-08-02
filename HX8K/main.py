import magma as m
import mantle
from arducam import ArduCAM
from process import Process
from pipeline import Pipeline
from rescale import Rescale
from loam.boards.hx8kboard import HX8KBoard

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[3].output().on()
hx8kboard.J2[4].output().on()
hx8kboard.J2[5].output().on()
hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
#hx8kboard.J2[11].output().on()

hx8kboard.J2[8].input().on()

main = hx8kboard.main()

# Generate the SCLK signal (12 MHz/32 = 375 kHz)
clk_counter = mantle.Counter(5)
sclk = clk_counter.O[4]

# Initialize Modules

# ArduCAM
cam = ArduCAM()

m.wire(main.CLKIN,  cam.CLK)
m.wire(sclk,        cam.SCK)
m.wire(main.J2_8,     cam.MISO)

# Pre-processing
process = Process()

m.wire(main.CLKIN,  process.CLK)
m.wire(sclk,        process.SCK)
m.wire(cam.DATA,    process.DATA)
m.wire(cam.VALID,   process.VALID)

# rescale = Rescale()

# inputs
# m.wire(main.CLKIN, rescale.CLK)
# m.wire(process.PXV, rescale.DATA)
# m.wire(sclk, rescale.SCK)
# m.wire(process.LOAD, rescale.LOAD)

# Wire up GPIOs for debugging
m.wire(sclk,          main.J2_3)
m.wire(cam.EN,        main.J2_4)
m.wire(cam.MOSI,      main.J2_5)
m.wire(cam.UART,      main.J2_9)
m.wire(process.UART,  main.J2_10)
# m.wire(cam.DONE,      main.J2_11)
