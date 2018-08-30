import magma as m
from magma.backend.coreir_ import CoreIRBackend
from coreir.context import *
from magma.simulator.coreir_simulator import CoreIRSimulator
from magma.frontend.coreir_ import GetCoreIRModule
from magma.backend.coreir_ import compile
from mantle.coreir.type_helpers import Term
import coreir

from downscale import Downscale

def wrap(inst, cirb):
    for io in inst.IO:
        argtype = inst.IO.__getitem__(inst.IO, io)
        print(io, argtype, argtype.isoutput())
        if argtype.isoutput():
            t = Term(cirb, 1)
            m.wire(getattr(inst, io), t)
        # else:
        #     m.wire(getattr(inst, io), 0)

c = coreir.Context()
cirb = CoreIRBackend(c)

main = m.DefineCircuit('Main')

dscale = Downscale(cirb)
wrap(dscale, cirb)

m.EndCircuit()

# compile(main, "include.json", c)
