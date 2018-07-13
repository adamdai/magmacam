from magma import *
from magma.bitutils import int2seq
from mantle import *
from rom import ROM8
from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()
icestick.TX.output().on()
for i in range(4):
    icestick.J3[i].output().on()

main = icestick.main()

valid = 1

#init = [array(int2seq(ord(c), 8)) for c in 'hello, world  \r\n']
init = [array(int2seq(0x12, 8)), array(int2seq(0x13, 8)),
        array(int2seq(0x14, 8)), array(int2seq(0x15, 8))]

printf = Counter(2, has_ce=True)
rom = ROM8(2, init, printf.O)

byte = bits(0x55, 8)

data = array([byte[7], byte[6], byte[5], byte[4],
              byte[3], byte[2], byte[1], byte[0], 0] )

clock = CounterModM(103, 8)
baud = clock.COUT

counter = Counter(4, has_ce=True, has_reset=True)
count = counter.O
done = Decode(15, 4)(count)

run = DFF(has_ce=True)
run_n = LUT3([0,0,1,0, 1,0,1,0])
run_n(done, valid, run)
run(run_n)
wire(baud, run.CE)

reset = LUT2(I0&~I1)(done, run)
counter(CE=baud, RESET=reset)

shift = PISO(9, has_ce=True)
load = LUT2(I0&~I1)(valid,run)
shift(1,data,load)
wire(baud, shift.CE)

ready = LUT2(~I0 & I1)(run, baud)
wire(ready, printf.CE)

#wire(main.CLKIN, main.J3[0])
wire(baud,       main.J3[0])
wire(load,        main.J3[1])
wire(ready,       main.J3[2])
wire(shift,      main.J3[3])
#wire(ready,      main.J3[5])
#wire(valid,      main.J3[6])
#wire(count,      main.J3[4:8])


