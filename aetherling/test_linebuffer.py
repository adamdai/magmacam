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


c = coreir.Context()
cirb = CoreIRBackend(c)
scope = Scope()

TIN = m.Array(16, m.BitIn)
TOUT = m.Array(16, m.Out(Bit))

# Line Buffer interface
inType = m.Array(1, m.Array(1, TIN))
outType = m.Array(2, m.Array(2, TOUT))
imgType = m.Array(4, m.Array(4, TIN))

# Reduce interface
inType2 = m.In(m.Array(4, TIN))
outType2 = m.Out(m.Array(16, Bit))

# Test circuit has line buffer's input and reduce's output
args = ['I', inType, 'O', outType2, 'WE', BitIn, 'V', m.Out(m.Bit),
        'L00', TOUT, 'L01', TOUT, 'L10', TOUT, 'L11', TOUT] + \
        m.ClockInterface(False, False)
testcircuit = m.DefineCircuit('STEN', *args)

# Line buffer declaration
lb = Linebuffer(cirb, inType, outType, imgType, True)
m.wire(lb.I, testcircuit.I)
m.wire(lb.wen, testcircuit.WE)

# # Reduce declaration
reducePar = ReduceParallel(cirb, 4, renameCircuitForReduce(DeclareAdd(16)))
coreirConst = DefineCoreirConst(16, 0)()
m.wire(reducePar.I.data[0], lb.out[0][0])
m.wire(reducePar.I.data[1], lb.out[0][1])
m.wire(reducePar.I.data[2], lb.out[1][0])
m.wire(reducePar.I.data[3], lb.out[1][1])
m.wire(reducePar.I.identity, coreirConst.O)
m.wire(testcircuit.O, reducePar.out)
m.wire(testcircuit.V, lb.valid)

m.wire(lb.out[0][0], testcircuit.L00)
m.wire(lb.out[0][1], testcircuit.L01)
m.wire(lb.out[1][0], testcircuit.L10)
m.wire(lb.out[1][1], testcircuit.L11)


m.EndCircuit()

module = GetCoreIRModule(cirb, testcircuit)
module.save_to_file("linebuffer.json")

print("done")
