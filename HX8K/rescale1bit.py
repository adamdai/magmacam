import magma as m
import mantle
from mantle.util.edge import falling, rising
from mantle import I0, I1
from uart import UART


# input image dimensions (height and width)
wi = 352
hi = 288

# output image dimenstions
wo = 32
ho = 32

# downscale factor/window size (11 x 9)
a = wi//wo
b = hi//ho

# size of buffer for storing image n rows at a time
buf_size = wi * b  # 3168

# width of pixel data
width = 16

#threshold for determining black/white 
THRESH = 750  # (max = 125 * 16 = 2000)


def reverse(bits):
    n = len(bits)
    return m.bits([bits[n-1-i] for i in range(n)])


class Rescale(m.Circuit):
    name = "Rescale"
    IO = ['CLK', m.In(m.Clock), 'LOAD', m.In(m.Bit), 'DATA', m.In(m.Bits(width)),
          'SCK', m.In(m.Bit),
          'O', m.Out(m.Bit), 'VALID', m.Out(m.Bit)]

    @classmethod
    def definition(io):
        load = io.LOAD
        baud = rising(io.SCK) | falling(io.SCK)

        valid_counter = mantle.CounterModM(buf_size, 12, has_ce=True)
        m.wire(load & baud, valid_counter.CE)

        valid_list = [wi * (b - 1) + i * a - 1 for i in range(1, wo + 1)]  # len = 32

        valid = m.GND

        for i in valid_list:
            valid = valid | mantle.Decode(i, 12)(valid_counter.O)

        # register on input
        st_in = mantle.Register(width, has_ce=True)
        st_in(io.DATA)
        m.wire(load, st_in.CE)

        # --------------------------DOWNSCALING----------------------------- #
        # downscale the image from 352x288 to 32x32
        Downscale = m.DeclareCircuit(
                    'Downscale',
                    "I_0_0", m.In(m.Array(1, m.Array(1, m.Array(width, m.Bit)))),
                    "WE", m.In(m.Bit), "CLK", m.In(m.Clock),
                    "O", m.Out(m.Array(width, m.Bit)), "V", m.Out(m.Bit))

        dscale = Downscale()

        m.wire(st_in.O, dscale.I_0_0[0][0])
        m.wire(1, dscale.WE)
        m.wire(load, dscale.CLK)

        add16 = mantle.Add(width)  # needed for Add16 definition

        # threshold the downscale output
        px_bit = mantle.ULE(16)(dscale.O, m.uint(THRESH, 16)) & valid

        # ---------------------------UART OUTPUT----------------------------- #

        m.wire(px_bit, io.O)
        m.wire(valid, io.VALID)


