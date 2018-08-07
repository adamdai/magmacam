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

a = 2
b = 4

width = 16
TIN = m.Array(width, m.BitIn)
TOUT = m.Array(width, m.Out(m.Bit))

# interface
inType = m.In(m.Array(a, TIN))
outType = TOUT

# # test circuit has line buffer's input and reduce's output
# args = ['I', inType, 'O', outType, 'WE', m.BitIn, 'V', m.Out(m.Bit)] + \
#         m.ClockInterface(False, False)
# reduceHybrid = m.DefineCircuit('ReduceHybrid', *args)

# # reduce Parallel
# reducePar = ReduceParallel(cirb, a, renameCircuitForReduce(DeclareAdd(width)))
# coreirConst = DefineCoreirConst(width, 0)()

# # reduce sequential
# reduceSeq = ReduceSequential(cirb, b, renameCircuitForReduce(DefineAdd(width)))

# # top level input fed to reduce parallel input
# m.wire(reduceHybrid.I, reducePar.I.data)
# m.wire(reducePar.I.identity, coreirConst.out)

# # reduce parallel output fed to reduce sequential input
# m.wire(reducePar.out, reduceSeq.I)

# # output of reduce sequential fed to top level output
# m.wire(reduceSeq.out, reduceHybrid.O)
# m.wire(reduceSeq.valid, reduceHybrid.V)

rpp = ReducePartiallyParallel(cirb, 8, 2, DeclareAdd(width))

m.EndCircuit()

module = GetCoreIRModule(cirb, rpp)
module.save_to_file("reducehybrid.json")

print("done")
