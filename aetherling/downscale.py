from aetherling.modules.linebuffer import *
from aetherling.modules.reduce import *
import magma as m
from magma.clock import *
from magma.backend.coreir_ import CoreIRBackend
from magma.bitutils import *
from coreir.context import *
from magma.simulator.coreir_simulator import CoreIRSimulator
import coreir
from mantle.coreir import DefineCoreirConst
from mantle import CounterModM, Decode, SIPO
from magma.frontend.coreir_ import GetCoreIRModule
from mantle.coreir.arith import *
from mantle.primitives import DeclareAdd

# downscale factor (a x b)
a = 20
b = 15

# image dimensions (height and width)
im_w = 320
im_h = 240

# 8-bit values but extend to 16-bit to avoid carryover in addition
width = 16
TIN = m.Array(width, m.BitIn)
TOUT = m.Array(width, m.Out(Bit))

# Line Buffer interface
inType = m.Array(1, m.Array(1, TIN))  # one pixel in per clock
outType = m.Array(b, m.Array(a, TOUT))  # downscale window
imgType = m.Array(im_h, m.Array(im_w, TIN))  # image dimensions

# Reduce interface
inType2 = m.In(m.Array(a*b, TIN))
outType2 = TOUT

# n-bit UART transmitter
def DefineDownscale(cirb):
    class _Downscale(m.Circuit):
        name = "Downscale"
        IO = ['CLK', m.In(m.Clock), 'I', inType, 'O', outType2, 'WE', m.BitIn, 'V', m.Out(m.Bit)]

        @classmethod
        def definition(io):
            # cirb = CoreIRBackend(c)

            # Line buffer declaration
            lb = Linebuffer(cirb, inType, outType, imgType, True)
            m.wire(lb.I, io.I)
            m.wire(lb.wen, io.WE)

            # Reduce declaration
            red = ReduceParallel(cirb, a*b, renameCircuitForReduce(DeclareAdd(width)))
            # additive identity
            coreirConst = DefineCoreirConst(width, 0)()

            # flatten linebuffer output and wire to reduce parallel input
            for i in range(b):
                for j in range(a):
                    k = a * i + j
                    m.wire(red.I.data[k], lb.out[i][j])

            m.wire(red.I.identity, coreirConst.O)
            m.wire(io.O, red.out)
            m.wire(io.V, lb.valid)

    return _Downscale


def Downscale(c, **kwargs):
    return DefineDownscale(c)(**kwargs)

