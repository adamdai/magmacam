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

# Line Buffer interface
inType = Array(1, Array(1, Array(8, BitIn)))
outType = Array(2, Array(2, Array(8, Out(Bit))))
imgType = Array(16, Array(16, Array(8, Out(Bit))))


# Reduce interface
inType2 = In(Array(4, Array(8, BitIn)))
outType2 = Out(Array(8, Bit))

# Test circuit has line buffer's input and reduce's output
args = ['I', inType, 'O', outType2, 'CE', BitIn, 'V', Out(Bit), 'CLKOut', Out(Clock)] + ClockInterface(False, False)
testcircuit = DefineCircuit('STEN', *args)

# Line buffer declaration
lb = Linebuffer(cirb, inType, outType, imgType, True)
wire(lb.I, testcircuit.I)
#wire(lb.wen, testcircuit.CE)
wire(1, lb.wen)

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


EndCircuit()

module = GetCoreIRModule(cirb, testcircuit)
module.save_to_file("linebuffer.json")