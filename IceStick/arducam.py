import magma as m
from magma.bitutils import int2seq
from mantle.util.edge import falling, rising
import mantle
from rom import ROM16
from uart import UART

trigger = m.VCC  # maybe tie to GPIO later

# ArduCAM start capture sequence
init = [
    # Change MCU mode
    m.array(int2seq(0x8200, 16)),
    # Start capture
    m.array(int2seq(0x8401, 16)),
    m.array(int2seq(0x8401, 16)),
    m.array(int2seq(0x8402, 16)),
    # check capture completion flag
    m.array(int2seq(0x4100, 16)),
    # Read image length
    m.array(int2seq(0x4200, 16)),
    m.array(int2seq(0x4300, 16)),
    m.array(int2seq(0x4400, 16)),
    # burst read
    m.array(int2seq(0x3CFF, 16)),
    m.array(int2seq(0x0000, 16)),
    m.array(int2seq(0x0000, 16)),
    m.array(int2seq(0x0000, 16)),
    m.array(int2seq(0x0000, 16)),
    m.array(int2seq(0x0000, 16)),
    m.array(int2seq(0x0000, 16)),
    m.array(int2seq(0x0000, 16))
]


class ArduCAM(m.Circuit):
    name = "ArduCAM"
    IO = ['CLK', m.In(m.Clock), 'SCK', m.In(m.Bit), 'MISO', m.In(m.Bit),
          'EN', m.Out(m.Bit), 'MOSI', m.Out(m.Bit), 'DATA', m.Out(m.Bits(8)),
          'VALID', m.Out(m.Bit), 'UART', m.Out(m.Bit), 'DONE', m.Out(m.Bit)]

    @classmethod
    def definition(cam):
        edge_f = falling(cam.SCK)
        edge_r = rising(cam.SCK)

        # ROM to store commands
        rom_index = mantle.Counter(4, has_ce=True)
        rom = ROM16(4, init, rom_index.O)

        # Message length is 16 bits, setup counter to generate done signal
        # after EOM
        done_counter = mantle.Counter(5, has_ce=True, has_reset=True)
        count = done_counter.O
        done = mantle.Decode(16, 5)(count)

        # State machine to generate run signal (enable)
        run = mantle.DFF(has_ce=True)
        run_n = mantle.LUT3([0, 0, 1, 0, 1, 0, 1, 0])
        run_n(done, trigger, run)
        run(run_n)
        m.wire(edge_f, run.CE)

        # Reset the message length counter after done
        run_reset = done | ~run.O
        done_counter(CE=edge_r, RESET=run_reset)

        # State variables for high-level state machine
        ready = ~run.O & edge_f
        start = mantle.ULE(4)(rom_index.O, m.uint(3, 4))
        burst = mantle.UGE(4)(rom_index.O, m.uint(9, 4))

        # Shift register to store 16-bit command|data to send
        mosi = mantle.PISO(16, has_ce=True)
        # SPI enable is negative of load-don't load and shift out data at the
        # same time
        enable = trigger & ~run.O & ~burst
        mosi(~burst, rom.O, enable)
        m.wire(edge_f, mosi.CE)

        # Shit register to read in 8-bit data
        miso = mantle.SIPO(8, has_ce=True)
        miso(cam.MISO)
        valid = ~enable & edge_r
        m.wire(valid, miso.CE)

        # Capture done state variable
        cap_done = mantle.SRFF(has_ce=True)
        cap_done(mantle.EQ(8)(miso.O, m.bits(0x08, 8)), 0)
        m.wire(enable & edge_r, cap_done.CE)

        # Use state variables to determine what commands are sent (how)
        increment = ready & (start | cap_done.O) & ~burst
        m.wire(increment, rom_index.CE)

        # wire outputs
        m.wire(enable, cam.EN)
        m.wire(mosi.O, cam.MOSI)
        m.wire(miso.O, cam.DATA)
        m.wire(burst,  cam.VALID)

        # --------------------------UART OUTPUT---------------------------- #

        # run UART at 2x SPI rate to allow it to keep up
        baud = edge_r | edge_f

        # reset when SPI burst read (image transfer) begins
        ff = mantle.FF(has_ce=True)
        m.wire(edge_r, ff.CE)
        u_reset = burst & ~ff(burst)

        # UART data out every 8 bits
        u_counter = mantle.CounterModM(8, 3, has_ce=True, has_reset=True)
        u_counter(CE=edge_r, RESET=u_reset)
        load = burst & rising(u_counter.COUT)

        uart = UART(8)
        uart(CLK=cam.CLK, BAUD=baud, DATA=miso, LOAD=load)

        # wire output
        m.wire(uart, cam.UART)

        # generate signal for when transfer is done
        data_count = mantle.Counter(18, has_ce=True)
        tx_done = mantle.SRFF(has_ce=True)
        # transfer has size 153600 bytes, first 2 bytes are ignored
        tx_done(mantle.EQ(18)(data_count.O, m.bits(153602, 18)), 0)
        m.wire(load, tx_done.CE)
        m.wire(load, data_count.CE)

        # wire output
        m.wire(tx_done, cam.DONE)
