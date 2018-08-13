import magma as m
from magma.bitutils import int2seq
import mantle
from rom import ROM8, ROM16
from loam.boards.hx8kboard import HX8KBoard
from uart import UART


a = 2
b = 2

width = 16
TIN = m.Array(width, m.BitIn)
TOUT = m.Array(width, m.Out(m.Bit))

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()
hx8kboard.D1.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

main = hx8kboard.main()

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
            'Reduce_n8_p2_oprenamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___', 
            'CLK', m.In(m.Clock), 'I_0', TIN, 'I_1', TIN, 'WE', m.BitIn,
            'O', TOUT, 'V', m.Out(m.Bit))

redHybrid = ReduceHybrid()

m.wire(m.bits(1,16), redHybrid.I_0)
m.wire(m.bits(1,16), redHybrid.I_1)

m.wire(1, redHybrid.WE)
m.wire(load, redHybrid.CLK)

#add16 = mantle.Add(16)  # needed for Add16 definition


# ---------------------------UART OUTPUT----------------------------- #

uart_red = UART(16)
uart_red(CLK=main.CLKIN, BAUD=baud, DATA=redHybrid.O, LOAD=load)

uart_in = UART(16)
uart_in(CLK=main.CLKIN, BAUD=baud, DATA=rom.O, LOAD=load)

m.wire(redHybrid.V, main.J2_9)
m.wire(load, main.J2_10)
m.wire(uart_red.O, main.J2_11)
m.wire(uart_in.O, main.J2_12)

m.wire(m.VCC, main.D1)
