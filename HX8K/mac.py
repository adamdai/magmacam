import magma as m
import mantle
import math
from mantle.util.compressor import PopCount
from magma.bitutils import log2

# n-bit binary multiply-accumulate circuit
# given two n-bit values, first computes the XNOR 
# then computes the popcount of the n-bit result, giving a logn-bit value p
# final binary output value is computed as sign(2*p - n), i.e.
# - 1 if 2*p >= n
# - 0 if 2*p < n
# also outputs the logn-bit result of the popcount used by the final FC layer
def DefineMAC(n):
    class _MAC(m.Circuit):
        name = "MAC" + str(n)
        logn = log2(n) + 1
        IO = ['CLK', m.In(m.Clock), 'I0', m.In(m.Bits(n)), 
              'I1', m.In(m.Bits(n)), 'P', m.Out(m.Bits(logn)),
              'T0', m.Out(m.Bits(logn+1)), 'T1', m.Out(m.Bits(logn+1)),
              'O', m.Out(m.Bit)]

        @classmethod
        def definition(io):
            # XNOR for binary affine mapped multiplication
            mul = mantle.NXOr(height=2, width=n)
            m.wire(mul.I0, io.I0)
            m.wire(mul.I1, io.I1)

            pop = PopCount(n)

            m.wire(mul.O, pop.I)
            m.wire(pop.O, io.P)

            width = log2(n)+2
            sign = mantle.UGE(width)
            m.wire(m.bits(n, width), sign.I0)
            m.wire(m.zext(pop.O, 1), sign.I1)

            m.wire(m.zext(pop.O, 1), io.T0)
            m.wire(m.bits(n, width), io.T1)

            # m.wire(io.I0, sign.I0)
            # m.wire(io.I1, sign.I1)

            m.wire(sign.O, io.O)

    return _MAC


def MAC(n, **kwargs):
    return DefineMAC(n)(**kwargs)
