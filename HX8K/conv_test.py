import magma as m
import mantle
from rom import ROM8, ROM16
from uart import UART
from mantle.lattice.ice40 import ROMB, SB_LUT4
from mantle.util.edge import falling, rising
from loam.boards.hx8kboard import HX8KBoard

from wrapdecl import WrapDeclaration


hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

main = hx8kboard.main()

img_size = 16

img_list = [0, 0, 0, 0, 960, 4064, 48, 32, 96, 192, 192, 384, 768, 512, 1536, 0]

bmp = []
f = '{0:0'+str(img_size)+'b}'
for n in img_list:
    row = [1 if digit=='1' else 0 for digit in f.format(n)]
    bmp.extend(row)

num_data = m.array(bmp)

weights = m.array([m.array([m.array([0]), m.array([1]), m.array([0]), m.array([1])]),
                   m.array([m.array([1]), m.array([0]), m.array([1]), m.array([0])]),
                   m.array([m.array([0]), m.array([0]), m.array([0]), m.array([0])]),
                   m.array([m.array([0]), m.array([1]), m.array([0]), m.array([1])]),
                   m.array([m.array([1]), m.array([0]), m.array([1]), m.array([0])])])   

# decrease the frequency to avoid timing violation
counter = mantle.Counter(5)
sclk = counter.O[4]
baud = mantle.FF()(rising(sclk) | falling(sclk))

idx = mantle.Counter(9, has_ce=True)
# addr = rom_idx.O[:4]

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(rising(sclk), bit_counter.CE)

we = mantle.Decode(0, 5)(bit_counter.O)
load = rising(we)

full = mantle.SRFF(has_ce=True)
check = mantle.EQ(9)(idx.O, m.bits(256, 9))
full(check, 0)
m.wire(falling(sclk), full.CE)
rom_ce = load & ~full.O
m.wire(rom_ce, idx.CE)

data = m.array(m.bit(sclk))

# Convolution = m.DeclareCircuit(
#         'Convolution',
#         "I0_0_0", m.Array(1, m.Array(1, m.In(m.Bit))),
#         "I1", m.Array(4, m.Array(4, m.In(m.Bit))),
#         "WE", m.In(m.Bit), "CLK", m.In(m.Clock),
#         "O", m.Out(m.Bit), "V", m.Out(m.Bit))

Convolution = m.DeclareFromVerilogFile('build/convolution.v', module="Convolution")

module = WrapDeclaration(Convolution)

print(Convolution)
print(module)

conv = module()

m.wire(sclk, conv.CLK)
m.wire(data, conv.I0[0][0])
m.wire(weights, conv.I1)
m.wire(we, conv.WE)

m.wire(sclk,   main.J2_9)
m.wire(1,  main.J2_10) # valid
m.wire(conv.V,      main.J2_11)
m.wire(conv.O,      main.J2_12)
