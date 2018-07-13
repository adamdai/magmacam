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


src = '''
module coreir_add #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 + in1;

endmodule //coreir_add

module coreir_mem #(parameter depth=1, parameter has_init=1, parameter width=1) (
  input clk,
  input [width-1:0] wdata,
  input [$clog2(depth)-1:0] waddr,
  input wen,
  output [width-1:0] rdata,
  input [$clog2(depth)-1:0] raddr
);
reg [width-1:0] data[depth-1:0];
always @(posedge clk) begin
  if (wen) begin
    data[waddr] <= wdata;
  end
end
assign rdata = data[raddr];

endmodule //coreir_mem

module corebit_and (
  input in0,
  input in1,
  output out
);
  assign out = in0 & in1;

endmodule //corebit_and

module corebit_const #(parameter value=1) (
  output out
);
  assign out = value;

endmodule //corebit_const

module coreir_const #(parameter value=1, parameter width=1) (
  output [width-1:0] out
);
  assign out = value;

endmodule //coreir_const

module corebit_not (
  input in,
  output out
);
  assign out = ~in;

endmodule //corebit_not

module coreir_eq #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output out
);
  assign out = in0 == in1;

endmodule //coreir_eq

module coreir_mux #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  input sel,
  output [width-1:0] out
);
  assign out = sel ? in1 : in0;

endmodule //coreir_mux

module coreir_reg #(parameter clk_posedge=1, parameter init=1, parameter width=1) (
  input clk,
  input [width-1:0] in,
  output [width-1:0] out
);
reg [width-1:0] outReg=init;
wire real_clk;
assign real_clk = clk_posedge ? clk : ~clk;
always @(posedge real_clk) begin
  outReg <= in;
end
assign out = outReg;

endmodule //coreir_reg

module linebuffer_U4 (
  input  clk,
  input [7:0] in_0,
  output [7:0] out_0,
  output [7:0] out_1,
  input  wen
);
  //Wire declarations for instance 'reg_1' (Module coreir_reg)
  wire  reg_1__clk;
  wire [7:0] reg_1__in;
  wire [7:0] reg_1__out;
  coreir_reg #(.clk_posedge(1),.init(8'bxxxxxxxx),.width(8)) reg_1(
    .clk(reg_1__clk),
    .in(reg_1__in),
    .out(reg_1__out)
  );

  //All the connections
  assign reg_1__in[7:0] = in_0[7:0];
  assign out_0[7:0] = reg_1__out[7:0];
  assign reg_1__clk = clk;
  assign out_1[7:0] = in_0[7:0];

endmodule //linebuffer_U4

module reg_U8 #(parameter init=1) (
  input  clk,
  input  clr,
  input  en,
  input [2:0] in,
  output [2:0] out
);
  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [2:0] c0__out;
  coreir_const #(.value(3'b000),.width(3)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'clrMux' (Module coreir_mux)
  wire [2:0] clrMux__in0;
  wire [2:0] clrMux__in1;
  wire [2:0] clrMux__out;
  wire  clrMux__sel;
  coreir_mux #(.width(3)) clrMux(
    .in0(clrMux__in0),
    .in1(clrMux__in1),
    .out(clrMux__out),
    .sel(clrMux__sel)
  );

  //Wire declarations for instance 'enMux' (Module coreir_mux)
  wire [2:0] enMux__in0;
  wire [2:0] enMux__in1;
  wire [2:0] enMux__out;
  wire  enMux__sel;
  coreir_mux #(.width(3)) enMux(
    .in0(enMux__in0),
    .in1(enMux__in1),
    .out(enMux__out),
    .sel(enMux__sel)
  );

  //Wire declarations for instance 'reg0' (Module coreir_reg)
  wire  reg0__clk;
  wire [2:0] reg0__in;
  wire [2:0] reg0__out;
  coreir_reg #(.clk_posedge(1),.init(init),.width(3)) reg0(
    .clk(reg0__clk),
    .in(reg0__in),
    .out(reg0__out)
  );

  //All the connections
  assign reg0__in[2:0] = enMux__out[2:0];
  assign out[2:0] = reg0__out[2:0];
  assign enMux__in0[2:0] = reg0__out[2:0];
  assign reg0__clk = clk;
  assign enMux__sel = en;
  assign enMux__in1[2:0] = clrMux__out[2:0];
  assign clrMux__in1[2:0] = c0__out[2:0];
  assign clrMux__sel = clr;
  assign clrMux__in0[2:0] = in[2:0];

endmodule //reg_U8

module reg_U9 #(parameter init=1) (
  input  clk,
  input  clr,
  input  en,
  input [0:0] in,
  output [0:0] out
);
  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [0:0] c0__out;
  coreir_const #(.value(1'b0),.width(1)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'clrMux' (Module coreir_mux)
  wire [0:0] clrMux__in0;
  wire [0:0] clrMux__in1;
  wire [0:0] clrMux__out;
  wire  clrMux__sel;
  coreir_mux #(.width(1)) clrMux(
    .in0(clrMux__in0),
    .in1(clrMux__in1),
    .out(clrMux__out),
    .sel(clrMux__sel)
  );

  //Wire declarations for instance 'enMux' (Module coreir_mux)
  wire [0:0] enMux__in0;
  wire [0:0] enMux__in1;
  wire [0:0] enMux__out;
  wire  enMux__sel;
  coreir_mux #(.width(1)) enMux(
    .in0(enMux__in0),
    .in1(enMux__in1),
    .out(enMux__out),
    .sel(enMux__sel)
  );

  //Wire declarations for instance 'reg0' (Module coreir_reg)
  wire  reg0__clk;
  wire [0:0] reg0__in;
  wire [0:0] reg0__out;
  coreir_reg #(.clk_posedge(1),.init(init),.width(1)) reg0(
    .clk(reg0__clk),
    .in(reg0__in),
    .out(reg0__out)
  );

  //All the connections
  assign reg0__in[0:0] = enMux__out[0:0];
  assign out[0:0] = reg0__out[0:0];
  assign enMux__in0[0:0] = reg0__out[0:0];
  assign reg0__clk = clk;
  assign enMux__sel = en;
  assign enMux__in1[0:0] = clrMux__out[0:0];
  assign clrMux__in1[0:0] = c0__out[0:0];
  assign clrMux__sel = clr;
  assign clrMux__in0[0:0] = in[0:0];

endmodule //reg_U9

module coreir_zext #(parameter width_in=1, parameter width_out=1) (
  input [width_in-1:0] in,
  output [width_out-1:0] out
);
  assign out = {{(width_out-width_in){1'b0}},in};

endmodule //coreir_zext

module Add8 (
  input [7:0] I0,
  input [7:0] I1,
  output [7:0] O
);
  //Wire declarations for instance 'inst0' (Module coreir_add)
  wire [7:0] inst0__in0;
  wire [7:0] inst0__in1;
  wire [7:0] inst0__out;
  coreir_add #(.width(8)) inst0(
    .in0(inst0__in0),
    .in1(inst0__in1),
    .out(inst0__out)
  );

  //All the connections
  assign inst0__in0[7:0] = I0[7:0];
  assign inst0__in1[7:0] = I1[7:0];
  assign O[7:0] = inst0__out[7:0];

endmodule //Add8

module renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___ (
  input [7:0] in0,
  input [7:0] in1,
  output [7:0] out
);
  //Wire declarations for instance 'inst0' (Module Add8)
  wire [7:0] inst0__I0;
  wire [7:0] inst0__I1;
  wire [7:0] inst0__O;
  Add8 inst0(
    .I0(inst0__I0),
    .I1(inst0__I1),
    .O(inst0__O)
  );

  //All the connections
  assign inst0__I0[7:0] = in0[7:0];
  assign inst0__I1[7:0] = in1[7:0];
  assign out[7:0] = inst0__O[7:0];

endmodule //renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___

module reduceParallelPower2Inputs_U3 (
  input [7:0] in_0,
  input [7:0] in_1,
  input [7:0] in_2,
  input [7:0] in_3,
  output [7:0] out
);
  //Wire declarations for instance 'op_0_0' (Module renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___)
  wire [7:0] op_0_0__in0;
  wire [7:0] op_0_0__in1;
  wire [7:0] op_0_0__out;
  renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___ op_0_0(
    .in0(op_0_0__in0),
    .in1(op_0_0__in1),
    .out(op_0_0__out)
  );

  //Wire declarations for instance 'op_1_0' (Module renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___)
  wire [7:0] op_1_0__in0;
  wire [7:0] op_1_0__in1;
  wire [7:0] op_1_0__out;
  renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___ op_1_0(
    .in0(op_1_0__in0),
    .in1(op_1_0__in1),
    .out(op_1_0__out)
  );

  //Wire declarations for instance 'op_1_1' (Module renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___)
  wire [7:0] op_1_1__in0;
  wire [7:0] op_1_1__in1;
  wire [7:0] op_1_1__out;
  renamedForReduce_opAdd8_I0-In_Bits_8__-I1-In_Bits_8__-O-Out_Bits_8___ op_1_1(
    .in0(op_1_1__in0),
    .in1(op_1_1__in1),
    .out(op_1_1__out)
  );

  //All the connections
  assign out[7:0] = op_0_0__out[7:0];
  assign op_1_0__in0[7:0] = in_0[7:0];
  assign op_1_0__in1[7:0] = in_1[7:0];
  assign op_0_0__in0[7:0] = op_1_0__out[7:0];
  assign op_1_1__in0[7:0] = in_2[7:0];
  assign op_1_1__in1[7:0] = in_3[7:0];
  assign op_0_0__in1[7:0] = op_1_1__out[7:0];

endmodule //reduceParallelPower2Inputs_U3

module reduceParallel_U2 (
  input [7:0] in_data_0,
  input [7:0] in_data_1,
  input [7:0] in_data_2,
  input [7:0] in_data_3,
  input [7:0] in_identity,
  output [7:0] out
);
  //Wire declarations for instance 'reducer' (Module reduceParallelPower2Inputs_U3)
  wire [7:0] reducer__in_0;
  wire [7:0] reducer__in_1;
  wire [7:0] reducer__in_2;
  wire [7:0] reducer__in_3;
  wire [7:0] reducer__out;
  reduceParallelPower2Inputs_U3 reducer(
    .in_0(reducer__in_0),
    .in_1(reducer__in_1),
    .in_2(reducer__in_2),
    .in_3(reducer__in_3),
    .out(reducer__out)
  );

  //All the connections
  assign reducer__in_2[7:0] = in_data_2[7:0];
  assign reducer__in_3[7:0] = in_data_3[7:0];
  assign out[7:0] = reducer__out[7:0];
  assign reducer__in_1[7:0] = in_data_1[7:0];
  assign reducer__in_0[7:0] = in_data_0[7:0];

endmodule //reduceParallel_U2

module coreir_const80 (
  output [7:0] out
);
  //Wire declarations for instance 'bit_const_GND' (Module corebit_const)
  wire  bit_const_GND__out;
  corebit_const #(.value(0)) bit_const_GND(
    .out(bit_const_GND__out)
  );

  //All the connections
  assign out[0] = bit_const_GND__out;
  assign out[1] = bit_const_GND__out;
  assign out[2] = bit_const_GND__out;
  assign out[3] = bit_const_GND__out;
  assign out[4] = bit_const_GND__out;
  assign out[5] = bit_const_GND__out;
  assign out[6] = bit_const_GND__out;
  assign out[7] = bit_const_GND__out;

endmodule //coreir_const80

module reg_U15 #(parameter init=1) (
  input  clk,
  input  clr,
  input  en,
  input [1:0] in,
  output [1:0] out
);
  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [1:0] c0__out;
  coreir_const #(.value(2'b00),.width(2)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'clrMux' (Module coreir_mux)
  wire [1:0] clrMux__in0;
  wire [1:0] clrMux__in1;
  wire [1:0] clrMux__out;
  wire  clrMux__sel;
  coreir_mux #(.width(2)) clrMux(
    .in0(clrMux__in0),
    .in1(clrMux__in1),
    .out(clrMux__out),
    .sel(clrMux__sel)
  );

  //Wire declarations for instance 'enMux' (Module coreir_mux)
  wire [1:0] enMux__in0;
  wire [1:0] enMux__in1;
  wire [1:0] enMux__out;
  wire  enMux__sel;
  coreir_mux #(.width(2)) enMux(
    .in0(enMux__in0),
    .in1(enMux__in1),
    .out(enMux__out),
    .sel(enMux__sel)
  );

  //Wire declarations for instance 'reg0' (Module coreir_reg)
  wire  reg0__clk;
  wire [1:0] reg0__in;
  wire [1:0] reg0__out;
  coreir_reg #(.clk_posedge(1),.init(init),.width(2)) reg0(
    .clk(reg0__clk),
    .in(reg0__in),
    .out(reg0__out)
  );

  //All the connections
  assign reg0__in[1:0] = enMux__out[1:0];
  assign out[1:0] = reg0__out[1:0];
  assign enMux__in0[1:0] = reg0__out[1:0];
  assign reg0__clk = clk;
  assign enMux__sel = en;
  assign enMux__in1[1:0] = clrMux__out[1:0];
  assign clrMux__in1[1:0] = c0__out[1:0];
  assign clrMux__sel = clr;
  assign clrMux__in0[1:0] = in[1:0];

endmodule //reg_U15

module counter_U7 #(parameter init=1, parameter max=1) (
  input  clk,
  input  en,
  output [1:0] out,
  input  srst
);
  //Wire declarations for instance 'add' (Module coreir_add)
  wire [1:0] add__in0;
  wire [1:0] add__in1;
  wire [1:0] add__out;
  coreir_add #(.width(2)) add(
    .in0(add__in0),
    .in1(add__in1),
    .out(add__out)
  );

  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [1:0] c0__out;
  coreir_const #(.value(2'b00),.width(2)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'c1' (Module coreir_const)
  wire [1:0] c1__out;
  coreir_const #(.value(2'b01),.width(2)) c1(
    .out(c1__out)
  );

  //Wire declarations for instance 'eq' (Module coreir_eq)
  wire [1:0] eq__in0;
  wire [1:0] eq__in1;
  wire  eq__out;
  coreir_eq #(.width(2)) eq(
    .in0(eq__in0),
    .in1(eq__in1),
    .out(eq__out)
  );

  //Wire declarations for instance 'maxval' (Module coreir_const)
  wire [1:0] maxval__out;
  coreir_const #(.value(max),.width(2)) maxval(
    .out(maxval__out)
  );

  //Wire declarations for instance 'mux' (Module coreir_mux)
  wire [1:0] mux__in0;
  wire [1:0] mux__in1;
  wire [1:0] mux__out;
  wire  mux__sel;
  coreir_mux #(.width(2)) mux(
    .in0(mux__in0),
    .in1(mux__in1),
    .out(mux__out),
    .sel(mux__sel)
  );

  //Wire declarations for instance 'r' (Module reg_U15)
  wire  r__clk;
  wire  r__clr;
  wire  r__en;
  wire [1:0] r__in;
  wire [1:0] r__out;
  reg_U15 #(.init(init)) r(
    .clk(r__clk),
    .clr(r__clr),
    .en(r__en),
    .in(r__in),
    .out(r__out)
  );

  //All the connections
  assign r__clk = clk;
  assign r__en = en;
  assign r__clr = srst;
  assign add__in1[1:0] = c1__out[1:0];
  assign add__in0[1:0] = r__out[1:0];
  assign out[1:0] = r__out[1:0];
  assign eq__in0[1:0] = r__out[1:0];
  assign mux__sel = eq__out;
  assign eq__in1[1:0] = maxval__out[1:0];
  assign mux__in0[1:0] = add__out[1:0];
  assign mux__in1[1:0] = c0__out[1:0];
  assign r__in[1:0] = mux__out[1:0];

endmodule //counter_U7

module rowbuffer_U5 (
  input  clk,
  input  flush,
  output [7:0] rdata,
  output  valid,
  input [7:0] wdata,
  input  wen
);
  //Wire declarations for instance 'add_wen' (Module coreir_add)
  wire [2:0] add_wen__in0;
  wire [2:0] add_wen__in1;
  wire [2:0] add_wen__out;
  coreir_add #(.width(3)) add_wen(
    .in0(add_wen__in0),
    .in1(add_wen__in1),
    .out(add_wen__out)
  );

  //Wire declarations for instance 'c1' (Module corebit_const)
  wire  c1__out;
  corebit_const #(.value(1)) c1(
    .out(c1__out)
  );

  //Wire declarations for instance 'cnt' (Module reg_U8)
  wire  cnt__clk;
  wire  cnt__clr;
  wire  cnt__en;
  wire [2:0] cnt__in;
  wire [2:0] cnt__out;
  reg_U8 #(.init(3'b000)) cnt(
    .clk(cnt__clk),
    .clr(cnt__clr),
    .en(cnt__en),
    .in(cnt__in),
    .out(cnt__out)
  );

  //Wire declarations for instance 'depth_m1' (Module coreir_const)
  wire [2:0] depth_m1__out;
  coreir_const #(.value(3'b100),.width(3)) depth_m1(
    .out(depth_m1__out)
  );

  //Wire declarations for instance 'eq_depth' (Module coreir_eq)
  wire [2:0] eq_depth__in0;
  wire [2:0] eq_depth__in1;
  wire  eq_depth__out;
  coreir_eq #(.width(3)) eq_depth(
    .in0(eq_depth__in0),
    .in1(eq_depth__in1),
    .out(eq_depth__out)
  );

  //Wire declarations for instance 'mem' (Module coreir_mem)
  wire  mem__clk;
  wire [1:0] mem__raddr;
  wire [7:0] mem__rdata;
  wire [1:0] mem__waddr;
  wire [7:0] mem__wdata;
  wire  mem__wen;
  coreir_mem #(.depth(4),.has_init(0),.width(8)) mem(
    .clk(mem__clk),
    .raddr(mem__raddr),
    .rdata(mem__rdata),
    .waddr(mem__waddr),
    .wdata(mem__wdata),
    .wen(mem__wen)
  );

  //Wire declarations for instance 'raddr' (Module counter_U7)
  wire  raddr__clk;
  wire  raddr__en;
  wire [1:0] raddr__out;
  wire  raddr__srst;
  counter_U7 #(.init(2'b00),.max(2'b11)) raddr(
    .clk(raddr__clk),
    .en(raddr__en),
    .out(raddr__out),
    .srst(raddr__srst)
  );

  //Wire declarations for instance 'state' (Module reg_U9)
  wire  state__clk;
  wire  state__clr;
  wire  state__en;
  wire [0:0] state__in;
  wire [0:0] state__out;
  reg_U9 #(.init(1'b0)) state(
    .clk(state__clk),
    .clr(state__clr),
    .en(state__en),
    .in(state__in),
    .out(state__out)
  );

  //Wire declarations for instance 'state0' (Module corebit_not)
  wire  state0__in;
  wire  state0__out;
  corebit_not state0(
    .in(state0__in),
    .out(state0__out)
  );

  //Wire declarations for instance 'valid' (Module corebit_and)
  wire  valid__in0;
  wire  valid__in1;
  wire  valid__out;
  corebit_and valid(
    .in0(valid__in0),
    .in1(valid__in1),
    .out(valid__out)
  );

  //Wire declarations for instance 'waddr' (Module counter_U7)
  wire  waddr__clk;
  wire  waddr__en;
  wire [1:0] waddr__out;
  wire  waddr__srst;
  counter_U7 #(.init(2'b00),.max(2'b11)) waddr(
    .clk(waddr__clk),
    .en(waddr__en),
    .out(waddr__out),
    .srst(waddr__srst)
  );

  //Wire declarations for instance 'wen_ext' (Module coreir_zext)
  wire [0:0] wen_ext__in;
  wire [2:0] wen_ext__out;
  coreir_zext #(.width_in(1),.width_out(3)) wen_ext(
    .in(wen_ext__in),
    .out(wen_ext__out)
  );

  //All the connections
  assign state__clk = clk;
  assign mem__raddr[1:0] = raddr__out[1:0];
  assign waddr__clk = clk;
  assign raddr__clk = clk;
  assign cnt__clk = clk;
  assign mem__clk = clk;
  assign mem__waddr[1:0] = waddr__out[1:0];
  assign valid__in1 = wen;
  assign rdata[7:0] = mem__rdata[7:0];
  assign mem__wdata[7:0] = wdata[7:0];
  assign mem__wen = wen;
  assign waddr__en = wen;
  assign wen_ext__in[0] = wen;
  assign valid = valid__out;
  assign raddr__en = valid__out;
  assign valid__in0 = state__out[0];
  assign state0__in = state__out[0];
  assign raddr__srst = flush;
  assign waddr__srst = flush;
  assign cnt__clr = flush;
  assign state__clr = flush;
  assign cnt__en = state0__out;
  assign add_wen__in0[2:0] = wen_ext__out[2:0];
  assign add_wen__in1[2:0] = cnt__out[2:0];
  assign cnt__in[2:0] = add_wen__out[2:0];
  assign eq_depth__in1[2:0] = add_wen__out[2:0];
  assign eq_depth__in0[2:0] = depth_m1__out[2:0];
  assign state__en = eq_depth__out;
  assign state__in[0] = c1__out;

endmodule //rowbuffer_U5

module linebuffer_U1 (
  input  clk,
  input [7:0] in_0_0,
  output [7:0] out_0_0,
  output [7:0] out_0_1,
  output [7:0] out_1_0,
  output [7:0] out_1_1,
  input  wen
);
  //Wire declarations for instance 'lb1d_0' (Module linebuffer_U4)
  wire  lb1d_0__clk;
  wire [7:0] lb1d_0__in_0;
  wire [7:0] lb1d_0__out_0;
  wire [7:0] lb1d_0__out_1;
  wire  lb1d_0__wen;
  linebuffer_U4 lb1d_0(
    .clk(lb1d_0__clk),
    .in_0(lb1d_0__in_0),
    .out_0(lb1d_0__out_0),
    .out_1(lb1d_0__out_1),
    .wen(lb1d_0__wen)
  );

  //Wire declarations for instance 'lb1d_1' (Module linebuffer_U4)
  wire  lb1d_1__clk;
  wire [7:0] lb1d_1__in_0;
  wire [7:0] lb1d_1__out_0;
  wire [7:0] lb1d_1__out_1;
  wire  lb1d_1__wen;
  linebuffer_U4 lb1d_1(
    .clk(lb1d_1__clk),
    .in_0(lb1d_1__in_0),
    .out_0(lb1d_1__out_0),
    .out_1(lb1d_1__out_1),
    .wen(lb1d_1__wen)
  );

  //Wire declarations for instance 'lbmem_1_0' (Module rowbuffer_U5)
  wire  lbmem_1_0__clk;
  wire  lbmem_1_0__flush;
  wire [7:0] lbmem_1_0__rdata;
  wire  lbmem_1_0__valid;
  wire [7:0] lbmem_1_0__wdata;
  wire  lbmem_1_0__wen;
  rowbuffer_U5 lbmem_1_0(
    .clk(lbmem_1_0__clk),
    .flush(lbmem_1_0__flush),
    .rdata(lbmem_1_0__rdata),
    .valid(lbmem_1_0__valid),
    .wdata(lbmem_1_0__wdata),
    .wen(lbmem_1_0__wen)
  );

  //Wire declarations for instance 'lbmem_1_0_flush' (Module corebit_const)
  wire  lbmem_1_0_flush__out;
  corebit_const #(.value(0)) lbmem_1_0_flush(
    .out(lbmem_1_0_flush__out)
  );

  //All the connections
  assign lbmem_1_0__wdata[7:0] = in_0_0[7:0];
  assign lb1d_0__in_0[7:0] = in_0_0[7:0];
  assign lb1d_0__wen = wen;
  assign lb1d_1__in_0[7:0] = lbmem_1_0__rdata[7:0];
  assign lbmem_1_0__flush = lbmem_1_0_flush__out;
  assign lb1d_1__wen = wen;
  assign lbmem_1_0__wen = wen;
  assign lb1d_0__clk = clk;
  assign lb1d_1__clk = clk;
  assign lbmem_1_0__clk = clk;
  assign out_1_0[7:0] = lb1d_0__out_0[7:0];
  assign out_1_1[7:0] = lb1d_0__out_1[7:0];
  assign out_0_0[7:0] = lb1d_1__out_0[7:0];
  assign out_0_1[7:0] = lb1d_1__out_1[7:0];

endmodule //linebuffer_U1
'''

test = DefineFromVerilog(src)[0]

# or_sim.set_value(Or.I0, high)
# or_sim.set_value(Or.I1, low)
# or_sim.evaluate()
# print(or_sim.get_value(Or.O))

# lsl_sim.set_value(Shift.I, high)
# lsl_sim.evaluate()
# print(lsl_sim.get_value(Shift.O))
