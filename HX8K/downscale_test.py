import magma as m
from magma.bitutils import int2seq
import mantle
from rom import ROM8, ROM16
from loam.boards.hx8kboard import HX8KBoard
from uart import UART


# input image dimensions (height and width)
wi = 320
hi = 240

# output image dimenstions
wo = 16
ho = 16

# downscale factor/window size (20 x 15)
a = wi//wo
b = hi//ho

# size of buffer for storing image n rows at a time
buf_size = wi * b - 1  # 4800 - 1 = 4799

hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

main = hx8kboard.main()

# "test" data
init = [m.uint(i, 16) for i in range(16)]
printf = mantle.Counter(4, has_ce=True)
rom = ROM16(4, init, printf.O)

# baud for uart output
clock = mantle.CounterModM(103, 8)
baud = clock.COUT

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(baud, bit_counter.CE)

load = mantle.Decode(0, 5)(bit_counter.O)

valid_counter = mantle.CounterModM(buf_size, 13, has_ce=True)
m.wire(load & baud, valid_counter.CE)

valid_list = [wi * (b - 1) + i * a - 1 for i in range(1, wo + 1)]  # len = 16

valid = m.GND

for i in valid_list:
    valid = valid | mantle.Decode(i, 13)(valid_counter.O)

m.wire(load & baud, printf.CE)

px_val = rom.O

# register on input
st_in = mantle.Register(16, has_ce=True)
st_in(px_val)
m.wire(load, st_in.CE)

# ---------------------------STENCILING----------------------------- #

Downscale = m.DeclareCircuit(
            'Downscale',
            "I_0_0", m.In(m.Array(1, m.Array(1, m.Array(16, m.Bit)))),
            "WE", m.In(m.Bit), "CLK", m.In(m.Clock),
            "O", m.Out(m.Array(16, m.Bit)), "V", m.Out(m.Bit))

dscale = Downscale()

m.wire(st_in.O, dscale.I_0_0[0][0])
m.wire(1, dscale.WE)
m.wire(load, dscale.CLK)

add16 = mantle.Add(16)  # needed for Add16 definition


# ---------------------------UART OUTPUT----------------------------- #

uart_px = UART(16)
uart_px(CLK=main.CLKIN, BAUD=baud, DATA=px_val, LOAD=load)

uart_st = UART(16)
uart_st(CLK=main.CLKIN, BAUD=baud, DATA=dscale.O, LOAD=load)

m.wire(valid, main.J2_9)
m.wire(load, main.J2_10)
m.wire(uart_px.O, main.J2_11)
m.wire(uart_st.O, main.J2_12)
