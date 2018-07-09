from magma import *
from magma.bitutils import int2seq
from mantle.util.edge import falling
from mantle.util.edge import rising
from mantle import *
from rom import ROM16
from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()
for i in range(4):
    icestick.J3[i].output().on()

icestick.J1[0].input().on()

main = icestick.main()

trigger = 1 # maybe tie to GPIO later
CAP_DONE_MASK = 0x0008

# Generate the SCLK signal (12 MHz/16 = 750 kHz)
clk_counter = Counter(4)
sclk = clk_counter.O[3]
edge_f = falling(sclk)
edge_r = rising(sclk)

# ArduCAM start capture sequence
init = [array(int2seq(0x8200,16)), 							  # Change MCU mode
        array(int2seq(0x8401,16)), array(int2seq(0x8401,16)), array(int2seq(0x8402,16)), # Start capture
        array(int2seq(0x4100,16)), 							  # check capture completion flag
        array(int2seq(0x4200,16)), array(int2seq(0x4300,16)), array(int2seq(0x4400,16)), # Read image length
        array(int2seq(0x3CFF,16)), array(int2seq(0x0000,16)), # burst read 
        array(int2seq(0x0000,16)), array(int2seq(0x0000,16)),
        array(int2seq(0x0000,16)), array(int2seq(0x0000,16)),
        array(int2seq(0x0000,16)), array(int2seq(0x0000,16))]

# ROM to store commands
rom_index = Counter(4, has_ce=True, has_reset=True)
rom = ROM16(4, init, rom_index.O)

data = array([rom.O[0], rom.O[1], rom.O[2], rom.O[3],
              rom.O[4], rom.O[5], rom.O[6], rom.O[7],
              rom.O[8], rom.O[9], rom.O[10], rom.O[11],
              rom.O[12], rom.O[13], rom.O[14], rom.O[15]])

# Message length is 16 bits, setup counter to generate done signal after EOM
done_counter = Counter(5, has_ce=True, has_reset=True)
count = done_counter.O
done = Decode(16, 5)(count)

# State machine to generate run signal (enable)
run = DFF(has_ce=True)
run_n = LUT3([0,0,1,0, 1,0,1,0])
run_n(done, trigger, run)
run(run_n)
wire(edge_f, run.CE)

# Reset the message length counter after done
run_reset = LUT2(I0|~I1)(done, run)
done_counter(CE=edge_r, RESET=run_reset)

# State variables for high-level state machine
ready = LUT2(~I0 & I1)(run, edge_f)
start = ULE(4)(rom_index.O, uint(3,4))
burst = UGE(4)(rom_index.O, uint(9,4))

# Shift register to store 16-bit command|data to send
mosi = PISO(16, has_ce=True)
# SPI enable is negative of load-don't load and shift out data at the same time
enable = LUT3(I0 & ~I1 & ~I2)(trigger, run, burst) 
mosi(~burst,data,enable)
wire(edge_f, mosi.CE)

# Shit register to read in 16-bit data (first 8 bits are dummy)
miso = SIPO(16, has_ce=True)
#data_out = Register(16)
miso(main.J1)
valid = LUT2(~I0 & I1)(enable, edge_r)
wire(valid, miso.CE)

# Capture done state variable
cap_done = TFF(has_ce=True)
cap_done(EQ(16)(miso.O, bits(0x0008, 16)))
wire(enable&edge_r, cap_done.CE)

# ROM reset

# Use state variables to determine what commands are sent (how)
increment = LUT4(I0 & (I1 | I2) & ~I3)(ready, start, cap_done, burst)
wire(increment, rom_index.CE)

#wire(main.CLKIN,       main.J3[0])
wire(sclk,        main.J3[0])
wire(enable,      main.J3[1])
wire(mosi.O,        main.J3[2])
wire(burst,        main.J3[3])
#wire(done,      main.J3[3])
#wire(valid,      main.J3[4])
#wire(valid,      main.J3[6])



