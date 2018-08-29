import magma as m
from magma.backend.coreir_ import CoreIRBackend
from coreir.context import *
from magma.simulator.coreir_simulator import CoreIRSimulator
from magma.frontend.coreir_ import GetCoreIRModule
from magma.backend.coreir_ import compile
import coreir

from downscale import Downscale

c = coreir.Context()

main = m.DefineCircuit('Main')

dscale = Downscale(c)

m.EndCircuit()

compile(main, "include.json", c)
