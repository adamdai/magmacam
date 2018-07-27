import magma as m
import mantle
from arducam import ArduCAM
from process import Process
from pipeline import Pipeline
from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()
for i in range(6):
    icestick.J3[i].output().on()

icestick.J1[0].input().on()

main = icestick.main()

# Generate the SCLK signal (12 MHz/32 = 375 kHz)
clk_counter = mantle.Counter(5)
sclk = clk_counter.O[4]

# Initialize Modules

# ArduCAM
cam = ArduCAM()

m.wire(main.CLKIN,  cam.CLK)
m.wire(sclk,        cam.SCK)
m.wire(main.J1,     cam.MISO)

# Pre-processing
process = Process()

m.wire(main.CLKIN,  process.CLK)
m.wire(sclk,        process.SCK)
m.wire(cam.DATA,    process.DATA)
m.wire(cam.VALID,   process.VALID)

# Wire up GPIOs for debugging
m.wire(sclk,          main.J3[0])
m.wire(cam.EN,        main.J3[1])
m.wire(cam.MOSI,      main.J3[2])
m.wire(cam.UART,      main.J3[3])
m.wire(process.UART,  main.J3[4])
m.wire(cam.DONE,      main.J3[5])
