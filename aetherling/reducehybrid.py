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

width = 16

#***************************************************************************#

addID = DefineCoreirConst(width, 0)()
rpp = ReducePartiallyParallel(cirb, 8, 2, renameCircuitForReduce(DeclareAdd(width)))

m.wire(addID.out, rpp.C)

m.EndCircuit()

module = GetCoreIRModule(cirb, rpp)
module.save_to_file("reducehybrid.json")

