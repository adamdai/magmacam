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
from mac import MAC

# convolution window size
x = 3
y = 3

# image size (height and width)
im_w = 16
im_h = 16

width = 1
TIN = m.Array(width, m.BitIn)
TOUT = m.Array(width, m.Out(m.Bit))

c = coreir.Context()
cirb = CoreIRBackend(c)

# Line Buffer interface
in_LB = m.Array(1, m.Array(1, TIN))  # one image row per clock
out_LB = m.Array(y, m.Array(x, TOUT))  # convolution window
imgType = m.Array(im_h, m.Array(im_w, TIN))  # image dimensions

# multiply-accumulate interface
in_MAC = m.Array(x*y, m.BitIn)
out_MAC = m.Out(m.Bit)

# weight input interface
in_W = m.Array(y, m.Array(x, TIN))

# Top level module: line buffer input, MAC output
args = ['I0', in_LB, 'I1', in_W, 'WE', m.BitIn,
        'O', out_MAC, 'V', m.Out(m.Bit)] + \
        m.ClockInterface(False, False)
conv = m.DefineCircuit('Convolution', *args)

# Line buffer declaration
lb = Linebuffer(cirb, in_LB, out_LB, imgType, True)
m.wire(conv.I0, lb.I)
m.wire(conv.WE, lb.wen)

# MAC declaration
mac = MAC(x*y)

# connect up linebuffer and weights to MAC input
k = 0
for i in range(y):
    for j in range(x):
        m.wire(lb.out[i][j][0], mac.I0[k])
        m.wire(conv.I1[i][j][0], mac.I1[k])
        k += 1

m.wire(conv.O, mac.O)
m.wire(conv.V, lb.valid)

m.EndCircuit()

# module = GetCoreIRModule(cirb, conv)
# module.save_to_file("convolution.json")

print("done")
