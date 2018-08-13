import magma as m
import mantle
from arducam import ArduCAM
from process import Process
from pipeline import Pipeline
from rescale import Rescale
from loam.boards.hx8kboard import HX8KBoard

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()
hx8kboard.TX.on()
hx8kboard.D1.on()
hx8kboard.D2.on()
hx8kboard.D3.on()
hx8kboard.D4.on()
hx8kboard.D5.on()

hx8kboard.J2[3].output().on()
hx8kboard.J2[4].output().on()
hx8kboard.J2[5].output().on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

hx8kboard.J2[16].output().on()
hx8kboard.J2[17].output().on()
hx8kboard.J2[18].output().on()
hx8kboard.J2[19].output().on()

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

# Rescaling image
rescale = Rescale()
m.wire(main.CLKIN, rescale.CLK)
m.wire(process.PXV, rescale.DATA)
m.wire(sclk, rescale.SCK)
m.wire(process.LOAD, rescale.LOAD)

# Feed image to BNN pipeline
pipeline = Pipeline()
m.wire(sclk, pipeline.CLK)
m.wire(rescale.O, pipeline.DATA)
m.wire(rescale.WADDR, pipeline.WADDR)
m.wire(rescale.VALID, pipeline.WE)
m.wire(rescale.DONE, pipeline.RUN)
m.wire(pipeline.O[:4], m.bits([main.D1, main.D2, main.D3, main.D4]))
m.wire(pipeline.D, main.D5)

# Wire up camera SPI bus
m.wire(sclk,          main.J2_3)
m.wire(cam.EN,        main.J2_4)
m.wire(cam.MOSI,      main.J2_5)

# Wire up GPIOs for debugging
m.wire(cam.UART,      main.J2_9)
m.wire(process.UART,  main.J2_10)
m.wire(rescale.UART,      main.J2_11)
m.wire(rescale.DONE,      main.J2_12)

m.wire(sclk,      main.J2_16)
m.wire(rescale.VALID,      main.J2_17)
m.wire(rescale.T0,    main.J2_18)
m.wire(rescale.T1,      main.J2_19)

m.wire(rescale.UART,      main.TX)