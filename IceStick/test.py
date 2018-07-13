from magma import *
set_mantle_target("ice40")
from mantle import*
from magma.simulator import PythonSimulator
from bit_vector import BitVector

Add = DefineAdd(16)
print(Add)
add_sim = PythonSimulator(Add)

Or = DefineOr(width=8)
print(Or)
or_sim = PythonSimulator(Or)

Shift = DefineLSL(8, 4)
print(Shift)
lsl_sim = PythonSimulator(Shift)

high = bits(0x01,8)
#high = BitVector(0x01,8)
low = bits(0x02,8)
zeros = bits(0,8)

rval = uint(1,16)
gval = uint(2,16)
bval = uint(3,16)

high_x = uint(concat(high, zeros))
low_x = uint(concat(low, zeros))

add_sim.set_value(Add.I0, bval)
add_sim.set_value(Add.I1, gval)
add_sim.evaluate()
print(add_sim.get_value(Add.O))

# or_sim.set_value(Or.I0, high)
# or_sim.set_value(Or.I1, low)
# or_sim.evaluate()
# print(or_sim.get_value(Or.O))

# lsl_sim.set_value(Shift.I, high)
# lsl_sim.evaluate()
# print(lsl_sim.get_value(Shift.O))
