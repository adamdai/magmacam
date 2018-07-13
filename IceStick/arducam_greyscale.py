from magma import *
from magma.bitutils import int2seq
from mantle.util.edge import falling
from mantle.util.edge import rising
from mantle import *
from rom import ROM16
from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()
icestick.TX.output().on()
for i in range(7):
    icestick.J3[i].output().on()

icestick.J1[0].input().on()

main = icestick.main()

trigger = 1 # maybe tie to GPIO later

RMASK = bits(0b1111100000000000, 16)
GMASK = bits(0b0000011111100000, 16)
BMASK = bits(0b0000000000011111, 16)

zeros = bits(0, 8)

# Generate the SCLK signal (12 MHz/16 = 750 kHz)
clk_counter = Counter(5)
sclk = clk_counter.O[4]
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
rom_index = Counter(4, has_ce=True)
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
mosi(~burst, data, enable)
wire(edge_f, mosi.CE)

# Shit register to read in 8-bit data 
miso = SIPO(8, has_ce=True)
#data_out = Register(16)
miso(main.J1)
valid = LUT2(~I0 & I1)(enable, edge_r)
wire(valid, miso.CE)

# Capture done state variable
cap_done = SRFF(has_ce=True)
cap_done(EQ(8)(miso.O, bits(0x08, 8)), 0)
wire(enable&edge_r, cap_done.CE)

# Use state variables to determine what commands are sent (how)
increment = LUT4(I0 & (I1 | I2) & ~I3)(ready, start, cap_done, burst)
wire(increment, rom_index.CE)

#wire(main.CLKIN,       main.J3[0])
wire(sclk,        main.J3[0])
wire(enable,      main.J3[1])
wire(mosi.O,        main.J3[2])
#wire(burst,        main.J3[3])
#wire(done,      main.J3[3])
#wire(valid,      main.J3[4])
#wire(valid,      main.J3[6])

#-----------------------CONVERT TO GREYSCALE------------------------#

bit_counter = Counter(4, has_ce=True, has_reset=True)
wire(edge_r, bit_counter.CE)

high = Decode(15, 4)(bit_counter.O)
low = Decode(7, 4)(bit_counter.O)

low_byte = PIPO(8, has_ce=True)
high_byte = PIPO(8, has_ce=True)

low_byte(0, miso.O, low)
high_byte(0, miso.O, high)

wire(low, low_byte.CE)
wire(high, high_byte.CE)

px_bits = uint(LSL(16,8)(uint(concat(high_byte.O, zeros)))) + uint(concat(low_byte.O, zeros))

# follow by right shift
r_val = uint(LSR(16,11)(px_bits & RMASK))
g_val = uint(LSR(16,5)(px_bits & GMASK))
b_val = uint(px_bits & BMASK)

#px_val = r_val + g_val + b_val 
px_val = high_byte.O

#---------------------------UART TIMING-----------------------------#

u_valid = 1

# u_data = array([miso.O[7], miso.O[6], miso.O[5], miso.O[4],
#                 miso.O[3], miso.O[2], miso.O[1], miso.O[0], 0])

u_data = array([px_val[7], px_val[6], px_val[5], px_val[4],
                px_val[3], px_val[2], px_val[1], px_val[0], 0])

baud = edge_r #| edge_f

ff = FF(has_ce=True)
wire(edge_r, ff.CE)
u_reset = LUT2(I0 & ~I1)(burst, ff(burst))
wire(u_reset, bit_counter.RESET)

u_counter = CounterModM(8, 3, has_ce=True, has_reset=True)
u_counter(CE=edge_r, RESET=u_reset)
#load = burst & rising(u_counter.COUT)
load = burst & low

uart = PISO(9, has_ce=True)
uart(1, u_data, load)
wire(baud, uart.CE)

wire(u_reset, main.J3[3])
wire(low, main.J3[4])
wire(high, main.J3[5])
wire(uart, main.J3[6]) # change to main.TX to stream to UART
