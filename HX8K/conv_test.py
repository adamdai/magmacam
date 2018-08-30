import magma as m
import mantle
from uart import UART
from arducam import ArduCAM
from process import Process
from pipeline import Pipeline
from rescale1bit import Rescale
from loam.boards.hx8kboard import HX8KBoard

from wrapinst import WrapInst


hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[3].output().on()
hx8kboard.J2[4].output().on()
hx8kboard.J2[5].output().on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

hx8kboard.J2[16].output().on()

hx8kboard.J2[8].input().on()

main = hx8kboard.main()

# convolution window size
x = 3
y = 3

# image size (height and width)
dim = 16

weights = m.array([m.array([m.array([1]), m.array([1]), m.array([1])]),
                   m.array([m.array([1]), m.array([1]), m.array([1])]),
                   m.array([m.array([0]), m.array([0]), m.array([0])])])

# Generate the SCLK signal (12 MHz/32 = 375 kHz)
clk_counter = mantle.Counter(2)
sclk = clk_counter.O[-1]

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

# Rescaling image
rescale = Rescale()
m.wire(main.CLKIN, rescale.CLK)
m.wire(process.PXV, rescale.DATA)
m.wire(sclk, rescale.SCK)
m.wire(process.LOAD, rescale.LOAD)

# register on input
bitin = mantle.Register(1, has_ce=True)
bitin(m.array(rescale.O))
m.wire(process.LOAD, bitin.CE)

Convolution = m.DeclareFromVerilogFile('build/convolution.v',
                                       module="Convolution")

conv = WrapInst(Convolution())

m.wire(~sclk, conv.CLK)
m.wire(bitin, conv.I0[0][0])
m.wire(weights, conv.I1)
m.wire(rescale.VALID, conv.WE)

# Wire up camera SPI bus
m.wire(sclk,          main.J2_3)
m.wire(cam.EN,        main.J2_4)
m.wire(cam.MOSI,      main.J2_5)

# Wire up GPIOs for debugging
m.wire(cam.UART,      main.J2_9)
m.wire(process.UART,  main.J2_10)
m.wire(rescale.O & rescale.VALID,      main.J2_11)
m.wire(conv.O,      main.J2_12)
m.wire(conv.V,      main.J2_16)