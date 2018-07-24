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


c = coreir.Context()
cirb = CoreIRBackend(c)
scope = Scope()

TIN = Array(8, BitIn)
TOUT = Array(8, Out(Bit))

# Line Buffer interface
inType = Array(1, Array(1, TIN))
outType = Array(2, Array(2, TOUT))
imgType = Array(4, Array(4, TIN))


# Reduce interface
inType2 = In(Array(4, TIN))
outType2 = Out(Array(8, Bit))

# Test circuit has line buffer's input and reduce's output
args = ['I', inType, 'O', outType2, 'WE', BitIn, 'V', Out(Bit), 'CLKOut', Out(Clock),
        'L00', TOUT, 'L01', TOUT, 'L10', TOUT, 'L11', TOUT] + ClockInterface(False, False)
testcircuit = DefineCircuit('STEN', *args)

# Line buffer declaration
lb = Linebuffer(cirb, inType, outType, imgType, True)
wire(lb.I, testcircuit.I)
wire(lb.wen, testcircuit.WE)

# # Reduce declaration
reducePar = ReduceParallel(cirb, 4, renameCircuitForReduce(DeclareAdd(8)))
coreirConst = DefineCoreirConst(8, 0)()
wire(reducePar.I.data[0], lb.out[0][0])
wire(reducePar.I.data[1], lb.out[0][1])
wire(reducePar.I.data[2], lb.out[1][0])
wire(reducePar.I.data[3], lb.out[1][1])
wire(reducePar.I.identity, coreirConst.out)
wire(testcircuit.O, reducePar.out)
wire(testcircuit.V, lb.valid)
wire(testcircuit.CLKOut, testcircuit.CLK)

wire(lb.out[0][0], testcircuit.L00)
wire(lb.out[0][1], testcircuit.L01)
wire(lb.out[1][0], testcircuit.L10)
wire(lb.out[1][1], testcircuit.L11)


EndCircuit()

module = GetCoreIRModule(cirb, testcircuit)
module.save_to_file("linebuffer.json")

print("done")