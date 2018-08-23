import magma as m
import mantle
from loam.boards.hx8kboard import HX8KBoard
from mantle.util.compressor import DefinePopCount
from mantle.lattice.mantle40 import DefineUGE
from uart import UART
from mac import MAC, DefineMAC 
from magma.simulator import PythonSimulator

# hx8kboard = HX8KBoard()
# hx8kboard.Clock.on()

# hx8kboard.J2[9].output().on()
# hx8kboard.J2[10].output().on()
# hx8kboard.J2[11].output().on()
# hx8kboard.J2[12].output().on()

# main = hx8kboard.main()

u = m.bits(int('0000', 2), 4)
v = m.bits(int('1111', 2), 4)

mac = DefineMAC(4)

print(mac)
simulator = PythonSimulator(mac)

simulator.set_value(mac.I0, u)
simulator.set_value(mac.I1, v)
simulator.evaluate()
print('pop: ', simulator.get_value(mac.P))
print('out: ', simulator.get_value(mac.O))

# comp = DefineUGE(4)
# simulator = PythonSimulator(comp)

# simulator.set_value(comp.I0, u)
# simulator.set_value(comp.I1, v)
# simulator.evaluate()
# print('out: ', simulator.get_value(comp.O))









