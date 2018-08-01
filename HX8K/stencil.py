import magma as m
from magma.bitutils import int2seq
import mantle
from rom import ROM8, ROM16
from loam.boards.hx8kboard import HX8KBoard
from uart import UART


hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

main = hx8kboard.main()

# "test" data
init = [m.uint(n, 16) for n in range(16)]
printf = mantle.Counter(4, has_ce=True)
rom = ROM16(4, init, printf.O)

# baud for uart output
clock = mantle.CounterModM(103, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)

valid_counter = mantle.CounterModM(8, 3, has_ce=True)
m.wire(load & baud, valid_counter.CE)

valid_list = [5, 7]

valid = m.GND

for i in valid_list:
    valid = valid | mantle.Decode(i, 3)(valid_counter.O)

m.wire(load & baud, printf.CE)

px_val = rom.O

st_in = mantle.Register(16, has_ce=True)
st_in(px_val)
m.wire(load, st_in.CE)

# ---------------------------STENCILING----------------------------- #

STEN = m.DeclareCircuit(
            'STEN',
            "I_0_0", m.In(m.Array(1, m.Array(1, m.Array(16, m.Bit)))),
            "O", m.Out(m.Array(16, m.Bit)),
            "WE", m.In(m.Bit),
            "V", m.Out(m.Bit),
            "CLK", m.In(m.Clock),
            "L00", m.Out(m.Array(16, m.Bit)),
            "L01", m.Out(m.Array(16, m.Bit)),
            "L10", m.Out(m.Array(16, m.Bit)),
            "L11", m.Out(m.Array(16, m.Bit)))

stencil = STEN()

m.wire(st_in.O, stencil.I_0_0[0][0])
m.wire(1, stencil.WE)
m.wire(load, stencil.CLK)

add16 = mantle.CounterModM(1, 16)  # needed for Add16 definition

# ---------------------------UART OUTPUT----------------------------- #

uart_px = UART(16)
uart_px(CLK=main.CLKIN, BAUD=baud, DATA=px_val, LOAD=load)

uart_st = UART(16)
uart_st(CLK=main.CLKIN, BAUD=baud, DATA=stencil.O, LOAD=load)

uart_L00 = UART(16)
uart_L00(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L00, LOAD=load)

uart_L01 = UART(16)
uart_L01(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L01, LOAD=load)

uart_L10 = UART(16)
uart_L10(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L10, LOAD=load)

uart_L11 = UART(16)
uart_L11(CLK=main.CLKIN, BAUD=baud, DATA=stencil.L11, LOAD=load)

uart_reg = UART(16)
uart_reg(CLK=main.CLKIN, BAUD=baud, DATA=st_in.O, LOAD=load)

m.wire(valid,       main.J2_9)
m.wire(load,        main.J2_10)
m.wire(uart_px.O,   main.J2_11)
m.wire(uart_st.O,   main.J2_12)
# m.wire(uart_L00.O,  main.J3[4])
# m.wire(uart_L01.O,  main.J3[5])
# m.wire(uart_L10.O,  main.J3[6])
# m.wire(uart_L11.O,  main.J3[7])
