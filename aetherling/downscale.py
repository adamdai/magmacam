from aetherling.modules.linebuffer import *
from aetherling.modules.reduce import ReduceSequential, ReduceParallel, renameCircuitForReduce
from magma import *
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

# downscale factor (m x n)
m = 20
n = 15

# image dimensions (height and width)
im_w = 320
im_h = 240

c = coreir.Context()
cirb = CoreIRBackend(c)
scope = Scope()

# 8-bit pixels (grayscale) but extend to 16-bit to avoid carryover in addition
b = 16
TIN = Array(b, BitIn)
TOUT = Array(b, Out(Bit))

# Line Buffer interface
inType = Array(1, Array(1, TIN)) # one pixel in per clock
outType = Array(n, Array(m, TOUT)) # downscale window
imgType = Array(im_h, Array(im_w, TIN)) # image dimensions

# Reduce interface
inType2 = In(Array(m*n, TIN))
outType2 = TOUT

# Top level module: line buffer input, reduce output
args = ['I', inType, 'O', outType2, 'WE', BitIn, 'V', Out(Bit)] + ClockInterface(False, False)
top = DefineCircuit('Downscale', *args)

# Line buffer declaration
lb = Linebuffer(cirb, inType, outType, imgType, True)
wire(lb.I, top.I)
wire(lb.wen, top.WE)

# Reduce declaration
red = ReduceParallel(cirb, m*n, renameCircuitForReduce(DeclareAdd(b)))
# additive identity
coreirConst = DefineCoreirConst(b, 0)()

# flatten linebuffer output and wire to reduce parallel input
for i in range(n):
	for j in range(m):
		k = m * i + j
		wire(red.I.data[k], lb.out[i][j])

wire(red.I.identity, coreirConst.out)
wire(top.O, red.out)
wire(top.V, lb.valid)

EndCircuit()

module = GetCoreIRModule(cirb, top)
module.save_to_file("downscale.json")

print("done")