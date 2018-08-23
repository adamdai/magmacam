from aetherling.modules.linebuffer import *
from aetherling.modules.reduce import *
import magma as m
from magma.clock import *
from magma.backend.coreir_ import CoreIRBackend
from magma.bitutils import *
from coreir.context import *
from magma.simulator.coreir_simulator import CoreIRSimulator
import coreir
from magma.scope import Scope
from mantle.coreir import DefineCoreirConst
from mantle import CounterModM, Decode, SIPO
from magma.frontend.coreir_ import GetCoreIRModule
from mantle.coreir.arith import *
from mantle.primitives import DeclareAdd

import sys
sys.path.insert(0, '../HX8K')
from mac import MAC

# convolution window size
x = 4
y = 4

# image size (height and width)
im_w = 16
im_h = 16

width = 1
TIN = m.Array(width, m.BitIn)
TOUT = m.Array(width, m.Out(m.Bit))

c = coreir.Context()
cirb = CoreIRBackend(c)
scope = Scope()

# Line Buffer interface
in_LB = m.Array(1, m.Array(1, TIN))  # one image row per clock
out_LB = m.Array(y, m.Array(x, TOUT))  # convolution window
imgType = m.Array(im_h, m.Array(im_w, TIN))  # image dimensions

# multiply-accumulate interface
in_MAC = m.Array(x*y, m.BitIn)
out_MAC = m.Out(m.Bit)

# Top level module: line buffer input, MAC output
args = ['I0', in_LB, 'I1', in_MAC, 'O', out_MAC, 'WE', m.BitIn, 'V', m.Out(m.Bit)] + \
        m.ClockInterface(False, False)
top = m.DefineCircuit('Convolution', *args)

# Line buffer declaration
lb = Linebuffer(cirb, in_LB, out_LB, imgType, True)
m.wire(top.I0, lb.I)
m.wire(top.WE, lb.wen)

# MAC declaration
mac = MAC(x*y)

print("wiring lb")
# connect up linebuffer to MAC img input
k = 0
for i in range(x):
    for j in range(y):
        m.wire(lb.out[i][j][0], mac.I0[k])
        k += 1

print("wiring weights")
# wire weights to second MAC input
m.wire(top.I1, mac.I1)

m.wire(top.O, mac.O)
m.wire(top.V, lb.valid)

m.EndCircuit()

module = GetCoreIRModule(cirb, top)
module.save_to_file("convolution.json")

print("done")
