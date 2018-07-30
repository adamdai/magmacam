import magma as m
import mantle
from rom import ROM8, ROM16
from pipeline import Pipeline, MEM, ReadRom
from mantle.lattice.ice40 import ROMB, SB_LUT4
from mantle.util.edge import falling, rising
from loam.boards.icestick import IceStick

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm


icestick = IceStick()
icestick.Clock.on()
icestick.D1.on()
icestick.D2.on()
icestick.D3.on()
icestick.D4.on()
icestick.D5.on()

main = icestick.main()

# img_list = [0, 0, 0, 0, 0, 15840, 32752, 16176, 816, 1008, 480, 0, 0, 0, 0,
#             0]  # 9, last col->first col
img_list = [0, 0, 0, 0, 960, 2016, 1632, 1632, 2016, 960, 224, 224, 224, 224,
            64, 0]  # 9, first row->last row
# img_list = [0, 0, 0, 896, 984, 3680, 7216, 6204, 14456, 14448, 8160, 3840,
#             0, 0, 0, 0] # 0
# img_list = range(2, 18)


num_data = [m.uint(img_list[i], 16) for i in range(16)]

# decrease the frequency to avoid timing violation
counter = mantle.Counter(4)
sclk = counter.O[-1]
rom_idx = mantle.Counter(4, has_ce=True)

full = mantle.SRFF(has_ce=True)
check = mantle.EQ(4)(rom_idx.O, m.bits(15, 4))
full(check, 0)
m.wire(falling(sclk), full.CE)
rom_ce = rising(sclk) & ~full.O
m.wire(rom_ce, rom_idx.CE)

rom = ROM16(4, num_data, rom_idx.O)

pipeline = Pipeline()

m.wire(sclk, pipeline.CLK)
m.wire(rom.O, pipeline.DATA)
m.wire(rom_idx.O, pipeline.WADDR)
m.wire(~full.O, pipeline.WE)
m.wire(full.O, pipeline.RUN)
m.wire(pipeline.O[:4], m.bits([main.D1, main.D2, main.D3, main.D4]))
# light 5 indicates the end of prediction
m.wire(pipeline.D, main.D5)
