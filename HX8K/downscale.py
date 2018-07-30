import magma as m
import mantle
from mantle.util.edge import falling, rising
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


class Downscale(m.Circuit):
    name = "Downscale"
    IO = ['CLK', m.In(m.Clock), 'LOAD', m.In(m.Bit), 'DATA', m.In(m.Bits(16)),
          'BAUD', m.In(m.Bit),
          'ROW', m.Out(m.Bits(4)), 'DONE', m.Out(m.Bit), 'UART', m.Out(m.Bit)]

    @classmethod
    def definition(io):
        load = io.LOAD
        baud = io.BAUD

        valid_counter = mantle.CounterModM(buf_size, 13, has_ce=True)
        m.wire(load & baud, valid_counter.CE)

        valid_list = [wi * (b - 1) + i * a - 1 for i in range(1, wo + 1)]  # len = 16

        valid = m.GND

        for i in valid_list:
            valid = valid | mantle.Decode(i, 13)(valid_counter.O)

        # register on input
        st_in = mantle.Register(16, has_ce=True)
        st_in(io.DATA)
        m.wire(load, st_in.CE)

        # --------------------------DOWNSCALING----------------------------- #
        # downscale the image from 320x240 to 16x16
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

        # --------------------------FILL IMG RAM--------------------------- #
        # each valid output of dscale represents an entry of 16x16 binary image
        # accumulate each group of 16 entries into a 16-bit value representing a row
        col = mantle.Counter(4, has_ce=True)

        row_full= mantle.SRFF(has_ce=True)
        row_full(mantle.EQ(4)(col.O, m.bits(15, 4)), 0)
        m.wire(falling(dscale.V), row_full.CE)
        col_ce = rising(dscale.V) & ~row_full.O
        m.wire(col_ce, col.CE)


        row = mantle.Counter(4, has_ce=True)

        img_full = mantle.SRFF(has_ce=True)
        img_full(mantle.EQ(4)(row.O, m.bits(15, 4)), 0)
        m.wire(falling(col.COUT), img_full.CE)
        row_ce = rising(col.COUT) & ~img_full.O
        m.wire(row_ce, row.CE)

        # ---------------------------UART OUTPUT----------------------------- #

        uart_st = UART(16)
        uart_st(CLK=io.CLK, BAUD=baud, DATA=dscale.O, LOAD=load)

        m.wire(row.O, io.ROW)
        m.wire(img_full.O, io.DONE)
        m.wire(uart_st.O, io.UART)
