from aetherling.modules.linebuffer import *
from magma import *
from magma.clock import *
from magma.backend.coreir_ import CoreIRBackend
from magma.bitutils import *
from coreir.context import *
from magma.simulator.coreir_simulator import CoreIRSimulator
import coreir
from magma.scope import Scope
from mantle import CounterModM, Decode, SIPO


c = coreir.Context()
cirb = CoreIRBackend(c)
scope = Scope()

# Line Buffer interface
inType = Array(1, Array(1, Array(8, BitIn)))
outType = Array(2, Array(2, Array(8, Out(Bit))))
imgType = Array(4, Array(4, Array(8, Out(Bit))))
args = ['I', inType, 'O', outType] + ClockInterface(False, False)

testcircuit = DefineCircuit('lb1_3_Test', *args)
test_in = SIPO(8)

# Reduce interface
inType2 = In(Array(4, Array(8, BitIn)))
outType2 = Out(Array(8, Bit))

# Line buffer declaration
lb = Linebuffer(cirb, inType, outType, imgType, False)
wire(lb.I[0][0], test_in.O)
wire(1, lb.wen)

# # Reduce declaration
# reducePar = ReduceParallel(cirb, 4, renameCircuitForReduce(DefineAdd(width)))
# coreirConst = DefineCoreirConst(8, 0)()
# wire(reducePar.I.data[0], lb.out[0][0])
# wire(reducePar.I.data[1], lb.out[0][1])
# wire(reducePar.I.data[2], lb.out[1][0])
# wire(reducePar.I.data[3], lb.out[1][1])
# wire(reducePar.I.identity, coreirConst.out)
#wire(testcircuit.O, reducePar.out)


EndCircuit()