from magma import *
set_mantle_target("ice40")
from mantle import *
from arducam import ArduCAM
from process import Process
from loam.boards.icestick import IceStick


icestick = IceStick()
icestick.Clock.on()
icestick.D1.on()
for i in range(6):
    icestick.J3[i].output().on()

icestick.J1[0].input().on()

main = icestick.main()

# Generate the SCLK signal (12 MHz/16 = 750 kHz)
clk_counter = Counter(5)
sclk = clk_counter.O[4]

cam = ArduCAM()

wire(main.CLKIN,  cam.CLK)
wire(sclk,        cam.SCK)
wire(main.J1,     cam.MISO)

process = Process()

wire(main.CLKIN,  process.CLK)
wire(sclk,        process.SCK)
wire(cam.DATA,    process.DATA)
wire(cam.VALID,   process.VALID)


wire(sclk,        main.J3[0])
wire(cam.EN,      main.J3[1])
wire(cam.MOSI,    main.J3[2])
wire(cam.UART,    main.J3[3])
wire(process.PXB,    main.J3[4])
wire(process.UART,    main.J3[5])

