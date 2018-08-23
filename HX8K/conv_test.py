import magma as m
import mantle
from rom import ROM8, ROM16
from uart import UART
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

img_size = 16

img_list = [0, 0, 0, 0, 960, 4064, 48, 32, 96, 192, 192, 384, 768, 512, 1536, 0]

bmp = []
f = '{0:0'+str(img_size)+'b}'
for n in img_list:
    row = [1 if digit=='1' else 0 for digit in f.format(n)]
    bmp.extend(row)

num_data = m.array(bmp)

weights = m.array([m.array(0b0101, 4),
                   m.array(0b1010, 4),
                   m.array(0b0101, 4),
                   m.array(0b1010, 4)])   

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

# rom = ROM16(4, num_data, addr)

# uart = UART(4)
# uart(CLK=main.CLKIN, BAUD=baud, DATA=addr, LOAD=load)

data = m.bit(sclk)

# Convolution = m.DeclareCircuit(
#         'Convolution',
#         "I0_0_0", m.Array(1, m.Array(1, m.In(m.Bit))),
#         "I1", m.Array(4, m.Array(4, m.In(m.Bit))),
#         "WE", m.In(m.Bit), "CLK", m.In(m.Clock),
#         "O", m.Out(m.Bit), "V", m.Out(m.Bit))

verilog = '''
module Convolution (
  input  CLK,
  input [0:0] I0_0_0,
  input [0:0] I1_0_0,
  input [0:0] I1_0_1,
  input [0:0] I1_0_2,
  input [0:0] I1_0_3,
  input [0:0] I1_1_0,
  input [0:0] I1_1_1,
  input [0:0] I1_1_2,
  input [0:0] I1_1_3,
  input [0:0] I1_2_0,
  input [0:0] I1_2_1,
  input [0:0] I1_2_2,
  input [0:0] I1_2_3,
  input [0:0] I1_3_0,
  input [0:0] I1_3_1,
  input [0:0] I1_3_2,
  input [0:0] I1_3_3,
  output  O,
  output  V,
  input  WE
);
  //Wire declarations for instance 'inst0' (Module linebuffer_U0)
  wire  inst0__clk;
  wire [0:0] inst0__in_0_0;
  wire [0:0] inst0__out_0_0;
  wire [0:0] inst0__out_0_1;
  wire [0:0] inst0__out_0_2;
  wire [0:0] inst0__out_0_3;
  wire [0:0] inst0__out_1_0;
  wire [0:0] inst0__out_1_1;
  wire [0:0] inst0__out_1_2;
  wire [0:0] inst0__out_1_3;
  wire [0:0] inst0__out_2_0;
  wire [0:0] inst0__out_2_1;
  wire [0:0] inst0__out_2_2;
  wire [0:0] inst0__out_2_3;
  wire [0:0] inst0__out_3_0;
  wire [0:0] inst0__out_3_1;
  wire [0:0] inst0__out_3_2;
  wire [0:0] inst0__out_3_3;
  wire  inst0__valid;
  wire  inst0__valid_chain;
  wire  inst0__wen;
  linebuffer_U0 inst0(
    .clk(inst0__clk),
    .in_0_0(inst0__in_0_0),
    .out_0_0(inst0__out_0_0),
    .out_0_1(inst0__out_0_1),
    .out_0_2(inst0__out_0_2),
    .out_0_3(inst0__out_0_3),
    .out_1_0(inst0__out_1_0),
    .out_1_1(inst0__out_1_1),
    .out_1_2(inst0__out_1_2),
    .out_1_3(inst0__out_1_3),
    .out_2_0(inst0__out_2_0),
    .out_2_1(inst0__out_2_1),
    .out_2_2(inst0__out_2_2),
    .out_2_3(inst0__out_2_3),
    .out_3_0(inst0__out_3_0),
    .out_3_1(inst0__out_3_1),
    .out_3_2(inst0__out_3_2),
    .out_3_3(inst0__out_3_3),
    .valid(inst0__valid),
    .valid_chain(inst0__valid_chain),
    .wen(inst0__wen)
  );

  //Wire declarations for instance 'inst1' (Module MAC16)
  wire  inst1__CLK;
  wire [15:0] inst1__I0;
  wire [15:0] inst1__I1;
  wire  inst1__O;
  wire [4:0] inst1__P;
  MAC16 inst1(
    .CLK(inst1__CLK),
    .I0(inst1__I0),
    .I1(inst1__I1),
    .O(inst1__O),
    .P(inst1__P)
  );

  //All the connections
  assign inst1__I1[1] = I1_0_1[0];
  assign inst1__I1[9] = I1_2_1[0];
  assign O = inst1__O;
  assign inst1__I1[15] = I1_3_3[0];
  assign inst1__I1[3] = I1_0_3[0];
  assign inst1__I1[8] = I1_2_0[0];
  assign inst1__I1[7] = I1_1_3[0];
  assign inst1__I1[6] = I1_1_2[0];
  assign inst1__I1[4] = I1_1_0[0];
  assign inst1__I1[14] = I1_3_2[0];
  assign inst1__I1[13] = I1_3_1[0];
  assign inst1__I1[5] = I1_1_1[0];
  assign inst1__I1[12] = I1_3_0[0];
  assign inst1__I1[2] = I1_0_2[0];
  assign inst1__I0[0] = inst0__out_0_0[0];
  assign inst1__I0[1] = inst0__out_0_1[0];
  assign inst1__I0[2] = inst0__out_0_2[0];
  assign inst1__I0[3] = inst0__out_0_3[0];
  assign inst1__I0[4] = inst0__out_1_0[0];
  assign inst1__I0[5] = inst0__out_1_1[0];
  assign inst1__I0[6] = inst0__out_1_2[0];
  assign inst1__I0[7] = inst0__out_1_3[0];
  assign inst1__I0[8] = inst0__out_2_0[0];
  assign inst1__I0[9] = inst0__out_2_1[0];
  assign inst1__I0[10] = inst0__out_2_2[0];
  assign inst1__I0[11] = inst0__out_2_3[0];
  assign inst1__I0[12] = inst0__out_3_0[0];
  assign inst1__I0[13] = inst0__out_3_1[0];
  assign inst1__I0[14] = inst0__out_3_2[0];
  assign inst1__I0[15] = inst0__out_3_3[0];
  assign V = inst0__valid;
  assign inst0__wen = WE;
  assign inst1__CLK = CLK;
  assign inst0__clk = CLK;
  assign inst1__I1[0] = I1_0_0[0];
  assign inst1__I1[10] = I1_2_2[0];
  assign inst1__I1[11] = I1_2_3[0];
  assign inst0__in_0_0[0:0] = I0_0_0[0:0];

endmodule //Convolution
'''

#Convolution = m.DeclareFromVerilogFile('build/convolution.v')[0]
Convolution = m.DeclareFromVerilog(verilog)[0]

print(Convolution)

conv = Convolution()

m.wire(sclk, conv.CLK)
m.wire(data, conv.I0_0_0[0][0])
m.wire(weights, conv.I1)
#m.wire(addr, conv.WADDR)
m.wire(we, conv.WE)

m.wire(sclk,   main.J2_9)
m.wire(full.O,  main.J2_10) # valid
m.wire(conv.V,      main.J2_11)
m.wire(conv.O,      main.J2_12)
