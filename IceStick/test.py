from magma import *
set_mantle_target("ice40")
from mantle import *
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

# for i in range(6):
#    icestick.J3[i].output().on()

main = icestick.main()

#img_list = [0,0,0,0,0,15840,32752,16176,816,1008,480,0,0,0,0,0] #9, last col->first col
img_list = [0,0,0,0,960,2016,1632,1632,2016,960,224,224,224,224,64,0] #9, first row->last row
#img_list = [0,0,0,896,984,3680,7216,6204,14456,14448,8160,3840,0,0,0,0] #0
#img_list = range(2,18)


# bmp = []
# for n in img_list:
#     row = [1 if digit=='1' else 0 for digit in '{0:016b}'.format(n)]
#     bmp.append(row)

# arr = np.asarray(bmp)
# #arr = np.flip(np.rot90(arr), 1)
# print(arr)
# plt.imshow(arr, cmap=cm.gray)
# plt.show()

num_data = [uint(img_list[i], 16) for i in range(16)]

# decrease the frequency to avoid timing violation
counter = Counter(4)
sclk = counter.O[-1]
rom_idx = Counter(4, has_ce=True)

full = SRFF(has_ce=True)
check = EQ(4)(rom_idx.O, bits(15, 4))
full(check, 0)
wire(falling(sclk), full.CE)
rom_ce = rising(sclk)&~full.O
wire(rom_ce, rom_idx.CE)

rom = ROM16(4, num_data, rom_idx.O)

pipeline = Pipeline()

wire(sclk, pipeline.CLK)
wire(rom.O, pipeline.DATA)
wire(rom_idx.O, pipeline.WADDR)
wire(full.O, pipeline.RUN)
wire(pipeline.O[:4], bits([main.D1, main.D2, main.D3, main.D4]))
# light 5 indicates the end of prediction
wire(pipeline.D, main.D5)

# mem = MEM()
# mem = ReadRom()

# wire(sclk, mem.CLK)
# wire(rom.O, mem.DATA)
# wire(rom_idx.O, mem.WADDR)
# wire(~full.O, mem.WE)

# u_data = array([mem.IMAGE[15], mem.IMAGE[14], mem.IMAGE[13], mem.IMAGE[12],
#                 mem.IMAGE[11], mem.IMAGE[10], mem.IMAGE[9], mem.IMAGE[8],
#                 mem.IMAGE[7], mem.IMAGE[6], mem.IMAGE[5], mem.IMAGE[4],
#                 mem.IMAGE[3], mem.IMAGE[2], mem.IMAGE[1], mem.IMAGE[0], 0])

# baud = rising(sclk)

# ff = FF(has_ce=True)
# wire(baud, ff.CE)
# u_reset = LUT2(I0 & ~I1)(full, ff(full))

# u_counter = CounterModM(20, 5, has_ce=True, has_reset=True)
# u_counter(CE=baud, RESET=u_reset)
# load = full.O & u_counter.COUT

# read_count = Counter(4, has_ce=True)
# wire(load, read_count.CE)

# wire(bits(0,4), mem.IDX)
# wire(read_count.O, mem.CYCLE)

# uart = PISO(17, has_ce=True)
# #load = LUT2(I0&~I1)(valid,run)
# uart(1, u_data, load)
# wire(baud, uart.CE)

# wire(sclk, main.J3[0])
# wire(baud, main.J3[1])
# wire(rom_ce, main.J3[2])
# wire(u_reset, main.J3[3])
# wire(load, main.J3[4])
# wire(uart, main.J3[5])


