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

m = 2 
n = 2
mxn = m*n

b = 16
TIN = Array(b, BitIn)
TOUT = Array(b, Out(Bit))

# interface
inType = In(Array(m, TIN))
outType = TOUT

# test circuit has line buffer's input and reduce's output
args = ['I', inType, 'O', outType, 'WE', BitIn, 'V', Out(Bit), 'CLKOut', Out(Clock)] + ClockInterface(False, False)
reducePS = DefineCircuit('ReduceHybrid', *args)

# reduce Parallel
reducePar = ReduceParallel(cirb, m, renameCircuitForReduce(DeclareAdd(b)))
coreirConst = DefineCoreirConst(b, 0)()

# reduce sequential
reduceSeq = ReduceSequential(cirb, n, renameCircuitForReduce(DefineAdd(b)))

# top level input fed to reduce parallel input
wire(reducePS.I, reducePar.I.data)
wire(reducePar.I.identity, coreirConst.out)

# reduce parallel output fed to reduce sequential input
wire(reducePar.out, reduceSeq.I)

# output of reduce sequential fed to top level output
wire(reduceSeq.out, reducePS.O)
wire(reduceSeq.valid, reducePS.V)
wire(reducePS.CLK, reducePS.CLKOut)

EndCircuit()

module = GetCoreIRModule(cirb, reduceHybrid)
module.save_to_file("reducehybrid.json")

print("done")