import magma as m
import mantle
from rom import ROM8, ROM16
from uart import UART
from conv import conv, MEM, ReadRom
from mantle.lattice.ice40 import ROMB, SB_LUT4
from mantle.util.edge import falling, rising
from loam.boards.hx8kboard import HX8KBoard

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm


hx8kboard = HX8KBoard()
hx8kboard.Clock.on()

hx8kboard.J2[9].output().on()
hx8kboard.J2[10].output().on()
hx8kboard.J2[11].output().on()
hx8kboard.J2[12].output().on()

main = hx8kboard.main()


img_list = [0, 0, 0, 0, 960, 4064, 48, 32, 96, 192, 192, 384, 768, 512, 1536, 0]

num_data = m.array([m.array(img_list[i], 16) for i in range(16)])

weights = m.array([m.array(int('0101', 2)),
                   m.array(int('1010', 2)),
                   m.array(int('0101', 2)),
                   m.array(int('1010', 2))])

# decrease the frequency to avoid timing violation
counter = mantle.Counter(5)
sclk = counter.O[4]
baud = mantle.FF()(rising(sclk) | falling(sclk))

rom_idx = mantle.Counter(5, has_ce=True)
addr = rom_idx.O[:4]

bit_counter = mantle.Counter(5, has_ce=True)
m.wire(rising(sclk), bit_counter.CE)

we = mantle.Decode(0, 5)(bit_counter.O)
load = rising(we)

full = mantle.SRFF(has_ce=True)
check = mantle.EQ(5)(rom_idx.O, m.bits(16, 5))
full(check, 0)
m.wire(falling(sclk), full.CE)
rom_ce = load & ~full.O
m.wire(rom_ce, rom_idx.CE)

rom = ROM16(4, num_data, addr)

uart = UART(4)
uart(CLK=main.CLKIN, BAUD=baud, DATA=addr, LOAD=load)

# downscale the image from 352x288 to 32x32
Convolution = m.DeclareCircuit(
        'Convolution',
        "I0_0", m.Array(1, m.Array(im_w, m.In(m.Bit))),
        "I1_0", m.Array(1, m.Array(im_w, m.In(m.Bit))),
        "WE", m.In(m.Bit), "CLK", m.In(m.Clock),
        "O", m.Out(m.Array(width, m.Bit)), "V", m.Out(m.Bit))

conv = Convolution()

m.wire(sclk, conv.CLK)
m.wire(rom.O, conv.I0_0)
m.wire(weights, conv.I1_0)
m.wire(addr, conv.WADDR)
m.wire(we, conv.WE)

m.wire(sclk,   main.J2_9)
m.wire(full.O,  main.J2_10) # valid
m.wire(uart,      main.J2_11)
m.wire(conv.O,      main.J2_12)
