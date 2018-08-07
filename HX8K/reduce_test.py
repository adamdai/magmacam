import magma as m
from magma.bitutils import int2seq
import mantle
from rom import ROM8, ROM16
from loam.boards.icestick import IceStick
from uart import UART


a = 2
b = 2

width = 16
TIN = m.Array(width, m.BitIn)
TOUT = m.Array(width, m.Out(m.Bit))


icestick = IceStick()
icestick.Clock.on()
icestick.D1.on()
for i in range(4):
    icestick.J3[i].output().on()

main = icestick.main()

# baud for uart output
clock = mantle.CounterModM(103, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)

# "test" data
init = [m.uint(i, 16) for i in range(16)]
printf = mantle.Counter(4, has_ce=True)
rom = ROM16(4, init, printf.O)
m.wire(load & baud, printf.CE)


#---------------------------STENCILING-----------------------------#

ReduceHybrid = m.DeclareCircuit(
            'ReduceHybrid', 
            'I_0', m.In(m.Array(a, TIN)), 'I_1', m.In(m.Array(a, TIN)),
            'O', TOUT, 'WE', m.BitIn, 'V', m.Out(m.Bit), 'CLK', m.In(m.Clock))

redHybrid = ReduceHybrid()

m.wire(rom.O, redHybrid.I_0[0])
m.wire(rom.O, redHybrid.I_1[0])

m.wire(1, redHybrid.WE)
m.wire(load, redHybrid.CLK)

add16 = mantle.Add(16)  # needed for Add16 definition


# ---------------------------UART OUTPUT----------------------------- #

uart_red = UART(16)
uart_red(CLK=main.CLKIN, BAUD=baud, DATA=redHybrid.O, LOAD=load)

uart_in = UART(16)
uart_in(CLK=main.CLKIN, BAUD=baud, DATA=rom.O, LOAD=load)

m.wire(redHybrid.V, main.J3[0])
m.wire(load, main.J3[1])
m.wire(uart_red.O, main.J3[2])
m.wire(uart_in.O, main.J3[3])

m.wire(m.VCC, main.D1)
