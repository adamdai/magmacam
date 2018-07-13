from magma import *
from magma.bitutils import int2seq
from mantle import *
from rom import ROM8
from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()
icestick.TX.output().on()
for i in range(2):
    icestick.J3[i].output().on()

main = icestick.main()

valid = 1

#test RGB565 data
init = [array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8)), #(1,1): black
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(1,2): white
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(1,3): white
        array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8)), #(1,4): black
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(2,1): white
        array(int2seq(0x14, 8)), array(int2seq(0x15, 8)), #(2,2): black
        array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8)), #(2,3): black
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(2,4): white
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(3,1): white
        array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8)), #(3,2): black
        array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8)), #(3,3): black
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(3,4): white
        array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8)), #(4,1): black
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(4,2): white
        array(int2seq(0xE1, 8)), array(int2seq(0x09, 8)), #(4,3): white
        array(int2seq(0x5A, 8)), array(int2seq(0xD7, 8))] #(4,4): black


printf = Counter(2, has_ce=True)
rom = ROM8(2, init, printf.O)

data = array([rom.O[7], rom.O[6], rom.O[5], rom.O[4],
              rom.O[3], rom.O[2], rom.O[1], rom.O[0], 0] )

clock = CounterModM(16, 8)
baud = clock.COUT

done_counter = Counter(4, has_ce=True, has_reset=True)
done = counter.COUT

wire(baud,       main.J3[0])
#wire(run,        main.J3[2])
#wire(done,       main.J3[3])
wire(shift,      main.TX)
#wire(ready,      main.J3[5])
#wire(valid,      main.J3[6])
#wire(count,      main.J3[4:8])
