from magma import *
from magma.bitutils import int2seq
from mantle.util.edge import falling
from mantle.util.edge import rising
from mantle import *
from rom import ROM16
from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()
for i in range(3):
    icestick.J3[i].output().on()

icestick.J1[0].input().on()

main = icestick.main()

valid = 1 # maybe tie to GPIO later

# ArduCAM start capture sequence
init = [array(int2seq(0x3CFF,16)),array(int2seq(0x0000,16))] 

# ROM to store commands
printf = Counter(32, has_ce=True)
rom_index = Counter(1, has_ce=True)
rom = ROM16(1, init, rom_index.O)

data = array([rom.O[0], rom.O[1], rom.O[2], rom.O[3],
              rom.O[4], rom.O[5], rom.O[6], rom.O[7],
              rom.O[8], rom.O[9], rom.O[10], rom.O[11],
              rom.O[12], rom.O[13], rom.O[14], rom.O[15]])

# Generate the SCLK signal (12 MHz/16 = 750 kHz)
clk_counter = Counter(4)
sclk = clk_counter.O[3]
edge_f = falling(sclk)
edge_r = rising(sclk)

# Message length is 16 bits, setup counter to generate done signal after EOM
done_counter = Counter(5, has_ce=True, has_reset=True)
count = done_counter.O
done = Decode(16, 5)(count)

# State machine to generate run signal (enable)
run = DFF(has_ce=True)
run_n = LUT3([0,0,1,0, 1,0,1,0])
run_n(done, valid, run)
run(run_n)
wire(edge_f, run.CE)

# Reset the message length counter after done
reset = LUT2(I0|~I1)(done, run)
done_counter(CE=edge_r, RESET=reset)

# Shift register to store 16-bit command|data to send
mosi = PISO(16, has_ce=True)
# SPI enable is negative of load-don't load and shift out data at the same time
load = LUT2(I0&~I1)(valid,run) 
mosi(0,data,load)
wire(edge_f, mosi.CE)

# Shit register to read in 16-bit data (first 8 bits are dummy)
miso = SIPO(16, has_ce=True)
miso(main.J1)
wire(edge_f, miso.CE)

ready = LUT2(~I0 & I1)(run, edge_f)
wire(ready, printf.CE)

start = ULE(32)(printf.O, uint(0,32))
increment = LUT2(I0 & I1)(ready, start)
wire(increment, rom_index.CE)

enable = 0

#wire(main.CLKIN,       main.J3[0])
wire(sclk,        main.J3[0])
wire(enable,      main.J3[1])
wire(mosi.O,        main.J3[2])
#wire(start,        main.J3[3])
#wire(done,      main.J3[3])
#wire(valid,      main.J3[4])
#wire(valid,      main.J3[6])
#wire(count,      main.J3[4:8])


