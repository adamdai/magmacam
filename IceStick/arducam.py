from magma import *
from magma.bitutils import int2seq
from mantle.util.edge import falling, rising
from mantle import *
from rom import ROM16
from uart import UART


trigger = 1 # maybe tie to GPIO later

# ArduCAM start capture sequence
init = [array(int2seq(0x8200,16)), 							  # Change MCU mode
        array(int2seq(0x8401,16)), array(int2seq(0x8401,16)), array(int2seq(0x8402,16)), # Start capture
        array(int2seq(0x4100,16)), 							  # check capture completion flag
        array(int2seq(0x4200,16)), array(int2seq(0x4300,16)), array(int2seq(0x4400,16)), # Read image length
        array(int2seq(0x3CFF,16)), array(int2seq(0x0000,16)), # burst read 
        array(int2seq(0x0000,16)), array(int2seq(0x0000,16)),
        array(int2seq(0x0000,16)), array(int2seq(0x0000,16)),
        array(int2seq(0x0000,16)), array(int2seq(0x0000,16))]


# Read ROM unit
class ArduCAM(Circuit):
    name = "ArduCAM"
    IO = ['CLK', In(Clock), 'SCK', In(Bit), 'MISO', In(Bit),
          'EN', Out(Bit), 'MOSI', Out(Bit), 'DATA', Out(Bits(8)), 'VALID', Out(Bit), 'UART', Out(Bit), 'DONE', Out(Bit)]
    @classmethod
    def definition(cam):
        edge_f = falling(cam.SCK)
        edge_r = rising(cam.SCK)

        # ROM to store commands
        rom_index = Counter(4, has_ce=True)
        rom = ROM16(4, init, rom_index.O)

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
        mosi(~burst, rom.O, enable)
        wire(edge_f, mosi.CE)

        # Shit register to read in 8-bit data 
        miso = SIPO(8, has_ce=True)
        miso(cam.MISO)
        valid = LUT2(~I0 & I1)(enable, edge_r)
        wire(valid, miso.CE)    

        # Capture done state variable
        cap_done = SRFF(has_ce=True)
        cap_done(EQ(8)(miso.O, bits(0x08, 8)), 0)
        wire(enable&edge_r, cap_done.CE)

        # Use state variables to determine what commands are sent (how)
        increment = LUT4(I0 & (I1 | I2) & ~I3)(ready, start, cap_done, burst)
        wire(increment, rom_index.CE)

        # wire outputs
        wire(enable,  cam.EN)
        wire(mosi.O,  cam.MOSI)
        wire(miso.O,  cam.DATA)
        wire(burst,   cam.VALID)

        #---------------------------UART OUTPUT-----------------------------#

        # run UART at 2x SPI rate to allow it to keep up
        baud = edge_r | edge_f

        # reset when SPI burst read (image transfer) begins 
        ff = FF(has_ce=True)
        wire(edge_r, ff.CE)
        u_reset = LUT2(I0 & ~I1)(burst, ff(burst))

        # UART data out every 8 bits
        u_counter = CounterModM(8, 3, has_ce=True, has_reset=True)
        u_counter(CE=edge_r, RESET=u_reset)
        load = burst & rising(u_counter.COUT)

        uart = UART(8)
        uart(CLK=cam.CLK, BAUD=baud, DATA=miso, LOAD=load) #quick hack to build

        # wire output
        wire(uart, cam.UART) 

        # generate signal for when transfer is done
        data_count = Counter(18, has_ce=True)
        tx_done = SRFF(has_ce=True)
        # transfer has size 153600 bytes, first 2 bytes are ignored
        tx_done(EQ(18)(data_count.O, bits(153602, 18)), 0)
        wire(load, tx_done.CE)
        wire(load, data_count.CE)

        # wire output
        wire(tx_done, cam.DONE)
