//Module: Add16 defined externally
//Module: pullresistor defined externally


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

module bitopn_U19 (
  input [0:0] in,
  output  out
);
  //All the connections
  assign out = in[0];

endmodule //bitopn_U19

module corebit_tribuf (
  input in,
  input en,
  inout out
);
  assign out = en ? in : 1'bz;

endmodule //corebit_tribuf

module corebit_and (
  input in0,
  input in1,
  output out
);
  assign out = in0 & in1;

endmodule //corebit_and

module bitopn_U18 (
  input [1:0] in,
  output  out
);
  //Wire declarations for instance 'join' (Module corebit_and)
  wire  join__in0;
  wire  join__in1;
  wire  join__out;
  corebit_and join(
    .in0(join__in0),
    .in1(join__in1),
    .out(join__out)
  );

  //All the connections
  assign join__in0 = in[0];
  assign out = join__out;
  assign join__in1 = in[1];

endmodule //bitopn_U18

module bitopn_U9 (
  input [2:0] in,
  output  out
);
  //Wire declarations for instance 'join' (Module corebit_and)
  wire  join__in0;
  wire  join__in1;
  wire  join__out;
  corebit_and join(
    .in0(join__in0),
    .in1(join__in1),
    .out(join__out)
  );

  //Wire declarations for instance 'opN_0' (Module bitopn_U18)
  wire [1:0] opN_0__in;
  wire  opN_0__out;
  bitopn_U18 opN_0(
    .in(opN_0__in),
    .out(opN_0__out)
  );

  //Wire declarations for instance 'opN_1' (Module bitopn_U19)
  wire [0:0] opN_1__in;
  wire  opN_1__out;
  bitopn_U19 opN_1(
    .in(opN_1__in),
    .out(opN_1__out)
  );

  //All the connections
  assign out = join__out;
  assign join__in0 = opN_0__out;
  assign opN_0__in[1] = in[1];
  assign opN_0__in[0] = in[0];
  assign join__in1 = opN_1__out;
  assign opN_1__in[0] = in[2];

endmodule //bitopn_U9

module coreir_add #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 + in1;

endmodule //coreir_add

module linebuffer_U3 (
  input  clk,
  input [15:0] in_0,
  output [15:0] out_0,
  output [15:0] out_1,
  output [15:0] out_10,
  output [15:0] out_11,
  output [15:0] out_12,
  output [15:0] out_13,
  output [15:0] out_14,
  output [15:0] out_15,
  output [15:0] out_16,
  output [15:0] out_17,
  output [15:0] out_18,
  output [15:0] out_19,
  output [15:0] out_2,
  output [15:0] out_3,
  output [15:0] out_4,
  output [15:0] out_5,
  output [15:0] out_6,
  output [15:0] out_7,
  output [15:0] out_8,
  output [15:0] out_9,
  output  valid,
  output  valid_chain,
  input  wen
);
  //Wire declarations for instance 'reg_1' (Module coreir_reg)
  wire  reg_1__clk;
  wire [15:0] reg_1__in;
  wire [15:0] reg_1__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_1(
    .clk(reg_1__clk),
    .in(reg_1__in),
    .out(reg_1__out)
  );

  //Wire declarations for instance 'reg_10' (Module coreir_reg)
  wire  reg_10__clk;
  wire [15:0] reg_10__in;
  wire [15:0] reg_10__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_10(
    .clk(reg_10__clk),
    .in(reg_10__in),
    .out(reg_10__out)
  );

  //Wire declarations for instance 'reg_11' (Module coreir_reg)
  wire  reg_11__clk;
  wire [15:0] reg_11__in;
  wire [15:0] reg_11__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_11(
    .clk(reg_11__clk),
    .in(reg_11__in),
    .out(reg_11__out)
  );

  //Wire declarations for instance 'reg_12' (Module coreir_reg)
  wire  reg_12__clk;
  wire [15:0] reg_12__in;
  wire [15:0] reg_12__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_12(
    .clk(reg_12__clk),
    .in(reg_12__in),
    .out(reg_12__out)
  );

  //Wire declarations for instance 'reg_13' (Module coreir_reg)
  wire  reg_13__clk;
  wire [15:0] reg_13__in;
  wire [15:0] reg_13__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_13(
    .clk(reg_13__clk),
    .in(reg_13__in),
    .out(reg_13__out)
  );

  //Wire declarations for instance 'reg_14' (Module coreir_reg)
  wire  reg_14__clk;
  wire [15:0] reg_14__in;
  wire [15:0] reg_14__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_14(
    .clk(reg_14__clk),
    .in(reg_14__in),
    .out(reg_14__out)
  );

  //Wire declarations for instance 'reg_15' (Module coreir_reg)
  wire  reg_15__clk;
  wire [15:0] reg_15__in;
  wire [15:0] reg_15__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_15(
    .clk(reg_15__clk),
    .in(reg_15__in),
    .out(reg_15__out)
  );

  //Wire declarations for instance 'reg_16' (Module coreir_reg)
  wire  reg_16__clk;
  wire [15:0] reg_16__in;
  wire [15:0] reg_16__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_16(
    .clk(reg_16__clk),
    .in(reg_16__in),
    .out(reg_16__out)
  );

  //Wire declarations for instance 'reg_17' (Module coreir_reg)
  wire  reg_17__clk;
  wire [15:0] reg_17__in;
  wire [15:0] reg_17__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_17(
    .clk(reg_17__clk),
    .in(reg_17__in),
    .out(reg_17__out)
  );

  //Wire declarations for instance 'reg_18' (Module coreir_reg)
  wire  reg_18__clk;
  wire [15:0] reg_18__in;
  wire [15:0] reg_18__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_18(
    .clk(reg_18__clk),
    .in(reg_18__in),
    .out(reg_18__out)
  );

  //Wire declarations for instance 'reg_19' (Module coreir_reg)
  wire  reg_19__clk;
  wire [15:0] reg_19__in;
  wire [15:0] reg_19__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_19(
    .clk(reg_19__clk),
    .in(reg_19__in),
    .out(reg_19__out)
  );

  //Wire declarations for instance 'reg_2' (Module coreir_reg)
  wire  reg_2__clk;
  wire [15:0] reg_2__in;
  wire [15:0] reg_2__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_2(
    .clk(reg_2__clk),
    .in(reg_2__in),
    .out(reg_2__out)
  );

  //Wire declarations for instance 'reg_3' (Module coreir_reg)
  wire  reg_3__clk;
  wire [15:0] reg_3__in;
  wire [15:0] reg_3__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_3(
    .clk(reg_3__clk),
    .in(reg_3__in),
    .out(reg_3__out)
  );

  //Wire declarations for instance 'reg_4' (Module coreir_reg)
  wire  reg_4__clk;
  wire [15:0] reg_4__in;
  wire [15:0] reg_4__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_4(
    .clk(reg_4__clk),
    .in(reg_4__in),
    .out(reg_4__out)
  );

  //Wire declarations for instance 'reg_5' (Module coreir_reg)
  wire  reg_5__clk;
  wire [15:0] reg_5__in;
  wire [15:0] reg_5__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_5(
    .clk(reg_5__clk),
    .in(reg_5__in),
    .out(reg_5__out)
  );

  //Wire declarations for instance 'reg_6' (Module coreir_reg)
  wire  reg_6__clk;
  wire [15:0] reg_6__in;
  wire [15:0] reg_6__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_6(
    .clk(reg_6__clk),
    .in(reg_6__in),
    .out(reg_6__out)
  );

  //Wire declarations for instance 'reg_7' (Module coreir_reg)
  wire  reg_7__clk;
  wire [15:0] reg_7__in;
  wire [15:0] reg_7__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_7(
    .clk(reg_7__clk),
    .in(reg_7__in),
    .out(reg_7__out)
  );

  //Wire declarations for instance 'reg_8' (Module coreir_reg)
  wire  reg_8__clk;
  wire [15:0] reg_8__in;
  wire [15:0] reg_8__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_8(
    .clk(reg_8__clk),
    .in(reg_8__in),
    .out(reg_8__out)
  );

  //Wire declarations for instance 'reg_9' (Module coreir_reg)
  wire  reg_9__clk;
  wire [15:0] reg_9__in;
  wire [15:0] reg_9__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) reg_9(
    .clk(reg_9__clk),
    .in(reg_9__in),
    .out(reg_9__out)
  );

  //All the connections
  assign reg_1__in[15:0] = in_0[15:0];
  assign reg_2__in[15:0] = reg_1__out[15:0];
  assign out_18[15:0] = reg_1__out[15:0];
  assign reg_3__in[15:0] = reg_2__out[15:0];
  assign out_17[15:0] = reg_2__out[15:0];
  assign reg_4__in[15:0] = reg_3__out[15:0];
  assign out_16[15:0] = reg_3__out[15:0];
  assign reg_5__in[15:0] = reg_4__out[15:0];
  assign out_15[15:0] = reg_4__out[15:0];
  assign reg_6__in[15:0] = reg_5__out[15:0];
  assign out_14[15:0] = reg_5__out[15:0];
  assign reg_7__in[15:0] = reg_6__out[15:0];
  assign out_13[15:0] = reg_6__out[15:0];
  assign reg_8__in[15:0] = reg_7__out[15:0];
  assign out_12[15:0] = reg_7__out[15:0];
  assign reg_9__in[15:0] = reg_8__out[15:0];
  assign out_11[15:0] = reg_8__out[15:0];
  assign reg_10__in[15:0] = reg_9__out[15:0];
  assign out_10[15:0] = reg_9__out[15:0];
  assign reg_11__in[15:0] = reg_10__out[15:0];
  assign out_9[15:0] = reg_10__out[15:0];
  assign reg_12__in[15:0] = reg_11__out[15:0];
  assign out_8[15:0] = reg_11__out[15:0];
  assign reg_13__in[15:0] = reg_12__out[15:0];
  assign out_7[15:0] = reg_12__out[15:0];
  assign reg_14__in[15:0] = reg_13__out[15:0];
  assign out_6[15:0] = reg_13__out[15:0];
  assign reg_15__in[15:0] = reg_14__out[15:0];
  assign out_5[15:0] = reg_14__out[15:0];
  assign reg_16__in[15:0] = reg_15__out[15:0];
  assign out_4[15:0] = reg_15__out[15:0];
  assign reg_17__in[15:0] = reg_16__out[15:0];
  assign out_3[15:0] = reg_16__out[15:0];
  assign reg_18__in[15:0] = reg_17__out[15:0];
  assign out_2[15:0] = reg_17__out[15:0];
  assign reg_19__in[15:0] = reg_18__out[15:0];
  assign out_1[15:0] = reg_18__out[15:0];
  assign out_0[15:0] = reg_19__out[15:0];
  assign valid = wen;
  assign valid_chain = wen;
  assign reg_1__clk = clk;
  assign reg_10__clk = clk;
  assign reg_11__clk = clk;
  assign reg_12__clk = clk;
  assign reg_13__clk = clk;
  assign reg_14__clk = clk;
  assign reg_15__clk = clk;
  assign reg_16__clk = clk;
  assign reg_17__clk = clk;
  assign reg_18__clk = clk;
  assign reg_19__clk = clk;
  assign reg_2__clk = clk;
  assign reg_3__clk = clk;
  assign reg_4__clk = clk;
  assign reg_5__clk = clk;
  assign reg_6__clk = clk;
  assign reg_7__clk = clk;
  assign reg_8__clk = clk;
  assign reg_9__clk = clk;
  assign out_19[15:0] = in_0[15:0];

endmodule //linebuffer_U3

module corebit_concat (
  input in0,
  input in1,
  output [1:0] out
);
  assign out = {in0, in1};

endmodule //corebit_concat

module coreir_mux #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  input sel,
  output [width-1:0] out
);
  assign out = sel ? in1 : in0;

endmodule //coreir_mux

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

module corebit_ibuf (
  inout in,
  output out
);
  assign out = in;

endmodule //corebit_ibuf

module corebit_mux (
  input in0,
  input in1,
  input sel,
  output out
);
  assign out = sel ? in1 : in0;

endmodule //corebit_mux

module corebit_not (
  input in,
  output out
);
  assign out = ~in;

endmodule //corebit_not

module corebit_or (
  input in0,
  input in1,
  output out
);
  assign out = in0 | in1;

endmodule //corebit_or

module corebit_reg #(parameter clk_posedge=1, parameter init=1) (
  input clk,
  input in,
  output out
);
reg outReg = init;
always @(posedge clk) begin
  outReg <= in;
end
assign out = outReg;

endmodule //corebit_reg

module corebit_reg_arst #(parameter arst_posedge=1, parameter clk_posedge=1, parameter init=1) (
  input clk,
  input in,
  input arst,
  output out
);
reg outReg;
wire real_rst;
assign real_rst = arst_posedge ? arst : ~arst;
wire real_clk;
assign real_clk = clk_posedge ? clk : ~clk;
always @(posedge real_clk, posedge real_rst) begin
  if (real_rst) outReg <= init;
  else outReg <= in;
end
assign out = outReg;

endmodule //corebit_reg_arst

module corebit_term (
  input in
);


endmodule //corebit_term

module corebit_wire (
  input in,
  output out
);
  assign out = in;

endmodule //corebit_wire

module corebit_xor (
  input in0,
  input in1,
  output out
);
  assign out = in0 ^ in1;

endmodule //corebit_xor

module coreir_or #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 | in1;

endmodule //coreir_or

module coreir_eq #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output out
);
  assign out = in0 == in1;

endmodule //coreir_eq

module coreir_zext #(parameter width_in=1, parameter width_out=1) (
  input [width_in-1:0] in,
  output [width_out-1:0] out
);
  assign out = {{(width_out-width_in){1'b0}},in};

endmodule //coreir_zext

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

module reg_U25 #(parameter init=1) (
  input  clk,
  input  clr,
  input  en,
  input [8:0] in,
  output [8:0] out
);
  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [8:0] c0__out;
  coreir_const #(.value(9'b000000000),.width(9)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'clrMux' (Module coreir_mux)
  wire [8:0] clrMux__in0;
  wire [8:0] clrMux__in1;
  wire [8:0] clrMux__out;
  wire  clrMux__sel;
  coreir_mux #(.width(9)) clrMux(
    .in0(clrMux__in0),
    .in1(clrMux__in1),
    .out(clrMux__out),
    .sel(clrMux__sel)
  );

  //Wire declarations for instance 'enMux' (Module coreir_mux)
  wire [8:0] enMux__in0;
  wire [8:0] enMux__in1;
  wire [8:0] enMux__out;
  wire  enMux__sel;
  coreir_mux #(.width(9)) enMux(
    .in0(enMux__in0),
    .in1(enMux__in1),
    .out(enMux__out),
    .sel(enMux__sel)
  );

  //Wire declarations for instance 'reg0' (Module coreir_reg)
  wire  reg0__clk;
  wire [8:0] reg0__in;
  wire [8:0] reg0__out;
  coreir_reg #(.clk_posedge(1),.init(init),.width(9)) reg0(
    .clk(reg0__clk),
    .in(reg0__in),
    .out(reg0__out)
  );

  //All the connections
  assign reg0__in[8:0] = enMux__out[8:0];
  assign out[8:0] = reg0__out[8:0];
  assign enMux__in0[8:0] = reg0__out[8:0];
  assign reg0__clk = clk;
  assign enMux__sel = en;
  assign enMux__in1[8:0] = clrMux__out[8:0];
  assign clrMux__in1[8:0] = c0__out[8:0];
  assign clrMux__sel = clr;
  assign clrMux__in0[8:0] = in[8:0];

endmodule //reg_U25

module coreir_ule #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output out
);
  assign out = in0 <= in1;

endmodule //coreir_ule

module coreir_ult #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output out
);
  assign out = in0 < in1;

endmodule //coreir_ult

module coreir_const160 (
  output [15:0] out
);
  //Wire declarations for instance 'bit_const_GND' (Module corebit_const)
  wire  bit_const_GND__out;
  corebit_const #(.value(0)) bit_const_GND(
    .out(bit_const_GND__out)
  );

  //All the connections
  assign out[13] = bit_const_GND__out;
  assign out[10] = bit_const_GND__out;
  assign out[11] = bit_const_GND__out;
  assign out[2] = bit_const_GND__out;
  assign out[0] = bit_const_GND__out;
  assign out[4] = bit_const_GND__out;
  assign out[12] = bit_const_GND__out;
  assign out[3] = bit_const_GND__out;
  assign out[1] = bit_const_GND__out;
  assign out[14] = bit_const_GND__out;
  assign out[15] = bit_const_GND__out;
  assign out[5] = bit_const_GND__out;
  assign out[6] = bit_const_GND__out;
  assign out[7] = bit_const_GND__out;
  assign out[8] = bit_const_GND__out;
  assign out[9] = bit_const_GND__out;

endmodule //coreir_const160

module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ (
  input [15:0] in0,
  input [15:0] in1,
  output [15:0] out
);
  //Wire declarations for instance 'inst0' (Module Add16)
  wire [15:0] inst0__I0;
  wire [15:0] inst0__I1;
  wire [15:0] inst0__O;
  Add16 inst0(
    .I0(inst0__I0),
    .I1(inst0__I1),
    .O(inst0__O)
  );

  //All the connections
  assign inst0__I0[15:0] = in0[15:0];
  assign inst0__I1[15:0] = in1[15:0];
  assign out[15:0] = inst0__O[15:0];

endmodule //renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___

module reduceParallelPower2Inputs_U2 (
  input [15:0] in_0,
  input [15:0] in_1,
  input [15:0] in_10,
  input [15:0] in_11,
  input [15:0] in_12,
  input [15:0] in_13,
  input [15:0] in_14,
  input [15:0] in_15,
  input [15:0] in_2,
  input [15:0] in_3,
  input [15:0] in_4,
  input [15:0] in_5,
  input [15:0] in_6,
  input [15:0] in_7,
  input [15:0] in_8,
  input [15:0] in_9,
  output [15:0] out
);
  //Wire declarations for instance 'op_0_0' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_0_0__in0;
  wire [15:0] op_0_0__in1;
  wire [15:0] op_0_0__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_0_0(
    .in0(op_0_0__in0),
    .in1(op_0_0__in1),
    .out(op_0_0__out)
  );

  //Wire declarations for instance 'op_1_0' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_1_0__in0;
  wire [15:0] op_1_0__in1;
  wire [15:0] op_1_0__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_1_0(
    .in0(op_1_0__in0),
    .in1(op_1_0__in1),
    .out(op_1_0__out)
  );

  //Wire declarations for instance 'op_1_1' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_1_1__in0;
  wire [15:0] op_1_1__in1;
  wire [15:0] op_1_1__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_1_1(
    .in0(op_1_1__in0),
    .in1(op_1_1__in1),
    .out(op_1_1__out)
  );

  //Wire declarations for instance 'op_2_0' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_2_0__in0;
  wire [15:0] op_2_0__in1;
  wire [15:0] op_2_0__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_2_0(
    .in0(op_2_0__in0),
    .in1(op_2_0__in1),
    .out(op_2_0__out)
  );

  //Wire declarations for instance 'op_2_1' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_2_1__in0;
  wire [15:0] op_2_1__in1;
  wire [15:0] op_2_1__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_2_1(
    .in0(op_2_1__in0),
    .in1(op_2_1__in1),
    .out(op_2_1__out)
  );

  //Wire declarations for instance 'op_2_2' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_2_2__in0;
  wire [15:0] op_2_2__in1;
  wire [15:0] op_2_2__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_2_2(
    .in0(op_2_2__in0),
    .in1(op_2_2__in1),
    .out(op_2_2__out)
  );

  //Wire declarations for instance 'op_2_3' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_2_3__in0;
  wire [15:0] op_2_3__in1;
  wire [15:0] op_2_3__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_2_3(
    .in0(op_2_3__in0),
    .in1(op_2_3__in1),
    .out(op_2_3__out)
  );

  //Wire declarations for instance 'op_3_0' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_0__in0;
  wire [15:0] op_3_0__in1;
  wire [15:0] op_3_0__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_0(
    .in0(op_3_0__in0),
    .in1(op_3_0__in1),
    .out(op_3_0__out)
  );

  //Wire declarations for instance 'op_3_1' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_1__in0;
  wire [15:0] op_3_1__in1;
  wire [15:0] op_3_1__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_1(
    .in0(op_3_1__in0),
    .in1(op_3_1__in1),
    .out(op_3_1__out)
  );

  //Wire declarations for instance 'op_3_2' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_2__in0;
  wire [15:0] op_3_2__in1;
  wire [15:0] op_3_2__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_2(
    .in0(op_3_2__in0),
    .in1(op_3_2__in1),
    .out(op_3_2__out)
  );

  //Wire declarations for instance 'op_3_3' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_3__in0;
  wire [15:0] op_3_3__in1;
  wire [15:0] op_3_3__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_3(
    .in0(op_3_3__in0),
    .in1(op_3_3__in1),
    .out(op_3_3__out)
  );

  //Wire declarations for instance 'op_3_4' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_4__in0;
  wire [15:0] op_3_4__in1;
  wire [15:0] op_3_4__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_4(
    .in0(op_3_4__in0),
    .in1(op_3_4__in1),
    .out(op_3_4__out)
  );

  //Wire declarations for instance 'op_3_5' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_5__in0;
  wire [15:0] op_3_5__in1;
  wire [15:0] op_3_5__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_5(
    .in0(op_3_5__in0),
    .in1(op_3_5__in1),
    .out(op_3_5__out)
  );

  //Wire declarations for instance 'op_3_6' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_6__in0;
  wire [15:0] op_3_6__in1;
  wire [15:0] op_3_6__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_6(
    .in0(op_3_6__in0),
    .in1(op_3_6__in1),
    .out(op_3_6__out)
  );

  //Wire declarations for instance 'op_3_7' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op_3_7__in0;
  wire [15:0] op_3_7__in1;
  wire [15:0] op_3_7__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op_3_7(
    .in0(op_3_7__in0),
    .in1(op_3_7__in1),
    .out(op_3_7__out)
  );

  //All the connections
  assign out[15:0] = op_0_0__out[15:0];
  assign op_0_0__in0[15:0] = op_1_0__out[15:0];
  assign op_0_0__in1[15:0] = op_1_1__out[15:0];
  assign op_1_0__in0[15:0] = op_2_0__out[15:0];
  assign op_1_0__in1[15:0] = op_2_1__out[15:0];
  assign op_1_1__in0[15:0] = op_2_2__out[15:0];
  assign op_1_1__in1[15:0] = op_2_3__out[15:0];
  assign op_3_0__in0[15:0] = in_0[15:0];
  assign op_3_0__in1[15:0] = in_1[15:0];
  assign op_2_0__in0[15:0] = op_3_0__out[15:0];
  assign op_3_1__in0[15:0] = in_2[15:0];
  assign op_3_1__in1[15:0] = in_3[15:0];
  assign op_2_0__in1[15:0] = op_3_1__out[15:0];
  assign op_3_2__in0[15:0] = in_4[15:0];
  assign op_3_2__in1[15:0] = in_5[15:0];
  assign op_2_1__in0[15:0] = op_3_2__out[15:0];
  assign op_3_3__in0[15:0] = in_6[15:0];
  assign op_3_3__in1[15:0] = in_7[15:0];
  assign op_2_1__in1[15:0] = op_3_3__out[15:0];
  assign op_3_4__in0[15:0] = in_8[15:0];
  assign op_3_4__in1[15:0] = in_9[15:0];
  assign op_2_2__in0[15:0] = op_3_4__out[15:0];
  assign op_3_5__in0[15:0] = in_10[15:0];
  assign op_3_5__in1[15:0] = in_11[15:0];
  assign op_2_2__in1[15:0] = op_3_5__out[15:0];
  assign op_3_6__in0[15:0] = in_12[15:0];
  assign op_3_6__in1[15:0] = in_13[15:0];
  assign op_2_3__in0[15:0] = op_3_6__out[15:0];
  assign op_3_7__in0[15:0] = in_14[15:0];
  assign op_3_7__in1[15:0] = in_15[15:0];
  assign op_2_3__in1[15:0] = op_3_7__out[15:0];

endmodule //reduceParallelPower2Inputs_U2

module reduceParallel_U1 (
  input [15:0] in_data_0,
  input [15:0] in_data_1,
  input [15:0] in_data_10,
  input [15:0] in_data_11,
  input [15:0] in_data_12,
  input [15:0] in_data_13,
  input [15:0] in_data_14,
  input [15:0] in_data_15,
  input [15:0] in_data_2,
  input [15:0] in_data_3,
  input [15:0] in_data_4,
  input [15:0] in_data_5,
  input [15:0] in_data_6,
  input [15:0] in_data_7,
  input [15:0] in_data_8,
  input [15:0] in_data_9,
  input [15:0] in_identity,
  output [15:0] out
);
  //Wire declarations for instance 'reducer' (Module reduceParallelPower2Inputs_U2)
  wire [15:0] reducer__in_0;
  wire [15:0] reducer__in_1;
  wire [15:0] reducer__in_10;
  wire [15:0] reducer__in_11;
  wire [15:0] reducer__in_12;
  wire [15:0] reducer__in_13;
  wire [15:0] reducer__in_14;
  wire [15:0] reducer__in_15;
  wire [15:0] reducer__in_2;
  wire [15:0] reducer__in_3;
  wire [15:0] reducer__in_4;
  wire [15:0] reducer__in_5;
  wire [15:0] reducer__in_6;
  wire [15:0] reducer__in_7;
  wire [15:0] reducer__in_8;
  wire [15:0] reducer__in_9;
  wire [15:0] reducer__out;
  reduceParallelPower2Inputs_U2 reducer(
    .in_0(reducer__in_0),
    .in_1(reducer__in_1),
    .in_10(reducer__in_10),
    .in_11(reducer__in_11),
    .in_12(reducer__in_12),
    .in_13(reducer__in_13),
    .in_14(reducer__in_14),
    .in_15(reducer__in_15),
    .in_2(reducer__in_2),
    .in_3(reducer__in_3),
    .in_4(reducer__in_4),
    .in_5(reducer__in_5),
    .in_6(reducer__in_6),
    .in_7(reducer__in_7),
    .in_8(reducer__in_8),
    .in_9(reducer__in_9),
    .out(reducer__out)
  );

  //All the connections
  assign out[15:0] = reducer__out[15:0];
  assign reducer__in_6[15:0] = in_data_6[15:0];
  assign reducer__in_1[15:0] = in_data_1[15:0];
  assign reducer__in_0[15:0] = in_data_0[15:0];
  assign reducer__in_8[15:0] = in_data_8[15:0];
  assign reducer__in_2[15:0] = in_data_2[15:0];
  assign reducer__in_3[15:0] = in_data_3[15:0];
  assign reducer__in_10[15:0] = in_data_10[15:0];
  assign reducer__in_9[15:0] = in_data_9[15:0];
  assign reducer__in_7[15:0] = in_data_7[15:0];
  assign reducer__in_15[15:0] = in_data_15[15:0];
  assign reducer__in_14[15:0] = in_data_14[15:0];
  assign reducer__in_13[15:0] = in_data_13[15:0];
  assign reducer__in_12[15:0] = in_data_12[15:0];
  assign reducer__in_11[15:0] = in_data_11[15:0];
  assign reducer__in_5[15:0] = in_data_5[15:0];
  assign reducer__in_4[15:0] = in_data_4[15:0];

endmodule //reduceParallel_U1

module counter_U11 #(parameter init=1, parameter max=1) (
  input  clk,
  input  en,
  output [8:0] out,
  input  srst
);
  //Wire declarations for instance 'add' (Module coreir_add)
  wire [8:0] add__in0;
  wire [8:0] add__in1;
  wire [8:0] add__out;
  coreir_add #(.width(9)) add(
    .in0(add__in0),
    .in1(add__in1),
    .out(add__out)
  );

  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [8:0] c0__out;
  coreir_const #(.value(9'b000000000),.width(9)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'c1' (Module coreir_const)
  wire [8:0] c1__out;
  coreir_const #(.value(9'b000000001),.width(9)) c1(
    .out(c1__out)
  );

  //Wire declarations for instance 'eq' (Module coreir_eq)
  wire [8:0] eq__in0;
  wire [8:0] eq__in1;
  wire  eq__out;
  coreir_eq #(.width(9)) eq(
    .in0(eq__in0),
    .in1(eq__in1),
    .out(eq__out)
  );

  //Wire declarations for instance 'maxval' (Module coreir_const)
  wire [8:0] maxval__out;
  coreir_const #(.value(max),.width(9)) maxval(
    .out(maxval__out)
  );

  //Wire declarations for instance 'mux' (Module coreir_mux)
  wire [8:0] mux__in0;
  wire [8:0] mux__in1;
  wire [8:0] mux__out;
  wire  mux__sel;
  coreir_mux #(.width(9)) mux(
    .in0(mux__in0),
    .in1(mux__in1),
    .out(mux__out),
    .sel(mux__sel)
  );

  //Wire declarations for instance 'r' (Module reg_U25)
  wire  r__clk;
  wire  r__clr;
  wire  r__en;
  wire [8:0] r__in;
  wire [8:0] r__out;
  reg_U25 #(.init(init)) r(
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
  assign add__in1[8:0] = c1__out[8:0];
  assign add__in0[8:0] = r__out[8:0];
  assign out[8:0] = r__out[8:0];
  assign eq__in0[8:0] = r__out[8:0];
  assign mux__sel = eq__out;
  assign eq__in1[8:0] = maxval__out[8:0];
  assign mux__in0[8:0] = add__out[8:0];
  assign mux__in1[8:0] = c0__out[8:0];
  assign r__in[8:0] = mux__out[8:0];

endmodule //counter_U11

module reg_U12 #(parameter init=1) (
  input  clk,
  input  clr,
  input  en,
  input [9:0] in,
  output [9:0] out
);
  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [9:0] c0__out;
  coreir_const #(.value(10'b0000000000),.width(10)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'clrMux' (Module coreir_mux)
  wire [9:0] clrMux__in0;
  wire [9:0] clrMux__in1;
  wire [9:0] clrMux__out;
  wire  clrMux__sel;
  coreir_mux #(.width(10)) clrMux(
    .in0(clrMux__in0),
    .in1(clrMux__in1),
    .out(clrMux__out),
    .sel(clrMux__sel)
  );

  //Wire declarations for instance 'enMux' (Module coreir_mux)
  wire [9:0] enMux__in0;
  wire [9:0] enMux__in1;
  wire [9:0] enMux__out;
  wire  enMux__sel;
  coreir_mux #(.width(10)) enMux(
    .in0(enMux__in0),
    .in1(enMux__in1),
    .out(enMux__out),
    .sel(enMux__sel)
  );

  //Wire declarations for instance 'reg0' (Module coreir_reg)
  wire  reg0__clk;
  wire [9:0] reg0__in;
  wire [9:0] reg0__out;
  coreir_reg #(.clk_posedge(1),.init(init),.width(10)) reg0(
    .clk(reg0__clk),
    .in(reg0__in),
    .out(reg0__out)
  );

  //All the connections
  assign reg0__in[9:0] = enMux__out[9:0];
  assign out[9:0] = reg0__out[9:0];
  assign enMux__in0[9:0] = reg0__out[9:0];
  assign reg0__clk = clk;
  assign enMux__sel = en;
  assign enMux__in1[9:0] = clrMux__out[9:0];
  assign clrMux__in1[9:0] = c0__out[9:0];
  assign clrMux__sel = clr;
  assign clrMux__in0[9:0] = in[9:0];

endmodule //reg_U12

module reg_U13 #(parameter init=1) (
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

endmodule //reg_U13

module reg_U20 #(parameter init=1) (
  input  clk,
  input  clr,
  input  en,
  input [15:0] in,
  output [15:0] out
);
  //Wire declarations for instance 'c0' (Module coreir_const)
  wire [15:0] c0__out;
  coreir_const #(.value(16'b0000000000000000),.width(16)) c0(
    .out(c0__out)
  );

  //Wire declarations for instance 'clrMux' (Module coreir_mux)
  wire [15:0] clrMux__in0;
  wire [15:0] clrMux__in1;
  wire [15:0] clrMux__out;
  wire  clrMux__sel;
  coreir_mux #(.width(16)) clrMux(
    .in0(clrMux__in0),
    .in1(clrMux__in1),
    .out(clrMux__out),
    .sel(clrMux__sel)
  );

  //Wire declarations for instance 'enMux' (Module coreir_mux)
  wire [15:0] enMux__in0;
  wire [15:0] enMux__in1;
  wire [15:0] enMux__out;
  wire  enMux__sel;
  coreir_mux #(.width(16)) enMux(
    .in0(enMux__in0),
    .in1(enMux__in1),
    .out(enMux__out),
    .sel(enMux__sel)
  );

  //Wire declarations for instance 'reg0' (Module coreir_reg)
  wire  reg0__clk;
  wire [15:0] reg0__in;
  wire [15:0] reg0__out;
  coreir_reg #(.clk_posedge(1),.init(init),.width(16)) reg0(
    .clk(reg0__clk),
    .in(reg0__in),
    .out(reg0__out)
  );

  //All the connections
  assign reg0__in[15:0] = enMux__out[15:0];
  assign out[15:0] = reg0__out[15:0];
  assign enMux__in0[15:0] = reg0__out[15:0];
  assign reg0__clk = clk;
  assign enMux__sel = en;
  assign enMux__in1[15:0] = clrMux__out[15:0];
  assign clrMux__in1[15:0] = c0__out[15:0];
  assign clrMux__sel = clr;
  assign clrMux__in0[15:0] = in[15:0];

endmodule //reg_U20

module counter_U8 (
  input  clk,
  input  en,
  output [15:0] out,
  output  overflow,
  input  reset
);
  //Wire declarations for instance 'add' (Module coreir_add)
  wire [15:0] add__in0;
  wire [15:0] add__in1;
  wire [15:0] add__out;
  coreir_add #(.width(16)) add(
    .in0(add__in0),
    .in1(add__in1),
    .out(add__out)
  );

  //Wire declarations for instance 'count' (Module reg_U20)
  wire  count__clk;
  wire  count__clr;
  wire  count__en;
  wire [15:0] count__in;
  wire [15:0] count__out;
  reg_U20 #(.init(16'b0000000000000000)) count(
    .clk(count__clk),
    .clr(count__clr),
    .en(count__en),
    .in(count__in),
    .out(count__out)
  );

  //Wire declarations for instance 'inc' (Module coreir_const)
  wire [15:0] inc__out;
  coreir_const #(.value(16'b0000000000000001),.width(16)) inc(
    .out(inc__out)
  );

  //Wire declarations for instance 'max' (Module coreir_const)
  wire [15:0] max__out;
  coreir_const #(.value(16'b0000000011101111),.width(16)) max(
    .out(max__out)
  );

  //Wire declarations for instance 'resetOr' (Module coreir_or)
  wire [0:0] resetOr__in0;
  wire [0:0] resetOr__in1;
  wire [0:0] resetOr__out;
  coreir_or #(.width(1)) resetOr(
    .in0(resetOr__in0),
    .in1(resetOr__in1),
    .out(resetOr__out)
  );

  //Wire declarations for instance 'ult' (Module coreir_ult)
  wire [15:0] ult__in0;
  wire [15:0] ult__in1;
  wire  ult__out;
  coreir_ult #(.width(16)) ult(
    .in0(ult__in0),
    .in1(ult__in1),
    .out(ult__out)
  );

  //All the connections
  assign add__in0[15:0] = count__out[15:0];
  assign out[15:0] = count__out[15:0];
  assign add__in1[15:0] = inc__out[15:0];
  assign count__en = en;
  assign count__in[15:0] = add__out[15:0];
  assign ult__in1[15:0] = add__out[15:0];
  assign ult__in0[15:0] = max__out[15:0];
  assign resetOr__in0[0] = ult__out;
  assign overflow = ult__out;
  assign count__clr = resetOr__out[0];
  assign resetOr__in1[0] = reset;
  assign count__clk = clk;

endmodule //counter_U8

module counter_U7 (
  input  clk,
  input  en,
  output [15:0] out,
  output  overflow,
  input  reset
);
  //Wire declarations for instance 'add' (Module coreir_add)
  wire [15:0] add__in0;
  wire [15:0] add__in1;
  wire [15:0] add__out;
  coreir_add #(.width(16)) add(
    .in0(add__in0),
    .in1(add__in1),
    .out(add__out)
  );

  //Wire declarations for instance 'count' (Module reg_U20)
  wire  count__clk;
  wire  count__clr;
  wire  count__en;
  wire [15:0] count__in;
  wire [15:0] count__out;
  reg_U20 #(.init(16'b0000000000000000)) count(
    .clk(count__clk),
    .clr(count__clr),
    .en(count__en),
    .in(count__in),
    .out(count__out)
  );

  //Wire declarations for instance 'inc' (Module coreir_const)
  wire [15:0] inc__out;
  coreir_const #(.value(16'b0000000000000001),.width(16)) inc(
    .out(inc__out)
  );

  //Wire declarations for instance 'max' (Module coreir_const)
  wire [15:0] max__out;
  coreir_const #(.value(16'b0000000100111111),.width(16)) max(
    .out(max__out)
  );

  //Wire declarations for instance 'resetOr' (Module coreir_or)
  wire [0:0] resetOr__in0;
  wire [0:0] resetOr__in1;
  wire [0:0] resetOr__out;
  coreir_or #(.width(1)) resetOr(
    .in0(resetOr__in0),
    .in1(resetOr__in1),
    .out(resetOr__out)
  );

  //Wire declarations for instance 'ult' (Module coreir_ult)
  wire [15:0] ult__in0;
  wire [15:0] ult__in1;
  wire  ult__out;
  coreir_ult #(.width(16)) ult(
    .in0(ult__in0),
    .in1(ult__in1),
    .out(ult__out)
  );

  //All the connections
  assign add__in0[15:0] = count__out[15:0];
  assign out[15:0] = count__out[15:0];
  assign add__in1[15:0] = inc__out[15:0];
  assign count__en = en;
  assign count__in[15:0] = add__out[15:0];
  assign ult__in1[15:0] = add__out[15:0];
  assign ult__in0[15:0] = max__out[15:0];
  assign resetOr__in0[0] = ult__out;
  assign overflow = ult__out;
  assign count__clr = resetOr__out[0];
  assign resetOr__in1[0] = reset;
  assign count__clk = clk;

endmodule //counter_U7

module rowbuffer_U4 (
  input  clk,
  input  flush,
  output [15:0] rdata,
  output  valid,
  input [15:0] wdata,
  input  wen
);
  //Wire declarations for instance 'add_wen' (Module coreir_add)
  wire [9:0] add_wen__in0;
  wire [9:0] add_wen__in1;
  wire [9:0] add_wen__out;
  coreir_add #(.width(10)) add_wen(
    .in0(add_wen__in0),
    .in1(add_wen__in1),
    .out(add_wen__out)
  );

  //Wire declarations for instance 'c1' (Module corebit_const)
  wire  c1__out;
  corebit_const #(.value(1)) c1(
    .out(c1__out)
  );

  //Wire declarations for instance 'cnt' (Module reg_U12)
  wire  cnt__clk;
  wire  cnt__clr;
  wire  cnt__en;
  wire [9:0] cnt__in;
  wire [9:0] cnt__out;
  reg_U12 #(.init(10'b0000000000)) cnt(
    .clk(cnt__clk),
    .clr(cnt__clr),
    .en(cnt__en),
    .in(cnt__in),
    .out(cnt__out)
  );

  //Wire declarations for instance 'depth_m1' (Module coreir_const)
  wire [9:0] depth_m1__out;
  coreir_const #(.value(10'b0101000000),.width(10)) depth_m1(
    .out(depth_m1__out)
  );

  //Wire declarations for instance 'eq_depth' (Module coreir_eq)
  wire [9:0] eq_depth__in0;
  wire [9:0] eq_depth__in1;
  wire  eq_depth__out;
  coreir_eq #(.width(10)) eq_depth(
    .in0(eq_depth__in0),
    .in1(eq_depth__in1),
    .out(eq_depth__out)
  );

  //Wire declarations for instance 'mem' (Module coreir_mem)
  wire  mem__clk;
  wire [8:0] mem__raddr;
  wire [15:0] mem__rdata;
  wire [8:0] mem__waddr;
  wire [15:0] mem__wdata;
  wire  mem__wen;
  coreir_mem #(.depth(320),.has_init(0),.width(16)) mem(
    .clk(mem__clk),
    .raddr(mem__raddr),
    .rdata(mem__rdata),
    .waddr(mem__waddr),
    .wdata(mem__wdata),
    .wen(mem__wen)
  );

  //Wire declarations for instance 'out_and_wen' (Module corebit_and)
  wire  out_and_wen__in0;
  wire  out_and_wen__in1;
  wire  out_and_wen__out;
  corebit_and out_and_wen(
    .in0(out_and_wen__in0),
    .in1(out_and_wen__in1),
    .out(out_and_wen__out)
  );

  //Wire declarations for instance 'raddr' (Module counter_U11)
  wire  raddr__clk;
  wire  raddr__en;
  wire [8:0] raddr__out;
  wire  raddr__srst;
  counter_U11 #(.init(9'b000000000),.max(9'b100111111)) raddr(
    .clk(raddr__clk),
    .en(raddr__en),
    .out(raddr__out),
    .srst(raddr__srst)
  );

  //Wire declarations for instance 'state' (Module reg_U13)
  wire  state__clk;
  wire  state__clr;
  wire  state__en;
  wire [0:0] state__in;
  wire [0:0] state__out;
  reg_U13 #(.init(1'b0)) state(
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

  //Wire declarations for instance 'waddr' (Module counter_U11)
  wire  waddr__clk;
  wire  waddr__en;
  wire [8:0] waddr__out;
  wire  waddr__srst;
  counter_U11 #(.init(9'b000000000),.max(9'b100111111)) waddr(
    .clk(waddr__clk),
    .en(waddr__en),
    .out(waddr__out),
    .srst(waddr__srst)
  );

  //Wire declarations for instance 'wen_ext' (Module coreir_zext)
  wire [0:0] wen_ext__in;
  wire [9:0] wen_ext__out;
  coreir_zext #(.width_in(1),.width_out(10)) wen_ext(
    .in(wen_ext__in),
    .out(wen_ext__out)
  );

  //All the connections
  assign state__clk = clk;
  assign mem__clk = clk;
  assign raddr__clk = clk;
  assign waddr__clk = clk;
  assign cnt__clk = clk;
  assign mem__raddr[8:0] = raddr__out[8:0];
  assign mem__waddr[8:0] = waddr__out[8:0];
  assign rdata[15:0] = mem__rdata[15:0];
  assign mem__wdata[15:0] = wdata[15:0];
  assign mem__wen = wen;
  assign valid = out_and_wen__out;
  assign raddr__en = out_and_wen__out;
  assign out_and_wen__in1 = wen;
  assign waddr__en = wen;
  assign wen_ext__in[0] = wen;
  assign out_and_wen__in0 = state__out[0];
  assign state0__in = state__out[0];
  assign raddr__srst = flush;
  assign waddr__srst = flush;
  assign cnt__clr = flush;
  assign state__clr = flush;
  assign cnt__en = state0__out;
  assign add_wen__in0[9:0] = wen_ext__out[9:0];
  assign add_wen__in1[9:0] = cnt__out[9:0];
  assign cnt__in[9:0] = add_wen__out[9:0];
  assign eq_depth__in1[9:0] = add_wen__out[9:0];
  assign eq_depth__in0[9:0] = depth_m1__out[9:0];
  assign state__en = eq_depth__out;
  assign state__in[0] = c1__out;

endmodule //rowbuffer_U4

module linebuffer_U0 (
  input  clk,
  input [15:0] in_0_0,
  output [15:0] out_0_0,
  output [15:0] out_0_1,
  output [15:0] out_0_10,
  output [15:0] out_0_11,
  output [15:0] out_0_12,
  output [15:0] out_0_13,
  output [15:0] out_0_14,
  output [15:0] out_0_15,
  output [15:0] out_0_16,
  output [15:0] out_0_17,
  output [15:0] out_0_18,
  output [15:0] out_0_19,
  output [15:0] out_0_2,
  output [15:0] out_0_3,
  output [15:0] out_0_4,
  output [15:0] out_0_5,
  output [15:0] out_0_6,
  output [15:0] out_0_7,
  output [15:0] out_0_8,
  output [15:0] out_0_9,
  output [15:0] out_10_0,
  output [15:0] out_10_1,
  output [15:0] out_10_10,
  output [15:0] out_10_11,
  output [15:0] out_10_12,
  output [15:0] out_10_13,
  output [15:0] out_10_14,
  output [15:0] out_10_15,
  output [15:0] out_10_16,
  output [15:0] out_10_17,
  output [15:0] out_10_18,
  output [15:0] out_10_19,
  output [15:0] out_10_2,
  output [15:0] out_10_3,
  output [15:0] out_10_4,
  output [15:0] out_10_5,
  output [15:0] out_10_6,
  output [15:0] out_10_7,
  output [15:0] out_10_8,
  output [15:0] out_10_9,
  output [15:0] out_11_0,
  output [15:0] out_11_1,
  output [15:0] out_11_10,
  output [15:0] out_11_11,
  output [15:0] out_11_12,
  output [15:0] out_11_13,
  output [15:0] out_11_14,
  output [15:0] out_11_15,
  output [15:0] out_11_16,
  output [15:0] out_11_17,
  output [15:0] out_11_18,
  output [15:0] out_11_19,
  output [15:0] out_11_2,
  output [15:0] out_11_3,
  output [15:0] out_11_4,
  output [15:0] out_11_5,
  output [15:0] out_11_6,
  output [15:0] out_11_7,
  output [15:0] out_11_8,
  output [15:0] out_11_9,
  output [15:0] out_12_0,
  output [15:0] out_12_1,
  output [15:0] out_12_10,
  output [15:0] out_12_11,
  output [15:0] out_12_12,
  output [15:0] out_12_13,
  output [15:0] out_12_14,
  output [15:0] out_12_15,
  output [15:0] out_12_16,
  output [15:0] out_12_17,
  output [15:0] out_12_18,
  output [15:0] out_12_19,
  output [15:0] out_12_2,
  output [15:0] out_12_3,
  output [15:0] out_12_4,
  output [15:0] out_12_5,
  output [15:0] out_12_6,
  output [15:0] out_12_7,
  output [15:0] out_12_8,
  output [15:0] out_12_9,
  output [15:0] out_13_0,
  output [15:0] out_13_1,
  output [15:0] out_13_10,
  output [15:0] out_13_11,
  output [15:0] out_13_12,
  output [15:0] out_13_13,
  output [15:0] out_13_14,
  output [15:0] out_13_15,
  output [15:0] out_13_16,
  output [15:0] out_13_17,
  output [15:0] out_13_18,
  output [15:0] out_13_19,
  output [15:0] out_13_2,
  output [15:0] out_13_3,
  output [15:0] out_13_4,
  output [15:0] out_13_5,
  output [15:0] out_13_6,
  output [15:0] out_13_7,
  output [15:0] out_13_8,
  output [15:0] out_13_9,
  output [15:0] out_14_0,
  output [15:0] out_14_1,
  output [15:0] out_14_10,
  output [15:0] out_14_11,
  output [15:0] out_14_12,
  output [15:0] out_14_13,
  output [15:0] out_14_14,
  output [15:0] out_14_15,
  output [15:0] out_14_16,
  output [15:0] out_14_17,
  output [15:0] out_14_18,
  output [15:0] out_14_19,
  output [15:0] out_14_2,
  output [15:0] out_14_3,
  output [15:0] out_14_4,
  output [15:0] out_14_5,
  output [15:0] out_14_6,
  output [15:0] out_14_7,
  output [15:0] out_14_8,
  output [15:0] out_14_9,
  output [15:0] out_15_0,
  output [15:0] out_15_1,
  output [15:0] out_15_10,
  output [15:0] out_15_11,
  output [15:0] out_15_12,
  output [15:0] out_15_13,
  output [15:0] out_15_14,
  output [15:0] out_15_15,
  output [15:0] out_15_16,
  output [15:0] out_15_17,
  output [15:0] out_15_18,
  output [15:0] out_15_19,
  output [15:0] out_15_2,
  output [15:0] out_15_3,
  output [15:0] out_15_4,
  output [15:0] out_15_5,
  output [15:0] out_15_6,
  output [15:0] out_15_7,
  output [15:0] out_15_8,
  output [15:0] out_15_9,
  output [15:0] out_1_0,
  output [15:0] out_1_1,
  output [15:0] out_1_10,
  output [15:0] out_1_11,
  output [15:0] out_1_12,
  output [15:0] out_1_13,
  output [15:0] out_1_14,
  output [15:0] out_1_15,
  output [15:0] out_1_16,
  output [15:0] out_1_17,
  output [15:0] out_1_18,
  output [15:0] out_1_19,
  output [15:0] out_1_2,
  output [15:0] out_1_3,
  output [15:0] out_1_4,
  output [15:0] out_1_5,
  output [15:0] out_1_6,
  output [15:0] out_1_7,
  output [15:0] out_1_8,
  output [15:0] out_1_9,
  output [15:0] out_2_0,
  output [15:0] out_2_1,
  output [15:0] out_2_10,
  output [15:0] out_2_11,
  output [15:0] out_2_12,
  output [15:0] out_2_13,
  output [15:0] out_2_14,
  output [15:0] out_2_15,
  output [15:0] out_2_16,
  output [15:0] out_2_17,
  output [15:0] out_2_18,
  output [15:0] out_2_19,
  output [15:0] out_2_2,
  output [15:0] out_2_3,
  output [15:0] out_2_4,
  output [15:0] out_2_5,
  output [15:0] out_2_6,
  output [15:0] out_2_7,
  output [15:0] out_2_8,
  output [15:0] out_2_9,
  output [15:0] out_3_0,
  output [15:0] out_3_1,
  output [15:0] out_3_10,
  output [15:0] out_3_11,
  output [15:0] out_3_12,
  output [15:0] out_3_13,
  output [15:0] out_3_14,
  output [15:0] out_3_15,
  output [15:0] out_3_16,
  output [15:0] out_3_17,
  output [15:0] out_3_18,
  output [15:0] out_3_19,
  output [15:0] out_3_2,
  output [15:0] out_3_3,
  output [15:0] out_3_4,
  output [15:0] out_3_5,
  output [15:0] out_3_6,
  output [15:0] out_3_7,
  output [15:0] out_3_8,
  output [15:0] out_3_9,
  output [15:0] out_4_0,
  output [15:0] out_4_1,
  output [15:0] out_4_10,
  output [15:0] out_4_11,
  output [15:0] out_4_12,
  output [15:0] out_4_13,
  output [15:0] out_4_14,
  output [15:0] out_4_15,
  output [15:0] out_4_16,
  output [15:0] out_4_17,
  output [15:0] out_4_18,
  output [15:0] out_4_19,
  output [15:0] out_4_2,
  output [15:0] out_4_3,
  output [15:0] out_4_4,
  output [15:0] out_4_5,
  output [15:0] out_4_6,
  output [15:0] out_4_7,
  output [15:0] out_4_8,
  output [15:0] out_4_9,
  output [15:0] out_5_0,
  output [15:0] out_5_1,
  output [15:0] out_5_10,
  output [15:0] out_5_11,
  output [15:0] out_5_12,
  output [15:0] out_5_13,
  output [15:0] out_5_14,
  output [15:0] out_5_15,
  output [15:0] out_5_16,
  output [15:0] out_5_17,
  output [15:0] out_5_18,
  output [15:0] out_5_19,
  output [15:0] out_5_2,
  output [15:0] out_5_3,
  output [15:0] out_5_4,
  output [15:0] out_5_5,
  output [15:0] out_5_6,
  output [15:0] out_5_7,
  output [15:0] out_5_8,
  output [15:0] out_5_9,
  output [15:0] out_6_0,
  output [15:0] out_6_1,
  output [15:0] out_6_10,
  output [15:0] out_6_11,
  output [15:0] out_6_12,
  output [15:0] out_6_13,
  output [15:0] out_6_14,
  output [15:0] out_6_15,
  output [15:0] out_6_16,
  output [15:0] out_6_17,
  output [15:0] out_6_18,
  output [15:0] out_6_19,
  output [15:0] out_6_2,
  output [15:0] out_6_3,
  output [15:0] out_6_4,
  output [15:0] out_6_5,
  output [15:0] out_6_6,
  output [15:0] out_6_7,
  output [15:0] out_6_8,
  output [15:0] out_6_9,
  output [15:0] out_7_0,
  output [15:0] out_7_1,
  output [15:0] out_7_10,
  output [15:0] out_7_11,
  output [15:0] out_7_12,
  output [15:0] out_7_13,
  output [15:0] out_7_14,
  output [15:0] out_7_15,
  output [15:0] out_7_16,
  output [15:0] out_7_17,
  output [15:0] out_7_18,
  output [15:0] out_7_19,
  output [15:0] out_7_2,
  output [15:0] out_7_3,
  output [15:0] out_7_4,
  output [15:0] out_7_5,
  output [15:0] out_7_6,
  output [15:0] out_7_7,
  output [15:0] out_7_8,
  output [15:0] out_7_9,
  output [15:0] out_8_0,
  output [15:0] out_8_1,
  output [15:0] out_8_10,
  output [15:0] out_8_11,
  output [15:0] out_8_12,
  output [15:0] out_8_13,
  output [15:0] out_8_14,
  output [15:0] out_8_15,
  output [15:0] out_8_16,
  output [15:0] out_8_17,
  output [15:0] out_8_18,
  output [15:0] out_8_19,
  output [15:0] out_8_2,
  output [15:0] out_8_3,
  output [15:0] out_8_4,
  output [15:0] out_8_5,
  output [15:0] out_8_6,
  output [15:0] out_8_7,
  output [15:0] out_8_8,
  output [15:0] out_8_9,
  output [15:0] out_9_0,
  output [15:0] out_9_1,
  output [15:0] out_9_10,
  output [15:0] out_9_11,
  output [15:0] out_9_12,
  output [15:0] out_9_13,
  output [15:0] out_9_14,
  output [15:0] out_9_15,
  output [15:0] out_9_16,
  output [15:0] out_9_17,
  output [15:0] out_9_18,
  output [15:0] out_9_19,
  output [15:0] out_9_2,
  output [15:0] out_9_3,
  output [15:0] out_9_4,
  output [15:0] out_9_5,
  output [15:0] out_9_6,
  output [15:0] out_9_7,
  output [15:0] out_9_8,
  output [15:0] out_9_9,
  output  valid,
  output  valid_chain,
  input  wen
);
  //Wire declarations for instance 'const_stencil0' (Module coreir_const)
  wire [15:0] const_stencil0__out;
  coreir_const #(.value(16'b0000000000010011),.width(16)) const_stencil0(
    .out(const_stencil0__out)
  );

  //Wire declarations for instance 'const_stencil1' (Module coreir_const)
  wire [15:0] const_stencil1__out;
  coreir_const #(.value(16'b0000000000001111),.width(16)) const_stencil1(
    .out(const_stencil1__out)
  );

  //Wire declarations for instance 'lb1d_0' (Module linebuffer_U3)
  wire  lb1d_0__clk;
  wire [15:0] lb1d_0__in_0;
  wire [15:0] lb1d_0__out_0;
  wire [15:0] lb1d_0__out_1;
  wire [15:0] lb1d_0__out_10;
  wire [15:0] lb1d_0__out_11;
  wire [15:0] lb1d_0__out_12;
  wire [15:0] lb1d_0__out_13;
  wire [15:0] lb1d_0__out_14;
  wire [15:0] lb1d_0__out_15;
  wire [15:0] lb1d_0__out_16;
  wire [15:0] lb1d_0__out_17;
  wire [15:0] lb1d_0__out_18;
  wire [15:0] lb1d_0__out_19;
  wire [15:0] lb1d_0__out_2;
  wire [15:0] lb1d_0__out_3;
  wire [15:0] lb1d_0__out_4;
  wire [15:0] lb1d_0__out_5;
  wire [15:0] lb1d_0__out_6;
  wire [15:0] lb1d_0__out_7;
  wire [15:0] lb1d_0__out_8;
  wire [15:0] lb1d_0__out_9;
  wire  lb1d_0__valid;
  wire  lb1d_0__valid_chain;
  wire  lb1d_0__wen;
  linebuffer_U3 lb1d_0(
    .clk(lb1d_0__clk),
    .in_0(lb1d_0__in_0),
    .out_0(lb1d_0__out_0),
    .out_1(lb1d_0__out_1),
    .out_10(lb1d_0__out_10),
    .out_11(lb1d_0__out_11),
    .out_12(lb1d_0__out_12),
    .out_13(lb1d_0__out_13),
    .out_14(lb1d_0__out_14),
    .out_15(lb1d_0__out_15),
    .out_16(lb1d_0__out_16),
    .out_17(lb1d_0__out_17),
    .out_18(lb1d_0__out_18),
    .out_19(lb1d_0__out_19),
    .out_2(lb1d_0__out_2),
    .out_3(lb1d_0__out_3),
    .out_4(lb1d_0__out_4),
    .out_5(lb1d_0__out_5),
    .out_6(lb1d_0__out_6),
    .out_7(lb1d_0__out_7),
    .out_8(lb1d_0__out_8),
    .out_9(lb1d_0__out_9),
    .valid(lb1d_0__valid),
    .valid_chain(lb1d_0__valid_chain),
    .wen(lb1d_0__wen)
  );

  //Wire declarations for instance 'lb1d_1' (Module linebuffer_U3)
  wire  lb1d_1__clk;
  wire [15:0] lb1d_1__in_0;
  wire [15:0] lb1d_1__out_0;
  wire [15:0] lb1d_1__out_1;
  wire [15:0] lb1d_1__out_10;
  wire [15:0] lb1d_1__out_11;
  wire [15:0] lb1d_1__out_12;
  wire [15:0] lb1d_1__out_13;
  wire [15:0] lb1d_1__out_14;
  wire [15:0] lb1d_1__out_15;
  wire [15:0] lb1d_1__out_16;
  wire [15:0] lb1d_1__out_17;
  wire [15:0] lb1d_1__out_18;
  wire [15:0] lb1d_1__out_19;
  wire [15:0] lb1d_1__out_2;
  wire [15:0] lb1d_1__out_3;
  wire [15:0] lb1d_1__out_4;
  wire [15:0] lb1d_1__out_5;
  wire [15:0] lb1d_1__out_6;
  wire [15:0] lb1d_1__out_7;
  wire [15:0] lb1d_1__out_8;
  wire [15:0] lb1d_1__out_9;
  wire  lb1d_1__valid;
  wire  lb1d_1__valid_chain;
  wire  lb1d_1__wen;
  linebuffer_U3 lb1d_1(
    .clk(lb1d_1__clk),
    .in_0(lb1d_1__in_0),
    .out_0(lb1d_1__out_0),
    .out_1(lb1d_1__out_1),
    .out_10(lb1d_1__out_10),
    .out_11(lb1d_1__out_11),
    .out_12(lb1d_1__out_12),
    .out_13(lb1d_1__out_13),
    .out_14(lb1d_1__out_14),
    .out_15(lb1d_1__out_15),
    .out_16(lb1d_1__out_16),
    .out_17(lb1d_1__out_17),
    .out_18(lb1d_1__out_18),
    .out_19(lb1d_1__out_19),
    .out_2(lb1d_1__out_2),
    .out_3(lb1d_1__out_3),
    .out_4(lb1d_1__out_4),
    .out_5(lb1d_1__out_5),
    .out_6(lb1d_1__out_6),
    .out_7(lb1d_1__out_7),
    .out_8(lb1d_1__out_8),
    .out_9(lb1d_1__out_9),
    .valid(lb1d_1__valid),
    .valid_chain(lb1d_1__valid_chain),
    .wen(lb1d_1__wen)
  );

  //Wire declarations for instance 'lb1d_10' (Module linebuffer_U3)
  wire  lb1d_10__clk;
  wire [15:0] lb1d_10__in_0;
  wire [15:0] lb1d_10__out_0;
  wire [15:0] lb1d_10__out_1;
  wire [15:0] lb1d_10__out_10;
  wire [15:0] lb1d_10__out_11;
  wire [15:0] lb1d_10__out_12;
  wire [15:0] lb1d_10__out_13;
  wire [15:0] lb1d_10__out_14;
  wire [15:0] lb1d_10__out_15;
  wire [15:0] lb1d_10__out_16;
  wire [15:0] lb1d_10__out_17;
  wire [15:0] lb1d_10__out_18;
  wire [15:0] lb1d_10__out_19;
  wire [15:0] lb1d_10__out_2;
  wire [15:0] lb1d_10__out_3;
  wire [15:0] lb1d_10__out_4;
  wire [15:0] lb1d_10__out_5;
  wire [15:0] lb1d_10__out_6;
  wire [15:0] lb1d_10__out_7;
  wire [15:0] lb1d_10__out_8;
  wire [15:0] lb1d_10__out_9;
  wire  lb1d_10__valid;
  wire  lb1d_10__valid_chain;
  wire  lb1d_10__wen;
  linebuffer_U3 lb1d_10(
    .clk(lb1d_10__clk),
    .in_0(lb1d_10__in_0),
    .out_0(lb1d_10__out_0),
    .out_1(lb1d_10__out_1),
    .out_10(lb1d_10__out_10),
    .out_11(lb1d_10__out_11),
    .out_12(lb1d_10__out_12),
    .out_13(lb1d_10__out_13),
    .out_14(lb1d_10__out_14),
    .out_15(lb1d_10__out_15),
    .out_16(lb1d_10__out_16),
    .out_17(lb1d_10__out_17),
    .out_18(lb1d_10__out_18),
    .out_19(lb1d_10__out_19),
    .out_2(lb1d_10__out_2),
    .out_3(lb1d_10__out_3),
    .out_4(lb1d_10__out_4),
    .out_5(lb1d_10__out_5),
    .out_6(lb1d_10__out_6),
    .out_7(lb1d_10__out_7),
    .out_8(lb1d_10__out_8),
    .out_9(lb1d_10__out_9),
    .valid(lb1d_10__valid),
    .valid_chain(lb1d_10__valid_chain),
    .wen(lb1d_10__wen)
  );

  //Wire declarations for instance 'lb1d_11' (Module linebuffer_U3)
  wire  lb1d_11__clk;
  wire [15:0] lb1d_11__in_0;
  wire [15:0] lb1d_11__out_0;
  wire [15:0] lb1d_11__out_1;
  wire [15:0] lb1d_11__out_10;
  wire [15:0] lb1d_11__out_11;
  wire [15:0] lb1d_11__out_12;
  wire [15:0] lb1d_11__out_13;
  wire [15:0] lb1d_11__out_14;
  wire [15:0] lb1d_11__out_15;
  wire [15:0] lb1d_11__out_16;
  wire [15:0] lb1d_11__out_17;
  wire [15:0] lb1d_11__out_18;
  wire [15:0] lb1d_11__out_19;
  wire [15:0] lb1d_11__out_2;
  wire [15:0] lb1d_11__out_3;
  wire [15:0] lb1d_11__out_4;
  wire [15:0] lb1d_11__out_5;
  wire [15:0] lb1d_11__out_6;
  wire [15:0] lb1d_11__out_7;
  wire [15:0] lb1d_11__out_8;
  wire [15:0] lb1d_11__out_9;
  wire  lb1d_11__valid;
  wire  lb1d_11__valid_chain;
  wire  lb1d_11__wen;
  linebuffer_U3 lb1d_11(
    .clk(lb1d_11__clk),
    .in_0(lb1d_11__in_0),
    .out_0(lb1d_11__out_0),
    .out_1(lb1d_11__out_1),
    .out_10(lb1d_11__out_10),
    .out_11(lb1d_11__out_11),
    .out_12(lb1d_11__out_12),
    .out_13(lb1d_11__out_13),
    .out_14(lb1d_11__out_14),
    .out_15(lb1d_11__out_15),
    .out_16(lb1d_11__out_16),
    .out_17(lb1d_11__out_17),
    .out_18(lb1d_11__out_18),
    .out_19(lb1d_11__out_19),
    .out_2(lb1d_11__out_2),
    .out_3(lb1d_11__out_3),
    .out_4(lb1d_11__out_4),
    .out_5(lb1d_11__out_5),
    .out_6(lb1d_11__out_6),
    .out_7(lb1d_11__out_7),
    .out_8(lb1d_11__out_8),
    .out_9(lb1d_11__out_9),
    .valid(lb1d_11__valid),
    .valid_chain(lb1d_11__valid_chain),
    .wen(lb1d_11__wen)
  );

  //Wire declarations for instance 'lb1d_12' (Module linebuffer_U3)
  wire  lb1d_12__clk;
  wire [15:0] lb1d_12__in_0;
  wire [15:0] lb1d_12__out_0;
  wire [15:0] lb1d_12__out_1;
  wire [15:0] lb1d_12__out_10;
  wire [15:0] lb1d_12__out_11;
  wire [15:0] lb1d_12__out_12;
  wire [15:0] lb1d_12__out_13;
  wire [15:0] lb1d_12__out_14;
  wire [15:0] lb1d_12__out_15;
  wire [15:0] lb1d_12__out_16;
  wire [15:0] lb1d_12__out_17;
  wire [15:0] lb1d_12__out_18;
  wire [15:0] lb1d_12__out_19;
  wire [15:0] lb1d_12__out_2;
  wire [15:0] lb1d_12__out_3;
  wire [15:0] lb1d_12__out_4;
  wire [15:0] lb1d_12__out_5;
  wire [15:0] lb1d_12__out_6;
  wire [15:0] lb1d_12__out_7;
  wire [15:0] lb1d_12__out_8;
  wire [15:0] lb1d_12__out_9;
  wire  lb1d_12__valid;
  wire  lb1d_12__valid_chain;
  wire  lb1d_12__wen;
  linebuffer_U3 lb1d_12(
    .clk(lb1d_12__clk),
    .in_0(lb1d_12__in_0),
    .out_0(lb1d_12__out_0),
    .out_1(lb1d_12__out_1),
    .out_10(lb1d_12__out_10),
    .out_11(lb1d_12__out_11),
    .out_12(lb1d_12__out_12),
    .out_13(lb1d_12__out_13),
    .out_14(lb1d_12__out_14),
    .out_15(lb1d_12__out_15),
    .out_16(lb1d_12__out_16),
    .out_17(lb1d_12__out_17),
    .out_18(lb1d_12__out_18),
    .out_19(lb1d_12__out_19),
    .out_2(lb1d_12__out_2),
    .out_3(lb1d_12__out_3),
    .out_4(lb1d_12__out_4),
    .out_5(lb1d_12__out_5),
    .out_6(lb1d_12__out_6),
    .out_7(lb1d_12__out_7),
    .out_8(lb1d_12__out_8),
    .out_9(lb1d_12__out_9),
    .valid(lb1d_12__valid),
    .valid_chain(lb1d_12__valid_chain),
    .wen(lb1d_12__wen)
  );

  //Wire declarations for instance 'lb1d_13' (Module linebuffer_U3)
  wire  lb1d_13__clk;
  wire [15:0] lb1d_13__in_0;
  wire [15:0] lb1d_13__out_0;
  wire [15:0] lb1d_13__out_1;
  wire [15:0] lb1d_13__out_10;
  wire [15:0] lb1d_13__out_11;
  wire [15:0] lb1d_13__out_12;
  wire [15:0] lb1d_13__out_13;
  wire [15:0] lb1d_13__out_14;
  wire [15:0] lb1d_13__out_15;
  wire [15:0] lb1d_13__out_16;
  wire [15:0] lb1d_13__out_17;
  wire [15:0] lb1d_13__out_18;
  wire [15:0] lb1d_13__out_19;
  wire [15:0] lb1d_13__out_2;
  wire [15:0] lb1d_13__out_3;
  wire [15:0] lb1d_13__out_4;
  wire [15:0] lb1d_13__out_5;
  wire [15:0] lb1d_13__out_6;
  wire [15:0] lb1d_13__out_7;
  wire [15:0] lb1d_13__out_8;
  wire [15:0] lb1d_13__out_9;
  wire  lb1d_13__valid;
  wire  lb1d_13__valid_chain;
  wire  lb1d_13__wen;
  linebuffer_U3 lb1d_13(
    .clk(lb1d_13__clk),
    .in_0(lb1d_13__in_0),
    .out_0(lb1d_13__out_0),
    .out_1(lb1d_13__out_1),
    .out_10(lb1d_13__out_10),
    .out_11(lb1d_13__out_11),
    .out_12(lb1d_13__out_12),
    .out_13(lb1d_13__out_13),
    .out_14(lb1d_13__out_14),
    .out_15(lb1d_13__out_15),
    .out_16(lb1d_13__out_16),
    .out_17(lb1d_13__out_17),
    .out_18(lb1d_13__out_18),
    .out_19(lb1d_13__out_19),
    .out_2(lb1d_13__out_2),
    .out_3(lb1d_13__out_3),
    .out_4(lb1d_13__out_4),
    .out_5(lb1d_13__out_5),
    .out_6(lb1d_13__out_6),
    .out_7(lb1d_13__out_7),
    .out_8(lb1d_13__out_8),
    .out_9(lb1d_13__out_9),
    .valid(lb1d_13__valid),
    .valid_chain(lb1d_13__valid_chain),
    .wen(lb1d_13__wen)
  );

  //Wire declarations for instance 'lb1d_14' (Module linebuffer_U3)
  wire  lb1d_14__clk;
  wire [15:0] lb1d_14__in_0;
  wire [15:0] lb1d_14__out_0;
  wire [15:0] lb1d_14__out_1;
  wire [15:0] lb1d_14__out_10;
  wire [15:0] lb1d_14__out_11;
  wire [15:0] lb1d_14__out_12;
  wire [15:0] lb1d_14__out_13;
  wire [15:0] lb1d_14__out_14;
  wire [15:0] lb1d_14__out_15;
  wire [15:0] lb1d_14__out_16;
  wire [15:0] lb1d_14__out_17;
  wire [15:0] lb1d_14__out_18;
  wire [15:0] lb1d_14__out_19;
  wire [15:0] lb1d_14__out_2;
  wire [15:0] lb1d_14__out_3;
  wire [15:0] lb1d_14__out_4;
  wire [15:0] lb1d_14__out_5;
  wire [15:0] lb1d_14__out_6;
  wire [15:0] lb1d_14__out_7;
  wire [15:0] lb1d_14__out_8;
  wire [15:0] lb1d_14__out_9;
  wire  lb1d_14__valid;
  wire  lb1d_14__valid_chain;
  wire  lb1d_14__wen;
  linebuffer_U3 lb1d_14(
    .clk(lb1d_14__clk),
    .in_0(lb1d_14__in_0),
    .out_0(lb1d_14__out_0),
    .out_1(lb1d_14__out_1),
    .out_10(lb1d_14__out_10),
    .out_11(lb1d_14__out_11),
    .out_12(lb1d_14__out_12),
    .out_13(lb1d_14__out_13),
    .out_14(lb1d_14__out_14),
    .out_15(lb1d_14__out_15),
    .out_16(lb1d_14__out_16),
    .out_17(lb1d_14__out_17),
    .out_18(lb1d_14__out_18),
    .out_19(lb1d_14__out_19),
    .out_2(lb1d_14__out_2),
    .out_3(lb1d_14__out_3),
    .out_4(lb1d_14__out_4),
    .out_5(lb1d_14__out_5),
    .out_6(lb1d_14__out_6),
    .out_7(lb1d_14__out_7),
    .out_8(lb1d_14__out_8),
    .out_9(lb1d_14__out_9),
    .valid(lb1d_14__valid),
    .valid_chain(lb1d_14__valid_chain),
    .wen(lb1d_14__wen)
  );

  //Wire declarations for instance 'lb1d_15' (Module linebuffer_U3)
  wire  lb1d_15__clk;
  wire [15:0] lb1d_15__in_0;
  wire [15:0] lb1d_15__out_0;
  wire [15:0] lb1d_15__out_1;
  wire [15:0] lb1d_15__out_10;
  wire [15:0] lb1d_15__out_11;
  wire [15:0] lb1d_15__out_12;
  wire [15:0] lb1d_15__out_13;
  wire [15:0] lb1d_15__out_14;
  wire [15:0] lb1d_15__out_15;
  wire [15:0] lb1d_15__out_16;
  wire [15:0] lb1d_15__out_17;
  wire [15:0] lb1d_15__out_18;
  wire [15:0] lb1d_15__out_19;
  wire [15:0] lb1d_15__out_2;
  wire [15:0] lb1d_15__out_3;
  wire [15:0] lb1d_15__out_4;
  wire [15:0] lb1d_15__out_5;
  wire [15:0] lb1d_15__out_6;
  wire [15:0] lb1d_15__out_7;
  wire [15:0] lb1d_15__out_8;
  wire [15:0] lb1d_15__out_9;
  wire  lb1d_15__valid;
  wire  lb1d_15__valid_chain;
  wire  lb1d_15__wen;
  linebuffer_U3 lb1d_15(
    .clk(lb1d_15__clk),
    .in_0(lb1d_15__in_0),
    .out_0(lb1d_15__out_0),
    .out_1(lb1d_15__out_1),
    .out_10(lb1d_15__out_10),
    .out_11(lb1d_15__out_11),
    .out_12(lb1d_15__out_12),
    .out_13(lb1d_15__out_13),
    .out_14(lb1d_15__out_14),
    .out_15(lb1d_15__out_15),
    .out_16(lb1d_15__out_16),
    .out_17(lb1d_15__out_17),
    .out_18(lb1d_15__out_18),
    .out_19(lb1d_15__out_19),
    .out_2(lb1d_15__out_2),
    .out_3(lb1d_15__out_3),
    .out_4(lb1d_15__out_4),
    .out_5(lb1d_15__out_5),
    .out_6(lb1d_15__out_6),
    .out_7(lb1d_15__out_7),
    .out_8(lb1d_15__out_8),
    .out_9(lb1d_15__out_9),
    .valid(lb1d_15__valid),
    .valid_chain(lb1d_15__valid_chain),
    .wen(lb1d_15__wen)
  );

  //Wire declarations for instance 'lb1d_2' (Module linebuffer_U3)
  wire  lb1d_2__clk;
  wire [15:0] lb1d_2__in_0;
  wire [15:0] lb1d_2__out_0;
  wire [15:0] lb1d_2__out_1;
  wire [15:0] lb1d_2__out_10;
  wire [15:0] lb1d_2__out_11;
  wire [15:0] lb1d_2__out_12;
  wire [15:0] lb1d_2__out_13;
  wire [15:0] lb1d_2__out_14;
  wire [15:0] lb1d_2__out_15;
  wire [15:0] lb1d_2__out_16;
  wire [15:0] lb1d_2__out_17;
  wire [15:0] lb1d_2__out_18;
  wire [15:0] lb1d_2__out_19;
  wire [15:0] lb1d_2__out_2;
  wire [15:0] lb1d_2__out_3;
  wire [15:0] lb1d_2__out_4;
  wire [15:0] lb1d_2__out_5;
  wire [15:0] lb1d_2__out_6;
  wire [15:0] lb1d_2__out_7;
  wire [15:0] lb1d_2__out_8;
  wire [15:0] lb1d_2__out_9;
  wire  lb1d_2__valid;
  wire  lb1d_2__valid_chain;
  wire  lb1d_2__wen;
  linebuffer_U3 lb1d_2(
    .clk(lb1d_2__clk),
    .in_0(lb1d_2__in_0),
    .out_0(lb1d_2__out_0),
    .out_1(lb1d_2__out_1),
    .out_10(lb1d_2__out_10),
    .out_11(lb1d_2__out_11),
    .out_12(lb1d_2__out_12),
    .out_13(lb1d_2__out_13),
    .out_14(lb1d_2__out_14),
    .out_15(lb1d_2__out_15),
    .out_16(lb1d_2__out_16),
    .out_17(lb1d_2__out_17),
    .out_18(lb1d_2__out_18),
    .out_19(lb1d_2__out_19),
    .out_2(lb1d_2__out_2),
    .out_3(lb1d_2__out_3),
    .out_4(lb1d_2__out_4),
    .out_5(lb1d_2__out_5),
    .out_6(lb1d_2__out_6),
    .out_7(lb1d_2__out_7),
    .out_8(lb1d_2__out_8),
    .out_9(lb1d_2__out_9),
    .valid(lb1d_2__valid),
    .valid_chain(lb1d_2__valid_chain),
    .wen(lb1d_2__wen)
  );

  //Wire declarations for instance 'lb1d_3' (Module linebuffer_U3)
  wire  lb1d_3__clk;
  wire [15:0] lb1d_3__in_0;
  wire [15:0] lb1d_3__out_0;
  wire [15:0] lb1d_3__out_1;
  wire [15:0] lb1d_3__out_10;
  wire [15:0] lb1d_3__out_11;
  wire [15:0] lb1d_3__out_12;
  wire [15:0] lb1d_3__out_13;
  wire [15:0] lb1d_3__out_14;
  wire [15:0] lb1d_3__out_15;
  wire [15:0] lb1d_3__out_16;
  wire [15:0] lb1d_3__out_17;
  wire [15:0] lb1d_3__out_18;
  wire [15:0] lb1d_3__out_19;
  wire [15:0] lb1d_3__out_2;
  wire [15:0] lb1d_3__out_3;
  wire [15:0] lb1d_3__out_4;
  wire [15:0] lb1d_3__out_5;
  wire [15:0] lb1d_3__out_6;
  wire [15:0] lb1d_3__out_7;
  wire [15:0] lb1d_3__out_8;
  wire [15:0] lb1d_3__out_9;
  wire  lb1d_3__valid;
  wire  lb1d_3__valid_chain;
  wire  lb1d_3__wen;
  linebuffer_U3 lb1d_3(
    .clk(lb1d_3__clk),
    .in_0(lb1d_3__in_0),
    .out_0(lb1d_3__out_0),
    .out_1(lb1d_3__out_1),
    .out_10(lb1d_3__out_10),
    .out_11(lb1d_3__out_11),
    .out_12(lb1d_3__out_12),
    .out_13(lb1d_3__out_13),
    .out_14(lb1d_3__out_14),
    .out_15(lb1d_3__out_15),
    .out_16(lb1d_3__out_16),
    .out_17(lb1d_3__out_17),
    .out_18(lb1d_3__out_18),
    .out_19(lb1d_3__out_19),
    .out_2(lb1d_3__out_2),
    .out_3(lb1d_3__out_3),
    .out_4(lb1d_3__out_4),
    .out_5(lb1d_3__out_5),
    .out_6(lb1d_3__out_6),
    .out_7(lb1d_3__out_7),
    .out_8(lb1d_3__out_8),
    .out_9(lb1d_3__out_9),
    .valid(lb1d_3__valid),
    .valid_chain(lb1d_3__valid_chain),
    .wen(lb1d_3__wen)
  );

  //Wire declarations for instance 'lb1d_4' (Module linebuffer_U3)
  wire  lb1d_4__clk;
  wire [15:0] lb1d_4__in_0;
  wire [15:0] lb1d_4__out_0;
  wire [15:0] lb1d_4__out_1;
  wire [15:0] lb1d_4__out_10;
  wire [15:0] lb1d_4__out_11;
  wire [15:0] lb1d_4__out_12;
  wire [15:0] lb1d_4__out_13;
  wire [15:0] lb1d_4__out_14;
  wire [15:0] lb1d_4__out_15;
  wire [15:0] lb1d_4__out_16;
  wire [15:0] lb1d_4__out_17;
  wire [15:0] lb1d_4__out_18;
  wire [15:0] lb1d_4__out_19;
  wire [15:0] lb1d_4__out_2;
  wire [15:0] lb1d_4__out_3;
  wire [15:0] lb1d_4__out_4;
  wire [15:0] lb1d_4__out_5;
  wire [15:0] lb1d_4__out_6;
  wire [15:0] lb1d_4__out_7;
  wire [15:0] lb1d_4__out_8;
  wire [15:0] lb1d_4__out_9;
  wire  lb1d_4__valid;
  wire  lb1d_4__valid_chain;
  wire  lb1d_4__wen;
  linebuffer_U3 lb1d_4(
    .clk(lb1d_4__clk),
    .in_0(lb1d_4__in_0),
    .out_0(lb1d_4__out_0),
    .out_1(lb1d_4__out_1),
    .out_10(lb1d_4__out_10),
    .out_11(lb1d_4__out_11),
    .out_12(lb1d_4__out_12),
    .out_13(lb1d_4__out_13),
    .out_14(lb1d_4__out_14),
    .out_15(lb1d_4__out_15),
    .out_16(lb1d_4__out_16),
    .out_17(lb1d_4__out_17),
    .out_18(lb1d_4__out_18),
    .out_19(lb1d_4__out_19),
    .out_2(lb1d_4__out_2),
    .out_3(lb1d_4__out_3),
    .out_4(lb1d_4__out_4),
    .out_5(lb1d_4__out_5),
    .out_6(lb1d_4__out_6),
    .out_7(lb1d_4__out_7),
    .out_8(lb1d_4__out_8),
    .out_9(lb1d_4__out_9),
    .valid(lb1d_4__valid),
    .valid_chain(lb1d_4__valid_chain),
    .wen(lb1d_4__wen)
  );

  //Wire declarations for instance 'lb1d_5' (Module linebuffer_U3)
  wire  lb1d_5__clk;
  wire [15:0] lb1d_5__in_0;
  wire [15:0] lb1d_5__out_0;
  wire [15:0] lb1d_5__out_1;
  wire [15:0] lb1d_5__out_10;
  wire [15:0] lb1d_5__out_11;
  wire [15:0] lb1d_5__out_12;
  wire [15:0] lb1d_5__out_13;
  wire [15:0] lb1d_5__out_14;
  wire [15:0] lb1d_5__out_15;
  wire [15:0] lb1d_5__out_16;
  wire [15:0] lb1d_5__out_17;
  wire [15:0] lb1d_5__out_18;
  wire [15:0] lb1d_5__out_19;
  wire [15:0] lb1d_5__out_2;
  wire [15:0] lb1d_5__out_3;
  wire [15:0] lb1d_5__out_4;
  wire [15:0] lb1d_5__out_5;
  wire [15:0] lb1d_5__out_6;
  wire [15:0] lb1d_5__out_7;
  wire [15:0] lb1d_5__out_8;
  wire [15:0] lb1d_5__out_9;
  wire  lb1d_5__valid;
  wire  lb1d_5__valid_chain;
  wire  lb1d_5__wen;
  linebuffer_U3 lb1d_5(
    .clk(lb1d_5__clk),
    .in_0(lb1d_5__in_0),
    .out_0(lb1d_5__out_0),
    .out_1(lb1d_5__out_1),
    .out_10(lb1d_5__out_10),
    .out_11(lb1d_5__out_11),
    .out_12(lb1d_5__out_12),
    .out_13(lb1d_5__out_13),
    .out_14(lb1d_5__out_14),
    .out_15(lb1d_5__out_15),
    .out_16(lb1d_5__out_16),
    .out_17(lb1d_5__out_17),
    .out_18(lb1d_5__out_18),
    .out_19(lb1d_5__out_19),
    .out_2(lb1d_5__out_2),
    .out_3(lb1d_5__out_3),
    .out_4(lb1d_5__out_4),
    .out_5(lb1d_5__out_5),
    .out_6(lb1d_5__out_6),
    .out_7(lb1d_5__out_7),
    .out_8(lb1d_5__out_8),
    .out_9(lb1d_5__out_9),
    .valid(lb1d_5__valid),
    .valid_chain(lb1d_5__valid_chain),
    .wen(lb1d_5__wen)
  );

  //Wire declarations for instance 'lb1d_6' (Module linebuffer_U3)
  wire  lb1d_6__clk;
  wire [15:0] lb1d_6__in_0;
  wire [15:0] lb1d_6__out_0;
  wire [15:0] lb1d_6__out_1;
  wire [15:0] lb1d_6__out_10;
  wire [15:0] lb1d_6__out_11;
  wire [15:0] lb1d_6__out_12;
  wire [15:0] lb1d_6__out_13;
  wire [15:0] lb1d_6__out_14;
  wire [15:0] lb1d_6__out_15;
  wire [15:0] lb1d_6__out_16;
  wire [15:0] lb1d_6__out_17;
  wire [15:0] lb1d_6__out_18;
  wire [15:0] lb1d_6__out_19;
  wire [15:0] lb1d_6__out_2;
  wire [15:0] lb1d_6__out_3;
  wire [15:0] lb1d_6__out_4;
  wire [15:0] lb1d_6__out_5;
  wire [15:0] lb1d_6__out_6;
  wire [15:0] lb1d_6__out_7;
  wire [15:0] lb1d_6__out_8;
  wire [15:0] lb1d_6__out_9;
  wire  lb1d_6__valid;
  wire  lb1d_6__valid_chain;
  wire  lb1d_6__wen;
  linebuffer_U3 lb1d_6(
    .clk(lb1d_6__clk),
    .in_0(lb1d_6__in_0),
    .out_0(lb1d_6__out_0),
    .out_1(lb1d_6__out_1),
    .out_10(lb1d_6__out_10),
    .out_11(lb1d_6__out_11),
    .out_12(lb1d_6__out_12),
    .out_13(lb1d_6__out_13),
    .out_14(lb1d_6__out_14),
    .out_15(lb1d_6__out_15),
    .out_16(lb1d_6__out_16),
    .out_17(lb1d_6__out_17),
    .out_18(lb1d_6__out_18),
    .out_19(lb1d_6__out_19),
    .out_2(lb1d_6__out_2),
    .out_3(lb1d_6__out_3),
    .out_4(lb1d_6__out_4),
    .out_5(lb1d_6__out_5),
    .out_6(lb1d_6__out_6),
    .out_7(lb1d_6__out_7),
    .out_8(lb1d_6__out_8),
    .out_9(lb1d_6__out_9),
    .valid(lb1d_6__valid),
    .valid_chain(lb1d_6__valid_chain),
    .wen(lb1d_6__wen)
  );

  //Wire declarations for instance 'lb1d_7' (Module linebuffer_U3)
  wire  lb1d_7__clk;
  wire [15:0] lb1d_7__in_0;
  wire [15:0] lb1d_7__out_0;
  wire [15:0] lb1d_7__out_1;
  wire [15:0] lb1d_7__out_10;
  wire [15:0] lb1d_7__out_11;
  wire [15:0] lb1d_7__out_12;
  wire [15:0] lb1d_7__out_13;
  wire [15:0] lb1d_7__out_14;
  wire [15:0] lb1d_7__out_15;
  wire [15:0] lb1d_7__out_16;
  wire [15:0] lb1d_7__out_17;
  wire [15:0] lb1d_7__out_18;
  wire [15:0] lb1d_7__out_19;
  wire [15:0] lb1d_7__out_2;
  wire [15:0] lb1d_7__out_3;
  wire [15:0] lb1d_7__out_4;
  wire [15:0] lb1d_7__out_5;
  wire [15:0] lb1d_7__out_6;
  wire [15:0] lb1d_7__out_7;
  wire [15:0] lb1d_7__out_8;
  wire [15:0] lb1d_7__out_9;
  wire  lb1d_7__valid;
  wire  lb1d_7__valid_chain;
  wire  lb1d_7__wen;
  linebuffer_U3 lb1d_7(
    .clk(lb1d_7__clk),
    .in_0(lb1d_7__in_0),
    .out_0(lb1d_7__out_0),
    .out_1(lb1d_7__out_1),
    .out_10(lb1d_7__out_10),
    .out_11(lb1d_7__out_11),
    .out_12(lb1d_7__out_12),
    .out_13(lb1d_7__out_13),
    .out_14(lb1d_7__out_14),
    .out_15(lb1d_7__out_15),
    .out_16(lb1d_7__out_16),
    .out_17(lb1d_7__out_17),
    .out_18(lb1d_7__out_18),
    .out_19(lb1d_7__out_19),
    .out_2(lb1d_7__out_2),
    .out_3(lb1d_7__out_3),
    .out_4(lb1d_7__out_4),
    .out_5(lb1d_7__out_5),
    .out_6(lb1d_7__out_6),
    .out_7(lb1d_7__out_7),
    .out_8(lb1d_7__out_8),
    .out_9(lb1d_7__out_9),
    .valid(lb1d_7__valid),
    .valid_chain(lb1d_7__valid_chain),
    .wen(lb1d_7__wen)
  );

  //Wire declarations for instance 'lb1d_8' (Module linebuffer_U3)
  wire  lb1d_8__clk;
  wire [15:0] lb1d_8__in_0;
  wire [15:0] lb1d_8__out_0;
  wire [15:0] lb1d_8__out_1;
  wire [15:0] lb1d_8__out_10;
  wire [15:0] lb1d_8__out_11;
  wire [15:0] lb1d_8__out_12;
  wire [15:0] lb1d_8__out_13;
  wire [15:0] lb1d_8__out_14;
  wire [15:0] lb1d_8__out_15;
  wire [15:0] lb1d_8__out_16;
  wire [15:0] lb1d_8__out_17;
  wire [15:0] lb1d_8__out_18;
  wire [15:0] lb1d_8__out_19;
  wire [15:0] lb1d_8__out_2;
  wire [15:0] lb1d_8__out_3;
  wire [15:0] lb1d_8__out_4;
  wire [15:0] lb1d_8__out_5;
  wire [15:0] lb1d_8__out_6;
  wire [15:0] lb1d_8__out_7;
  wire [15:0] lb1d_8__out_8;
  wire [15:0] lb1d_8__out_9;
  wire  lb1d_8__valid;
  wire  lb1d_8__valid_chain;
  wire  lb1d_8__wen;
  linebuffer_U3 lb1d_8(
    .clk(lb1d_8__clk),
    .in_0(lb1d_8__in_0),
    .out_0(lb1d_8__out_0),
    .out_1(lb1d_8__out_1),
    .out_10(lb1d_8__out_10),
    .out_11(lb1d_8__out_11),
    .out_12(lb1d_8__out_12),
    .out_13(lb1d_8__out_13),
    .out_14(lb1d_8__out_14),
    .out_15(lb1d_8__out_15),
    .out_16(lb1d_8__out_16),
    .out_17(lb1d_8__out_17),
    .out_18(lb1d_8__out_18),
    .out_19(lb1d_8__out_19),
    .out_2(lb1d_8__out_2),
    .out_3(lb1d_8__out_3),
    .out_4(lb1d_8__out_4),
    .out_5(lb1d_8__out_5),
    .out_6(lb1d_8__out_6),
    .out_7(lb1d_8__out_7),
    .out_8(lb1d_8__out_8),
    .out_9(lb1d_8__out_9),
    .valid(lb1d_8__valid),
    .valid_chain(lb1d_8__valid_chain),
    .wen(lb1d_8__wen)
  );

  //Wire declarations for instance 'lb1d_9' (Module linebuffer_U3)
  wire  lb1d_9__clk;
  wire [15:0] lb1d_9__in_0;
  wire [15:0] lb1d_9__out_0;
  wire [15:0] lb1d_9__out_1;
  wire [15:0] lb1d_9__out_10;
  wire [15:0] lb1d_9__out_11;
  wire [15:0] lb1d_9__out_12;
  wire [15:0] lb1d_9__out_13;
  wire [15:0] lb1d_9__out_14;
  wire [15:0] lb1d_9__out_15;
  wire [15:0] lb1d_9__out_16;
  wire [15:0] lb1d_9__out_17;
  wire [15:0] lb1d_9__out_18;
  wire [15:0] lb1d_9__out_19;
  wire [15:0] lb1d_9__out_2;
  wire [15:0] lb1d_9__out_3;
  wire [15:0] lb1d_9__out_4;
  wire [15:0] lb1d_9__out_5;
  wire [15:0] lb1d_9__out_6;
  wire [15:0] lb1d_9__out_7;
  wire [15:0] lb1d_9__out_8;
  wire [15:0] lb1d_9__out_9;
  wire  lb1d_9__valid;
  wire  lb1d_9__valid_chain;
  wire  lb1d_9__wen;
  linebuffer_U3 lb1d_9(
    .clk(lb1d_9__clk),
    .in_0(lb1d_9__in_0),
    .out_0(lb1d_9__out_0),
    .out_1(lb1d_9__out_1),
    .out_10(lb1d_9__out_10),
    .out_11(lb1d_9__out_11),
    .out_12(lb1d_9__out_12),
    .out_13(lb1d_9__out_13),
    .out_14(lb1d_9__out_14),
    .out_15(lb1d_9__out_15),
    .out_16(lb1d_9__out_16),
    .out_17(lb1d_9__out_17),
    .out_18(lb1d_9__out_18),
    .out_19(lb1d_9__out_19),
    .out_2(lb1d_9__out_2),
    .out_3(lb1d_9__out_3),
    .out_4(lb1d_9__out_4),
    .out_5(lb1d_9__out_5),
    .out_6(lb1d_9__out_6),
    .out_7(lb1d_9__out_7),
    .out_8(lb1d_9__out_8),
    .out_9(lb1d_9__out_9),
    .valid(lb1d_9__valid),
    .valid_chain(lb1d_9__valid_chain),
    .wen(lb1d_9__wen)
  );

  //Wire declarations for instance 'lbmem_10_0' (Module rowbuffer_U4)
  wire  lbmem_10_0__clk;
  wire  lbmem_10_0__flush;
  wire [15:0] lbmem_10_0__rdata;
  wire  lbmem_10_0__valid;
  wire [15:0] lbmem_10_0__wdata;
  wire  lbmem_10_0__wen;
  rowbuffer_U4 lbmem_10_0(
    .clk(lbmem_10_0__clk),
    .flush(lbmem_10_0__flush),
    .rdata(lbmem_10_0__rdata),
    .valid(lbmem_10_0__valid),
    .wdata(lbmem_10_0__wdata),
    .wen(lbmem_10_0__wen)
  );

  //Wire declarations for instance 'lbmem_10_0_flush' (Module corebit_const)
  wire  lbmem_10_0_flush__out;
  corebit_const #(.value(0)) lbmem_10_0_flush(
    .out(lbmem_10_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_11_0' (Module rowbuffer_U4)
  wire  lbmem_11_0__clk;
  wire  lbmem_11_0__flush;
  wire [15:0] lbmem_11_0__rdata;
  wire  lbmem_11_0__valid;
  wire [15:0] lbmem_11_0__wdata;
  wire  lbmem_11_0__wen;
  rowbuffer_U4 lbmem_11_0(
    .clk(lbmem_11_0__clk),
    .flush(lbmem_11_0__flush),
    .rdata(lbmem_11_0__rdata),
    .valid(lbmem_11_0__valid),
    .wdata(lbmem_11_0__wdata),
    .wen(lbmem_11_0__wen)
  );

  //Wire declarations for instance 'lbmem_11_0_flush' (Module corebit_const)
  wire  lbmem_11_0_flush__out;
  corebit_const #(.value(0)) lbmem_11_0_flush(
    .out(lbmem_11_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_12_0' (Module rowbuffer_U4)
  wire  lbmem_12_0__clk;
  wire  lbmem_12_0__flush;
  wire [15:0] lbmem_12_0__rdata;
  wire  lbmem_12_0__valid;
  wire [15:0] lbmem_12_0__wdata;
  wire  lbmem_12_0__wen;
  rowbuffer_U4 lbmem_12_0(
    .clk(lbmem_12_0__clk),
    .flush(lbmem_12_0__flush),
    .rdata(lbmem_12_0__rdata),
    .valid(lbmem_12_0__valid),
    .wdata(lbmem_12_0__wdata),
    .wen(lbmem_12_0__wen)
  );

  //Wire declarations for instance 'lbmem_12_0_flush' (Module corebit_const)
  wire  lbmem_12_0_flush__out;
  corebit_const #(.value(0)) lbmem_12_0_flush(
    .out(lbmem_12_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_13_0' (Module rowbuffer_U4)
  wire  lbmem_13_0__clk;
  wire  lbmem_13_0__flush;
  wire [15:0] lbmem_13_0__rdata;
  wire  lbmem_13_0__valid;
  wire [15:0] lbmem_13_0__wdata;
  wire  lbmem_13_0__wen;
  rowbuffer_U4 lbmem_13_0(
    .clk(lbmem_13_0__clk),
    .flush(lbmem_13_0__flush),
    .rdata(lbmem_13_0__rdata),
    .valid(lbmem_13_0__valid),
    .wdata(lbmem_13_0__wdata),
    .wen(lbmem_13_0__wen)
  );

  //Wire declarations for instance 'lbmem_13_0_flush' (Module corebit_const)
  wire  lbmem_13_0_flush__out;
  corebit_const #(.value(0)) lbmem_13_0_flush(
    .out(lbmem_13_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_14_0' (Module rowbuffer_U4)
  wire  lbmem_14_0__clk;
  wire  lbmem_14_0__flush;
  wire [15:0] lbmem_14_0__rdata;
  wire  lbmem_14_0__valid;
  wire [15:0] lbmem_14_0__wdata;
  wire  lbmem_14_0__wen;
  rowbuffer_U4 lbmem_14_0(
    .clk(lbmem_14_0__clk),
    .flush(lbmem_14_0__flush),
    .rdata(lbmem_14_0__rdata),
    .valid(lbmem_14_0__valid),
    .wdata(lbmem_14_0__wdata),
    .wen(lbmem_14_0__wen)
  );

  //Wire declarations for instance 'lbmem_14_0_flush' (Module corebit_const)
  wire  lbmem_14_0_flush__out;
  corebit_const #(.value(0)) lbmem_14_0_flush(
    .out(lbmem_14_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_15_0' (Module rowbuffer_U4)
  wire  lbmem_15_0__clk;
  wire  lbmem_15_0__flush;
  wire [15:0] lbmem_15_0__rdata;
  wire  lbmem_15_0__valid;
  wire [15:0] lbmem_15_0__wdata;
  wire  lbmem_15_0__wen;
  rowbuffer_U4 lbmem_15_0(
    .clk(lbmem_15_0__clk),
    .flush(lbmem_15_0__flush),
    .rdata(lbmem_15_0__rdata),
    .valid(lbmem_15_0__valid),
    .wdata(lbmem_15_0__wdata),
    .wen(lbmem_15_0__wen)
  );

  //Wire declarations for instance 'lbmem_15_0_flush' (Module corebit_const)
  wire  lbmem_15_0_flush__out;
  corebit_const #(.value(0)) lbmem_15_0_flush(
    .out(lbmem_15_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_1_0' (Module rowbuffer_U4)
  wire  lbmem_1_0__clk;
  wire  lbmem_1_0__flush;
  wire [15:0] lbmem_1_0__rdata;
  wire  lbmem_1_0__valid;
  wire [15:0] lbmem_1_0__wdata;
  wire  lbmem_1_0__wen;
  rowbuffer_U4 lbmem_1_0(
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

  //Wire declarations for instance 'lbmem_2_0' (Module rowbuffer_U4)
  wire  lbmem_2_0__clk;
  wire  lbmem_2_0__flush;
  wire [15:0] lbmem_2_0__rdata;
  wire  lbmem_2_0__valid;
  wire [15:0] lbmem_2_0__wdata;
  wire  lbmem_2_0__wen;
  rowbuffer_U4 lbmem_2_0(
    .clk(lbmem_2_0__clk),
    .flush(lbmem_2_0__flush),
    .rdata(lbmem_2_0__rdata),
    .valid(lbmem_2_0__valid),
    .wdata(lbmem_2_0__wdata),
    .wen(lbmem_2_0__wen)
  );

  //Wire declarations for instance 'lbmem_2_0_flush' (Module corebit_const)
  wire  lbmem_2_0_flush__out;
  corebit_const #(.value(0)) lbmem_2_0_flush(
    .out(lbmem_2_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_3_0' (Module rowbuffer_U4)
  wire  lbmem_3_0__clk;
  wire  lbmem_3_0__flush;
  wire [15:0] lbmem_3_0__rdata;
  wire  lbmem_3_0__valid;
  wire [15:0] lbmem_3_0__wdata;
  wire  lbmem_3_0__wen;
  rowbuffer_U4 lbmem_3_0(
    .clk(lbmem_3_0__clk),
    .flush(lbmem_3_0__flush),
    .rdata(lbmem_3_0__rdata),
    .valid(lbmem_3_0__valid),
    .wdata(lbmem_3_0__wdata),
    .wen(lbmem_3_0__wen)
  );

  //Wire declarations for instance 'lbmem_3_0_flush' (Module corebit_const)
  wire  lbmem_3_0_flush__out;
  corebit_const #(.value(0)) lbmem_3_0_flush(
    .out(lbmem_3_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_4_0' (Module rowbuffer_U4)
  wire  lbmem_4_0__clk;
  wire  lbmem_4_0__flush;
  wire [15:0] lbmem_4_0__rdata;
  wire  lbmem_4_0__valid;
  wire [15:0] lbmem_4_0__wdata;
  wire  lbmem_4_0__wen;
  rowbuffer_U4 lbmem_4_0(
    .clk(lbmem_4_0__clk),
    .flush(lbmem_4_0__flush),
    .rdata(lbmem_4_0__rdata),
    .valid(lbmem_4_0__valid),
    .wdata(lbmem_4_0__wdata),
    .wen(lbmem_4_0__wen)
  );

  //Wire declarations for instance 'lbmem_4_0_flush' (Module corebit_const)
  wire  lbmem_4_0_flush__out;
  corebit_const #(.value(0)) lbmem_4_0_flush(
    .out(lbmem_4_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_5_0' (Module rowbuffer_U4)
  wire  lbmem_5_0__clk;
  wire  lbmem_5_0__flush;
  wire [15:0] lbmem_5_0__rdata;
  wire  lbmem_5_0__valid;
  wire [15:0] lbmem_5_0__wdata;
  wire  lbmem_5_0__wen;
  rowbuffer_U4 lbmem_5_0(
    .clk(lbmem_5_0__clk),
    .flush(lbmem_5_0__flush),
    .rdata(lbmem_5_0__rdata),
    .valid(lbmem_5_0__valid),
    .wdata(lbmem_5_0__wdata),
    .wen(lbmem_5_0__wen)
  );

  //Wire declarations for instance 'lbmem_5_0_flush' (Module corebit_const)
  wire  lbmem_5_0_flush__out;
  corebit_const #(.value(0)) lbmem_5_0_flush(
    .out(lbmem_5_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_6_0' (Module rowbuffer_U4)
  wire  lbmem_6_0__clk;
  wire  lbmem_6_0__flush;
  wire [15:0] lbmem_6_0__rdata;
  wire  lbmem_6_0__valid;
  wire [15:0] lbmem_6_0__wdata;
  wire  lbmem_6_0__wen;
  rowbuffer_U4 lbmem_6_0(
    .clk(lbmem_6_0__clk),
    .flush(lbmem_6_0__flush),
    .rdata(lbmem_6_0__rdata),
    .valid(lbmem_6_0__valid),
    .wdata(lbmem_6_0__wdata),
    .wen(lbmem_6_0__wen)
  );

  //Wire declarations for instance 'lbmem_6_0_flush' (Module corebit_const)
  wire  lbmem_6_0_flush__out;
  corebit_const #(.value(0)) lbmem_6_0_flush(
    .out(lbmem_6_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_7_0' (Module rowbuffer_U4)
  wire  lbmem_7_0__clk;
  wire  lbmem_7_0__flush;
  wire [15:0] lbmem_7_0__rdata;
  wire  lbmem_7_0__valid;
  wire [15:0] lbmem_7_0__wdata;
  wire  lbmem_7_0__wen;
  rowbuffer_U4 lbmem_7_0(
    .clk(lbmem_7_0__clk),
    .flush(lbmem_7_0__flush),
    .rdata(lbmem_7_0__rdata),
    .valid(lbmem_7_0__valid),
    .wdata(lbmem_7_0__wdata),
    .wen(lbmem_7_0__wen)
  );

  //Wire declarations for instance 'lbmem_7_0_flush' (Module corebit_const)
  wire  lbmem_7_0_flush__out;
  corebit_const #(.value(0)) lbmem_7_0_flush(
    .out(lbmem_7_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_8_0' (Module rowbuffer_U4)
  wire  lbmem_8_0__clk;
  wire  lbmem_8_0__flush;
  wire [15:0] lbmem_8_0__rdata;
  wire  lbmem_8_0__valid;
  wire [15:0] lbmem_8_0__wdata;
  wire  lbmem_8_0__wen;
  rowbuffer_U4 lbmem_8_0(
    .clk(lbmem_8_0__clk),
    .flush(lbmem_8_0__flush),
    .rdata(lbmem_8_0__rdata),
    .valid(lbmem_8_0__valid),
    .wdata(lbmem_8_0__wdata),
    .wen(lbmem_8_0__wen)
  );

  //Wire declarations for instance 'lbmem_8_0_flush' (Module corebit_const)
  wire  lbmem_8_0_flush__out;
  corebit_const #(.value(0)) lbmem_8_0_flush(
    .out(lbmem_8_0_flush__out)
  );

  //Wire declarations for instance 'lbmem_9_0' (Module rowbuffer_U4)
  wire  lbmem_9_0__clk;
  wire  lbmem_9_0__flush;
  wire [15:0] lbmem_9_0__rdata;
  wire  lbmem_9_0__valid;
  wire [15:0] lbmem_9_0__wdata;
  wire  lbmem_9_0__wen;
  rowbuffer_U4 lbmem_9_0(
    .clk(lbmem_9_0__clk),
    .flush(lbmem_9_0__flush),
    .rdata(lbmem_9_0__rdata),
    .valid(lbmem_9_0__valid),
    .wdata(lbmem_9_0__wdata),
    .wen(lbmem_9_0__wen)
  );

  //Wire declarations for instance 'lbmem_9_0_flush' (Module corebit_const)
  wire  lbmem_9_0_flush__out;
  corebit_const #(.value(0)) lbmem_9_0_flush(
    .out(lbmem_9_0_flush__out)
  );

  //Wire declarations for instance 'valcompare_0' (Module coreir_ule)
  wire [15:0] valcompare_0__in0;
  wire [15:0] valcompare_0__in1;
  wire  valcompare_0__out;
  coreir_ule #(.width(16)) valcompare_0(
    .in0(valcompare_0__in0),
    .in1(valcompare_0__in1),
    .out(valcompare_0__out)
  );

  //Wire declarations for instance 'valcompare_1' (Module coreir_ule)
  wire [15:0] valcompare_1__in0;
  wire [15:0] valcompare_1__in1;
  wire  valcompare_1__out;
  coreir_ule #(.width(16)) valcompare_1(
    .in0(valcompare_1__in0),
    .in1(valcompare_1__in1),
    .out(valcompare_1__out)
  );

  //Wire declarations for instance 'valcounter_0' (Module counter_U7)
  wire  valcounter_0__clk;
  wire  valcounter_0__en;
  wire [15:0] valcounter_0__out;
  wire  valcounter_0__overflow;
  wire  valcounter_0__reset;
  counter_U7 valcounter_0(
    .clk(valcounter_0__clk),
    .en(valcounter_0__en),
    .out(valcounter_0__out),
    .overflow(valcounter_0__overflow),
    .reset(valcounter_0__reset)
  );

  //Wire declarations for instance 'valcounter_0_reset' (Module corebit_const)
  wire  valcounter_0_reset__out;
  corebit_const #(.value(0)) valcounter_0_reset(
    .out(valcounter_0_reset__out)
  );

  //Wire declarations for instance 'valcounter_1' (Module counter_U8)
  wire  valcounter_1__clk;
  wire  valcounter_1__en;
  wire [15:0] valcounter_1__out;
  wire  valcounter_1__overflow;
  wire  valcounter_1__reset;
  counter_U8 valcounter_1(
    .clk(valcounter_1__clk),
    .en(valcounter_1__en),
    .out(valcounter_1__out),
    .overflow(valcounter_1__overflow),
    .reset(valcounter_1__reset)
  );

  //Wire declarations for instance 'valcounter_1_reset' (Module corebit_const)
  wire  valcounter_1_reset__out;
  corebit_const #(.value(0)) valcounter_1_reset(
    .out(valcounter_1_reset__out)
  );

  //Wire declarations for instance 'valid_andr' (Module bitopn_U9)
  wire [2:0] valid_andr__in;
  wire  valid_andr__out;
  bitopn_U9 valid_andr(
    .in(valid_andr__in),
    .out(valid_andr__out)
  );

  //All the connections
  assign lbmem_1_0__wdata[15:0] = in_0_0[15:0];
  assign lbmem_1_0__flush = lbmem_1_0_flush__out;
  assign lbmem_1_0__wen = wen;
  assign valcounter_0__en = wen;
  assign valid_andr__in[0] = wen;
  assign lb1d_0__wen = wen;
  assign lb1d_3__wen = wen;
  assign lb1d_1__wen = wen;
  assign lb1d_2__wen = wen;
  assign lb1d_4__wen = wen;
  assign lb1d_5__wen = wen;
  assign lb1d_6__wen = wen;
  assign lb1d_7__wen = wen;
  assign lb1d_8__wen = wen;
  assign lb1d_9__wen = wen;
  assign lb1d_10__wen = wen;
  assign lb1d_11__wen = wen;
  assign lb1d_12__wen = wen;
  assign lb1d_13__wen = wen;
  assign lb1d_14__wen = wen;
  assign lb1d_15__wen = wen;
  assign lbmem_2_0__wdata[15:0] = lbmem_1_0__rdata[15:0];
  assign lb1d_1__in_0[15:0] = lbmem_1_0__rdata[15:0];
  assign lbmem_2_0__flush = lbmem_2_0_flush__out;
  assign lbmem_2_0__wen = lbmem_1_0__valid;
  assign lbmem_3_0__wdata[15:0] = lbmem_2_0__rdata[15:0];
  assign lb1d_2__in_0[15:0] = lbmem_2_0__rdata[15:0];
  assign lbmem_3_0__flush = lbmem_3_0_flush__out;
  assign lbmem_3_0__wen = lbmem_2_0__valid;
  assign lbmem_4_0__wdata[15:0] = lbmem_3_0__rdata[15:0];
  assign lb1d_3__in_0[15:0] = lbmem_3_0__rdata[15:0];
  assign lbmem_4_0__flush = lbmem_4_0_flush__out;
  assign lbmem_4_0__wen = lbmem_3_0__valid;
  assign lbmem_5_0__wdata[15:0] = lbmem_4_0__rdata[15:0];
  assign lb1d_4__in_0[15:0] = lbmem_4_0__rdata[15:0];
  assign lbmem_5_0__wen = lbmem_4_0__valid;
  assign lbmem_5_0__flush = lbmem_5_0_flush__out;
  assign lbmem_6_0__wdata[15:0] = lbmem_5_0__rdata[15:0];
  assign lb1d_5__in_0[15:0] = lbmem_5_0__rdata[15:0];
  assign lbmem_6_0__wen = lbmem_5_0__valid;
  assign lbmem_6_0__flush = lbmem_6_0_flush__out;
  assign lbmem_7_0__wdata[15:0] = lbmem_6_0__rdata[15:0];
  assign lb1d_6__in_0[15:0] = lbmem_6_0__rdata[15:0];
  assign lbmem_7_0__wen = lbmem_6_0__valid;
  assign lbmem_7_0__flush = lbmem_7_0_flush__out;
  assign lbmem_8_0__wdata[15:0] = lbmem_7_0__rdata[15:0];
  assign lb1d_7__in_0[15:0] = lbmem_7_0__rdata[15:0];
  assign lbmem_8_0__wen = lbmem_7_0__valid;
  assign lbmem_8_0__flush = lbmem_8_0_flush__out;
  assign lbmem_9_0__wdata[15:0] = lbmem_8_0__rdata[15:0];
  assign lb1d_8__in_0[15:0] = lbmem_8_0__rdata[15:0];
  assign lbmem_9_0__wen = lbmem_8_0__valid;
  assign lbmem_9_0__flush = lbmem_9_0_flush__out;
  assign lbmem_10_0__wdata[15:0] = lbmem_9_0__rdata[15:0];
  assign lb1d_9__in_0[15:0] = lbmem_9_0__rdata[15:0];
  assign lbmem_10_0__wen = lbmem_9_0__valid;
  assign lbmem_10_0__flush = lbmem_10_0_flush__out;
  assign lbmem_11_0__wdata[15:0] = lbmem_10_0__rdata[15:0];
  assign lb1d_10__in_0[15:0] = lbmem_10_0__rdata[15:0];
  assign lbmem_11_0__flush = lbmem_11_0_flush__out;
  assign lbmem_11_0__wen = lbmem_10_0__valid;
  assign lbmem_12_0__wdata[15:0] = lbmem_11_0__rdata[15:0];
  assign lb1d_11__in_0[15:0] = lbmem_11_0__rdata[15:0];
  assign lbmem_12_0__flush = lbmem_12_0_flush__out;
  assign lbmem_12_0__wen = lbmem_11_0__valid;
  assign lbmem_13_0__wdata[15:0] = lbmem_12_0__rdata[15:0];
  assign lb1d_12__in_0[15:0] = lbmem_12_0__rdata[15:0];
  assign lbmem_13_0__flush = lbmem_13_0_flush__out;
  assign lbmem_13_0__wen = lbmem_12_0__valid;
  assign lbmem_14_0__wdata[15:0] = lbmem_13_0__rdata[15:0];
  assign lb1d_13__in_0[15:0] = lbmem_13_0__rdata[15:0];
  assign lbmem_14_0__flush = lbmem_14_0_flush__out;
  assign lbmem_14_0__wen = lbmem_13_0__valid;
  assign lbmem_15_0__wdata[15:0] = lbmem_14_0__rdata[15:0];
  assign lb1d_14__in_0[15:0] = lbmem_14_0__rdata[15:0];
  assign lbmem_15_0__flush = lbmem_15_0_flush__out;
  assign lbmem_15_0__wen = lbmem_14_0__valid;
  assign lb1d_15__in_0[15:0] = lbmem_15_0__rdata[15:0];
  assign valid_chain = lbmem_15_0__valid;
  assign valcounter_0__reset = valcounter_0_reset__out;
  assign valcompare_0__in1[15:0] = valcounter_0__out[15:0];
  assign valcompare_0__in0[15:0] = const_stencil0__out[15:0];
  assign valcompare_1__in0[15:0] = const_stencil1__out[15:0];
  assign valcounter_1__reset = valcounter_1_reset__out;
  assign valcounter_1__en = valcounter_0__overflow;
  assign valcompare_1__in1[15:0] = valcounter_1__out[15:0];
  assign valid_andr__in[1] = valcompare_0__out;
  assign valid = valid_andr__out;
  assign valid_andr__in[2] = valcompare_1__out;
  assign out_5_7[15:0] = lb1d_10__out_7[15:0];
  assign out_15_0[15:0] = lb1d_0__out_0[15:0];
  assign lb1d_0__clk = clk;
  assign lb1d_1__clk = clk;
  assign lb1d_10__clk = clk;
  assign lb1d_11__clk = clk;
  assign lb1d_12__clk = clk;
  assign lb1d_13__clk = clk;
  assign lb1d_14__clk = clk;
  assign lb1d_15__clk = clk;
  assign lb1d_2__clk = clk;
  assign lb1d_3__clk = clk;
  assign lb1d_4__clk = clk;
  assign lb1d_5__clk = clk;
  assign lb1d_6__clk = clk;
  assign lb1d_7__clk = clk;
  assign lb1d_8__clk = clk;
  assign lb1d_9__clk = clk;
  assign lbmem_10_0__clk = clk;
  assign lbmem_11_0__clk = clk;
  assign lbmem_12_0__clk = clk;
  assign lbmem_13_0__clk = clk;
  assign lbmem_14_0__clk = clk;
  assign lbmem_15_0__clk = clk;
  assign lbmem_1_0__clk = clk;
  assign lbmem_2_0__clk = clk;
  assign lbmem_3_0__clk = clk;
  assign lbmem_4_0__clk = clk;
  assign lbmem_5_0__clk = clk;
  assign lbmem_6_0__clk = clk;
  assign lbmem_7_0__clk = clk;
  assign lbmem_8_0__clk = clk;
  assign lbmem_9_0__clk = clk;
  assign valcounter_0__clk = clk;
  assign valcounter_1__clk = clk;
  assign out_15_10[15:0] = lb1d_0__out_10[15:0];
  assign out_4_8[15:0] = lb1d_11__out_8[15:0];
  assign out_1_2[15:0] = lb1d_14__out_2[15:0];
  assign out_14_8[15:0] = lb1d_1__out_8[15:0];
  assign out_15_12[15:0] = lb1d_0__out_12[15:0];
  assign out_5_6[15:0] = lb1d_10__out_6[15:0];
  assign out_4_9[15:0] = lb1d_11__out_9[15:0];
  assign out_15_11[15:0] = lb1d_0__out_11[15:0];
  assign out_1_1[15:0] = lb1d_14__out_1[15:0];
  assign out_15_1[15:0] = lb1d_0__out_1[15:0];
  assign out_4_2[15:0] = lb1d_11__out_2[15:0];
  assign out_15_2[15:0] = lb1d_0__out_2[15:0];
  assign out_15_3[15:0] = lb1d_0__out_3[15:0];
  assign out_2_5[15:0] = lb1d_13__out_5[15:0];
  assign out_15_4[15:0] = lb1d_0__out_4[15:0];
  assign out_1_0[15:0] = lb1d_14__out_0[15:0];
  assign out_15_5[15:0] = lb1d_0__out_5[15:0];
  assign out_5_0[15:0] = lb1d_10__out_0[15:0];
  assign out_15_6[15:0] = lb1d_0__out_6[15:0];
  assign out_3_3[15:0] = lb1d_12__out_3[15:0];
  assign out_15_7[15:0] = lb1d_0__out_7[15:0];
  assign out_15_8[15:0] = lb1d_0__out_8[15:0];
  assign out_5_1[15:0] = lb1d_10__out_1[15:0];
  assign out_15_9[15:0] = lb1d_0__out_9[15:0];
  assign lb1d_0__in_0[15:0] = in_0_0[15:0];
  assign out_0_5[15:0] = lb1d_15__out_5[15:0];
  assign out_3_1[15:0] = lb1d_12__out_1[15:0];
  assign out_14_5[15:0] = lb1d_1__out_5[15:0];
  assign out_5_4[15:0] = lb1d_10__out_4[15:0];
  assign out_14_6[15:0] = lb1d_1__out_6[15:0];
  assign out_14_1[15:0] = lb1d_1__out_1[15:0];
  assign out_0_8[15:0] = lb1d_15__out_8[15:0];
  assign out_14_2[15:0] = lb1d_1__out_2[15:0];
  assign out_3_9[15:0] = lb1d_12__out_9[15:0];
  assign out_14_3[15:0] = lb1d_1__out_3[15:0];
  assign out_2_4[15:0] = lb1d_13__out_4[15:0];
  assign out_14_4[15:0] = lb1d_1__out_4[15:0];
  assign out_5_5[15:0] = lb1d_10__out_5[15:0];
  assign out_3_2[15:0] = lb1d_12__out_2[15:0];
  assign out_6_4[15:0] = lb1d_9__out_4[15:0];
  assign out_4_1[15:0] = lb1d_11__out_1[15:0];
  assign out_3_4[15:0] = lb1d_12__out_4[15:0];
  assign out_4_5[15:0] = lb1d_11__out_5[15:0];
  assign out_14_0[15:0] = lb1d_1__out_0[15:0];
  assign out_4_0[15:0] = lb1d_11__out_0[15:0];
  assign out_3_5[15:0] = lb1d_12__out_5[15:0];
  assign out_14_7[15:0] = lb1d_1__out_7[15:0];
  assign out_12_3[15:0] = lb1d_3__out_3[15:0];
  assign out_6_2[15:0] = lb1d_9__out_2[15:0];
  assign out_5_3[15:0] = lb1d_10__out_3[15:0];
  assign out_15_13[15:0] = lb1d_0__out_13[15:0];
  assign out_5_10[15:0] = lb1d_10__out_10[15:0];
  assign out_15_14[15:0] = lb1d_0__out_14[15:0];
  assign out_14_9[15:0] = lb1d_1__out_9[15:0];
  assign out_15_15[15:0] = lb1d_0__out_15[15:0];
  assign out_4_6[15:0] = lb1d_11__out_6[15:0];
  assign out_15_16[15:0] = lb1d_0__out_16[15:0];
  assign out_4_3[15:0] = lb1d_11__out_3[15:0];
  assign out_15_17[15:0] = lb1d_0__out_17[15:0];
  assign out_13_6[15:0] = lb1d_2__out_6[15:0];
  assign out_15_18[15:0] = lb1d_0__out_18[15:0];
  assign out_7_6[15:0] = lb1d_8__out_6[15:0];
  assign out_15_19[15:0] = lb1d_0__out_19[15:0];
  assign out_0_7[15:0] = lb1d_15__out_7[15:0];
  assign out_14_10[15:0] = lb1d_1__out_10[15:0];
  assign out_5_2[15:0] = lb1d_10__out_2[15:0];
  assign out_14_11[15:0] = lb1d_1__out_11[15:0];
  assign out_3_0[15:0] = lb1d_12__out_0[15:0];
  assign out_5_8[15:0] = lb1d_10__out_8[15:0];
  assign out_14_12[15:0] = lb1d_1__out_12[15:0];
  assign out_2_1[15:0] = lb1d_13__out_1[15:0];
  assign out_14_13[15:0] = lb1d_1__out_13[15:0];
  assign out_4_4[15:0] = lb1d_11__out_4[15:0];
  assign out_14_14[15:0] = lb1d_1__out_14[15:0];
  assign out_11_1[15:0] = lb1d_4__out_1[15:0];
  assign out_14_15[15:0] = lb1d_1__out_15[15:0];
  assign out_3_6[15:0] = lb1d_12__out_6[15:0];
  assign out_14_16[15:0] = lb1d_1__out_16[15:0];
  assign out_14_17[15:0] = lb1d_1__out_17[15:0];
  assign out_3_7[15:0] = lb1d_12__out_7[15:0];
  assign out_14_18[15:0] = lb1d_1__out_18[15:0];
  assign out_14_19[15:0] = lb1d_1__out_19[15:0];
  assign out_3_8[15:0] = lb1d_12__out_8[15:0];
  assign out_5_9[15:0] = lb1d_10__out_9[15:0];
  assign out_2_0[15:0] = lb1d_13__out_0[15:0];
  assign out_4_11[15:0] = lb1d_11__out_11[15:0];
  assign out_2_2[15:0] = lb1d_13__out_2[15:0];
  assign out_13_1[15:0] = lb1d_2__out_1[15:0];
  assign out_5_11[15:0] = lb1d_10__out_11[15:0];
  assign out_13_4[15:0] = lb1d_2__out_4[15:0];
  assign out_5_17[15:0] = lb1d_10__out_17[15:0];
  assign out_5_18[15:0] = lb1d_10__out_18[15:0];
  assign out_0_2[15:0] = lb1d_15__out_2[15:0];
  assign out_5_12[15:0] = lb1d_10__out_12[15:0];
  assign out_4_7[15:0] = lb1d_11__out_7[15:0];
  assign out_5_13[15:0] = lb1d_10__out_13[15:0];
  assign out_13_8[15:0] = lb1d_2__out_8[15:0];
  assign out_5_14[15:0] = lb1d_10__out_14[15:0];
  assign out_5_15[15:0] = lb1d_10__out_15[15:0];
  assign out_13_3[15:0] = lb1d_2__out_3[15:0];
  assign out_5_16[15:0] = lb1d_10__out_16[15:0];
  assign out_11_2[15:0] = lb1d_4__out_2[15:0];
  assign out_5_19[15:0] = lb1d_10__out_19[15:0];
  assign out_0_0[15:0] = lb1d_15__out_0[15:0];
  assign out_1_3[15:0] = lb1d_14__out_3[15:0];
  assign out_4_12[15:0] = lb1d_11__out_12[15:0];
  assign out_10_5[15:0] = lb1d_5__out_5[15:0];
  assign out_3_10[15:0] = lb1d_12__out_10[15:0];
  assign out_3_12[15:0] = lb1d_12__out_12[15:0];
  assign out_4_10[15:0] = lb1d_11__out_10[15:0];
  assign out_4_13[15:0] = lb1d_11__out_13[15:0];
  assign out_11_0[15:0] = lb1d_4__out_0[15:0];
  assign out_4_14[15:0] = lb1d_11__out_14[15:0];
  assign out_3_11[15:0] = lb1d_12__out_11[15:0];
  assign out_4_15[15:0] = lb1d_11__out_15[15:0];
  assign out_1_4[15:0] = lb1d_14__out_4[15:0];
  assign out_4_16[15:0] = lb1d_11__out_16[15:0];
  assign out_13_2[15:0] = lb1d_2__out_2[15:0];
  assign out_4_17[15:0] = lb1d_11__out_17[15:0];
  assign out_1_5[15:0] = lb1d_14__out_5[15:0];
  assign out_4_18[15:0] = lb1d_11__out_18[15:0];
  assign out_1_6[15:0] = lb1d_14__out_6[15:0];
  assign out_4_19[15:0] = lb1d_11__out_19[15:0];
  assign out_0_4[15:0] = lb1d_15__out_4[15:0];
  assign out_0_6[15:0] = lb1d_15__out_6[15:0];
  assign out_2_6[15:0] = lb1d_13__out_6[15:0];
  assign out_1_7[15:0] = lb1d_14__out_7[15:0];
  assign out_8_5[15:0] = lb1d_7__out_5[15:0];
  assign out_2_3[15:0] = lb1d_13__out_3[15:0];
  assign out_12_5[15:0] = lb1d_3__out_5[15:0];
  assign out_2_7[15:0] = lb1d_13__out_7[15:0];
  assign out_3_13[15:0] = lb1d_12__out_13[15:0];
  assign out_3_14[15:0] = lb1d_12__out_14[15:0];
  assign out_2_8[15:0] = lb1d_13__out_8[15:0];
  assign out_3_15[15:0] = lb1d_12__out_15[15:0];
  assign out_0_1[15:0] = lb1d_15__out_1[15:0];
  assign out_3_16[15:0] = lb1d_12__out_16[15:0];
  assign out_2_9[15:0] = lb1d_13__out_9[15:0];
  assign out_3_17[15:0] = lb1d_12__out_17[15:0];
  assign out_11_4[15:0] = lb1d_4__out_4[15:0];
  assign out_3_18[15:0] = lb1d_12__out_18[15:0];
  assign out_2_10[15:0] = lb1d_13__out_10[15:0];
  assign out_3_19[15:0] = lb1d_12__out_19[15:0];
  assign out_12_2[15:0] = lb1d_3__out_2[15:0];
  assign out_12_0[15:0] = lb1d_3__out_0[15:0];
  assign out_2_11[15:0] = lb1d_13__out_11[15:0];
  assign out_2_12[15:0] = lb1d_13__out_12[15:0];
  assign out_0_10[15:0] = lb1d_15__out_10[15:0];
  assign out_2_13[15:0] = lb1d_13__out_13[15:0];
  assign out_1_8[15:0] = lb1d_14__out_8[15:0];
  assign out_2_14[15:0] = lb1d_13__out_14[15:0];
  assign out_10_1[15:0] = lb1d_5__out_1[15:0];
  assign out_2_15[15:0] = lb1d_13__out_15[15:0];
  assign out_1_9[15:0] = lb1d_14__out_9[15:0];
  assign out_2_16[15:0] = lb1d_13__out_16[15:0];
  assign out_2_17[15:0] = lb1d_13__out_17[15:0];
  assign out_1_10[15:0] = lb1d_14__out_10[15:0];
  assign out_2_18[15:0] = lb1d_13__out_18[15:0];
  assign out_13_7[15:0] = lb1d_2__out_7[15:0];
  assign out_2_19[15:0] = lb1d_13__out_19[15:0];
  assign out_1_11[15:0] = lb1d_14__out_11[15:0];
  assign out_7_5[15:0] = lb1d_8__out_5[15:0];
  assign out_0_3[15:0] = lb1d_15__out_3[15:0];
  assign out_0_9[15:0] = lb1d_15__out_9[15:0];
  assign out_1_12[15:0] = lb1d_14__out_12[15:0];
  assign out_8_8[15:0] = lb1d_7__out_8[15:0];
  assign out_1_13[15:0] = lb1d_14__out_13[15:0];
  assign out_11_3[15:0] = lb1d_4__out_3[15:0];
  assign out_1_14[15:0] = lb1d_14__out_14[15:0];
  assign out_1_15[15:0] = lb1d_14__out_15[15:0];
  assign out_10_4[15:0] = lb1d_5__out_4[15:0];
  assign out_1_16[15:0] = lb1d_14__out_16[15:0];
  assign out_11_9[15:0] = lb1d_4__out_9[15:0];
  assign out_1_17[15:0] = lb1d_14__out_17[15:0];
  assign out_13_0[15:0] = lb1d_2__out_0[15:0];
  assign out_1_18[15:0] = lb1d_14__out_18[15:0];
  assign out_1_19[15:0] = lb1d_14__out_19[15:0];
  assign out_12_7[15:0] = lb1d_3__out_7[15:0];
  assign out_8_4[15:0] = lb1d_7__out_4[15:0];
  assign out_13_5[15:0] = lb1d_2__out_5[15:0];
  assign out_0_11[15:0] = lb1d_15__out_11[15:0];
  assign out_13_15[15:0] = lb1d_2__out_15[15:0];
  assign out_13_9[15:0] = lb1d_2__out_9[15:0];
  assign out_0_12[15:0] = lb1d_15__out_12[15:0];
  assign out_12_10[15:0] = lb1d_3__out_10[15:0];
  assign out_0_13[15:0] = lb1d_15__out_13[15:0];
  assign out_12_4[15:0] = lb1d_3__out_4[15:0];
  assign out_0_14[15:0] = lb1d_15__out_14[15:0];
  assign out_11_5[15:0] = lb1d_4__out_5[15:0];
  assign out_0_15[15:0] = lb1d_15__out_15[15:0];
  assign out_8_6[15:0] = lb1d_7__out_6[15:0];
  assign out_0_16[15:0] = lb1d_15__out_16[15:0];
  assign out_11_6[15:0] = lb1d_4__out_6[15:0];
  assign out_0_17[15:0] = lb1d_15__out_17[15:0];
  assign out_0_18[15:0] = lb1d_15__out_18[15:0];
  assign out_11_7[15:0] = lb1d_4__out_7[15:0];
  assign out_0_19[15:0] = lb1d_15__out_19[15:0];
  assign out_13_10[15:0] = lb1d_2__out_10[15:0];
  assign out_12_6[15:0] = lb1d_3__out_6[15:0];
  assign out_9_6[15:0] = lb1d_6__out_6[15:0];
  assign out_12_1[15:0] = lb1d_3__out_1[15:0];
  assign out_9_1[15:0] = lb1d_6__out_1[15:0];
  assign out_13_11[15:0] = lb1d_2__out_11[15:0];
  assign out_13_16[15:0] = lb1d_2__out_16[15:0];
  assign out_8_3[15:0] = lb1d_7__out_3[15:0];
  assign out_13_12[15:0] = lb1d_2__out_12[15:0];
  assign out_12_8[15:0] = lb1d_3__out_8[15:0];
  assign out_13_13[15:0] = lb1d_2__out_13[15:0];
  assign out_11_8[15:0] = lb1d_4__out_8[15:0];
  assign out_13_14[15:0] = lb1d_2__out_14[15:0];
  assign out_13_17[15:0] = lb1d_2__out_17[15:0];
  assign out_13_18[15:0] = lb1d_2__out_18[15:0];
  assign out_12_9[15:0] = lb1d_3__out_9[15:0];
  assign out_13_19[15:0] = lb1d_2__out_19[15:0];
  assign out_12_12[15:0] = lb1d_3__out_12[15:0];
  assign out_12_11[15:0] = lb1d_3__out_11[15:0];
  assign out_9_2[15:0] = lb1d_6__out_2[15:0];
  assign out_10_0[15:0] = lb1d_5__out_0[15:0];
  assign out_11_10[15:0] = lb1d_4__out_10[15:0];
  assign out_10_6[15:0] = lb1d_5__out_6[15:0];
  assign out_11_11[15:0] = lb1d_4__out_11[15:0];
  assign out_12_13[15:0] = lb1d_3__out_13[15:0];
  assign out_7_1[15:0] = lb1d_8__out_1[15:0];
  assign out_12_14[15:0] = lb1d_3__out_14[15:0];
  assign out_12_15[15:0] = lb1d_3__out_15[15:0];
  assign out_9_3[15:0] = lb1d_6__out_3[15:0];
  assign out_12_16[15:0] = lb1d_3__out_16[15:0];
  assign out_12_17[15:0] = lb1d_3__out_17[15:0];
  assign out_9_4[15:0] = lb1d_6__out_4[15:0];
  assign out_12_18[15:0] = lb1d_3__out_18[15:0];
  assign out_9_5[15:0] = lb1d_6__out_5[15:0];
  assign out_12_19[15:0] = lb1d_3__out_19[15:0];
  assign out_11_12[15:0] = lb1d_4__out_12[15:0];
  assign out_10_7[15:0] = lb1d_5__out_7[15:0];
  assign out_10_2[15:0] = lb1d_5__out_2[15:0];
  assign out_6_1[15:0] = lb1d_9__out_1[15:0];
  assign out_10_3[15:0] = lb1d_5__out_3[15:0];
  assign out_10_8[15:0] = lb1d_5__out_8[15:0];
  assign out_11_13[15:0] = lb1d_4__out_13[15:0];
  assign out_8_0[15:0] = lb1d_7__out_0[15:0];
  assign out_11_14[15:0] = lb1d_4__out_14[15:0];
  assign out_10_9[15:0] = lb1d_5__out_9[15:0];
  assign out_11_15[15:0] = lb1d_4__out_15[15:0];
  assign out_6_0[15:0] = lb1d_9__out_0[15:0];
  assign out_11_16[15:0] = lb1d_4__out_16[15:0];
  assign out_10_10[15:0] = lb1d_5__out_10[15:0];
  assign out_11_17[15:0] = lb1d_4__out_17[15:0];
  assign out_8_7[15:0] = lb1d_7__out_7[15:0];
  assign out_11_18[15:0] = lb1d_4__out_18[15:0];
  assign out_10_11[15:0] = lb1d_5__out_11[15:0];
  assign out_11_19[15:0] = lb1d_4__out_19[15:0];
  assign out_7_8[15:0] = lb1d_8__out_8[15:0];
  assign out_9_0[15:0] = lb1d_6__out_0[15:0];
  assign out_9_7[15:0] = lb1d_6__out_7[15:0];
  assign out_10_12[15:0] = lb1d_5__out_12[15:0];
  assign out_7_2[15:0] = lb1d_8__out_2[15:0];
  assign out_10_13[15:0] = lb1d_5__out_13[15:0];
  assign out_9_8[15:0] = lb1d_6__out_8[15:0];
  assign out_10_14[15:0] = lb1d_5__out_14[15:0];
  assign out_10_15[15:0] = lb1d_5__out_15[15:0];
  assign out_9_9[15:0] = lb1d_6__out_9[15:0];
  assign out_10_16[15:0] = lb1d_5__out_16[15:0];
  assign out_7_3[15:0] = lb1d_8__out_3[15:0];
  assign out_10_17[15:0] = lb1d_5__out_17[15:0];
  assign out_10_18[15:0] = lb1d_5__out_18[15:0];
  assign out_9_10[15:0] = lb1d_6__out_10[15:0];
  assign out_9_11[15:0] = lb1d_6__out_11[15:0];
  assign out_10_19[15:0] = lb1d_5__out_19[15:0];
  assign out_7_7[15:0] = lb1d_8__out_7[15:0];
  assign out_8_1[15:0] = lb1d_7__out_1[15:0];
  assign out_8_2[15:0] = lb1d_7__out_2[15:0];
  assign out_7_14[15:0] = lb1d_8__out_14[15:0];
  assign out_8_9[15:0] = lb1d_7__out_9[15:0];
  assign out_9_12[15:0] = lb1d_6__out_12[15:0];
  assign out_7_11[15:0] = lb1d_8__out_11[15:0];
  assign out_9_13[15:0] = lb1d_6__out_13[15:0];
  assign out_8_10[15:0] = lb1d_7__out_10[15:0];
  assign out_9_14[15:0] = lb1d_6__out_14[15:0];
  assign out_9_15[15:0] = lb1d_6__out_15[15:0];
  assign out_9_16[15:0] = lb1d_6__out_16[15:0];
  assign out_9_17[15:0] = lb1d_6__out_17[15:0];
  assign out_9_18[15:0] = lb1d_6__out_18[15:0];
  assign out_9_19[15:0] = lb1d_6__out_19[15:0];
  assign out_7_0[15:0] = lb1d_8__out_0[15:0];
  assign out_6_10[15:0] = lb1d_9__out_10[15:0];
  assign out_7_4[15:0] = lb1d_8__out_4[15:0];
  assign out_8_11[15:0] = lb1d_7__out_11[15:0];
  assign out_7_10[15:0] = lb1d_8__out_10[15:0];
  assign out_8_12[15:0] = lb1d_7__out_12[15:0];
  assign out_6_3[15:0] = lb1d_9__out_3[15:0];
  assign out_8_13[15:0] = lb1d_7__out_13[15:0];
  assign out_8_14[15:0] = lb1d_7__out_14[15:0];
  assign out_8_15[15:0] = lb1d_7__out_15[15:0];
  assign out_8_16[15:0] = lb1d_7__out_16[15:0];
  assign out_8_17[15:0] = lb1d_7__out_17[15:0];
  assign out_8_18[15:0] = lb1d_7__out_18[15:0];
  assign out_8_19[15:0] = lb1d_7__out_19[15:0];
  assign out_6_6[15:0] = lb1d_9__out_6[15:0];
  assign out_6_7[15:0] = lb1d_9__out_7[15:0];
  assign out_7_9[15:0] = lb1d_8__out_9[15:0];
  assign out_7_12[15:0] = lb1d_8__out_12[15:0];
  assign out_7_13[15:0] = lb1d_8__out_13[15:0];
  assign out_7_15[15:0] = lb1d_8__out_15[15:0];
  assign out_6_8[15:0] = lb1d_9__out_8[15:0];
  assign out_7_16[15:0] = lb1d_8__out_16[15:0];
  assign out_7_17[15:0] = lb1d_8__out_17[15:0];
  assign out_6_9[15:0] = lb1d_9__out_9[15:0];
  assign out_7_18[15:0] = lb1d_8__out_18[15:0];
  assign out_7_19[15:0] = lb1d_8__out_19[15:0];
  assign out_6_12[15:0] = lb1d_9__out_12[15:0];
  assign out_6_11[15:0] = lb1d_9__out_11[15:0];
  assign out_6_5[15:0] = lb1d_9__out_5[15:0];
  assign out_6_13[15:0] = lb1d_9__out_13[15:0];
  assign out_6_14[15:0] = lb1d_9__out_14[15:0];
  assign out_6_15[15:0] = lb1d_9__out_15[15:0];
  assign out_6_16[15:0] = lb1d_9__out_16[15:0];
  assign out_6_17[15:0] = lb1d_9__out_17[15:0];
  assign out_6_18[15:0] = lb1d_9__out_18[15:0];
  assign out_6_19[15:0] = lb1d_9__out_19[15:0];

endmodule //linebuffer_U0

module Downscale (
  input  CLK,
  input [15:0] I_0_0,
  output [15:0] O,
  output  V,
  input  WE
);
  //Wire declarations for instance 'inst0' (Module linebuffer_U0)
  wire  inst0__clk;
  wire [15:0] inst0__in_0_0;
  wire [15:0] inst0__out_0_0;
  wire [15:0] inst0__out_0_1;
  wire [15:0] inst0__out_0_10;
  wire [15:0] inst0__out_0_11;
  wire [15:0] inst0__out_0_12;
  wire [15:0] inst0__out_0_13;
  wire [15:0] inst0__out_0_14;
  wire [15:0] inst0__out_0_15;
  wire [15:0] inst0__out_0_16;
  wire [15:0] inst0__out_0_17;
  wire [15:0] inst0__out_0_18;
  wire [15:0] inst0__out_0_19;
  wire [15:0] inst0__out_0_2;
  wire [15:0] inst0__out_0_3;
  wire [15:0] inst0__out_0_4;
  wire [15:0] inst0__out_0_5;
  wire [15:0] inst0__out_0_6;
  wire [15:0] inst0__out_0_7;
  wire [15:0] inst0__out_0_8;
  wire [15:0] inst0__out_0_9;
  wire [15:0] inst0__out_10_0;
  wire [15:0] inst0__out_10_1;
  wire [15:0] inst0__out_10_10;
  wire [15:0] inst0__out_10_11;
  wire [15:0] inst0__out_10_12;
  wire [15:0] inst0__out_10_13;
  wire [15:0] inst0__out_10_14;
  wire [15:0] inst0__out_10_15;
  wire [15:0] inst0__out_10_16;
  wire [15:0] inst0__out_10_17;
  wire [15:0] inst0__out_10_18;
  wire [15:0] inst0__out_10_19;
  wire [15:0] inst0__out_10_2;
  wire [15:0] inst0__out_10_3;
  wire [15:0] inst0__out_10_4;
  wire [15:0] inst0__out_10_5;
  wire [15:0] inst0__out_10_6;
  wire [15:0] inst0__out_10_7;
  wire [15:0] inst0__out_10_8;
  wire [15:0] inst0__out_10_9;
  wire [15:0] inst0__out_11_0;
  wire [15:0] inst0__out_11_1;
  wire [15:0] inst0__out_11_10;
  wire [15:0] inst0__out_11_11;
  wire [15:0] inst0__out_11_12;
  wire [15:0] inst0__out_11_13;
  wire [15:0] inst0__out_11_14;
  wire [15:0] inst0__out_11_15;
  wire [15:0] inst0__out_11_16;
  wire [15:0] inst0__out_11_17;
  wire [15:0] inst0__out_11_18;
  wire [15:0] inst0__out_11_19;
  wire [15:0] inst0__out_11_2;
  wire [15:0] inst0__out_11_3;
  wire [15:0] inst0__out_11_4;
  wire [15:0] inst0__out_11_5;
  wire [15:0] inst0__out_11_6;
  wire [15:0] inst0__out_11_7;
  wire [15:0] inst0__out_11_8;
  wire [15:0] inst0__out_11_9;
  wire [15:0] inst0__out_12_0;
  wire [15:0] inst0__out_12_1;
  wire [15:0] inst0__out_12_10;
  wire [15:0] inst0__out_12_11;
  wire [15:0] inst0__out_12_12;
  wire [15:0] inst0__out_12_13;
  wire [15:0] inst0__out_12_14;
  wire [15:0] inst0__out_12_15;
  wire [15:0] inst0__out_12_16;
  wire [15:0] inst0__out_12_17;
  wire [15:0] inst0__out_12_18;
  wire [15:0] inst0__out_12_19;
  wire [15:0] inst0__out_12_2;
  wire [15:0] inst0__out_12_3;
  wire [15:0] inst0__out_12_4;
  wire [15:0] inst0__out_12_5;
  wire [15:0] inst0__out_12_6;
  wire [15:0] inst0__out_12_7;
  wire [15:0] inst0__out_12_8;
  wire [15:0] inst0__out_12_9;
  wire [15:0] inst0__out_13_0;
  wire [15:0] inst0__out_13_1;
  wire [15:0] inst0__out_13_10;
  wire [15:0] inst0__out_13_11;
  wire [15:0] inst0__out_13_12;
  wire [15:0] inst0__out_13_13;
  wire [15:0] inst0__out_13_14;
  wire [15:0] inst0__out_13_15;
  wire [15:0] inst0__out_13_16;
  wire [15:0] inst0__out_13_17;
  wire [15:0] inst0__out_13_18;
  wire [15:0] inst0__out_13_19;
  wire [15:0] inst0__out_13_2;
  wire [15:0] inst0__out_13_3;
  wire [15:0] inst0__out_13_4;
  wire [15:0] inst0__out_13_5;
  wire [15:0] inst0__out_13_6;
  wire [15:0] inst0__out_13_7;
  wire [15:0] inst0__out_13_8;
  wire [15:0] inst0__out_13_9;
  wire [15:0] inst0__out_14_0;
  wire [15:0] inst0__out_14_1;
  wire [15:0] inst0__out_14_10;
  wire [15:0] inst0__out_14_11;
  wire [15:0] inst0__out_14_12;
  wire [15:0] inst0__out_14_13;
  wire [15:0] inst0__out_14_14;
  wire [15:0] inst0__out_14_15;
  wire [15:0] inst0__out_14_16;
  wire [15:0] inst0__out_14_17;
  wire [15:0] inst0__out_14_18;
  wire [15:0] inst0__out_14_19;
  wire [15:0] inst0__out_14_2;
  wire [15:0] inst0__out_14_3;
  wire [15:0] inst0__out_14_4;
  wire [15:0] inst0__out_14_5;
  wire [15:0] inst0__out_14_6;
  wire [15:0] inst0__out_14_7;
  wire [15:0] inst0__out_14_8;
  wire [15:0] inst0__out_14_9;
  wire [15:0] inst0__out_15_0;
  wire [15:0] inst0__out_15_1;
  wire [15:0] inst0__out_15_10;
  wire [15:0] inst0__out_15_11;
  wire [15:0] inst0__out_15_12;
  wire [15:0] inst0__out_15_13;
  wire [15:0] inst0__out_15_14;
  wire [15:0] inst0__out_15_15;
  wire [15:0] inst0__out_15_16;
  wire [15:0] inst0__out_15_17;
  wire [15:0] inst0__out_15_18;
  wire [15:0] inst0__out_15_19;
  wire [15:0] inst0__out_15_2;
  wire [15:0] inst0__out_15_3;
  wire [15:0] inst0__out_15_4;
  wire [15:0] inst0__out_15_5;
  wire [15:0] inst0__out_15_6;
  wire [15:0] inst0__out_15_7;
  wire [15:0] inst0__out_15_8;
  wire [15:0] inst0__out_15_9;
  wire [15:0] inst0__out_1_0;
  wire [15:0] inst0__out_1_1;
  wire [15:0] inst0__out_1_10;
  wire [15:0] inst0__out_1_11;
  wire [15:0] inst0__out_1_12;
  wire [15:0] inst0__out_1_13;
  wire [15:0] inst0__out_1_14;
  wire [15:0] inst0__out_1_15;
  wire [15:0] inst0__out_1_16;
  wire [15:0] inst0__out_1_17;
  wire [15:0] inst0__out_1_18;
  wire [15:0] inst0__out_1_19;
  wire [15:0] inst0__out_1_2;
  wire [15:0] inst0__out_1_3;
  wire [15:0] inst0__out_1_4;
  wire [15:0] inst0__out_1_5;
  wire [15:0] inst0__out_1_6;
  wire [15:0] inst0__out_1_7;
  wire [15:0] inst0__out_1_8;
  wire [15:0] inst0__out_1_9;
  wire [15:0] inst0__out_2_0;
  wire [15:0] inst0__out_2_1;
  wire [15:0] inst0__out_2_10;
  wire [15:0] inst0__out_2_11;
  wire [15:0] inst0__out_2_12;
  wire [15:0] inst0__out_2_13;
  wire [15:0] inst0__out_2_14;
  wire [15:0] inst0__out_2_15;
  wire [15:0] inst0__out_2_16;
  wire [15:0] inst0__out_2_17;
  wire [15:0] inst0__out_2_18;
  wire [15:0] inst0__out_2_19;
  wire [15:0] inst0__out_2_2;
  wire [15:0] inst0__out_2_3;
  wire [15:0] inst0__out_2_4;
  wire [15:0] inst0__out_2_5;
  wire [15:0] inst0__out_2_6;
  wire [15:0] inst0__out_2_7;
  wire [15:0] inst0__out_2_8;
  wire [15:0] inst0__out_2_9;
  wire [15:0] inst0__out_3_0;
  wire [15:0] inst0__out_3_1;
  wire [15:0] inst0__out_3_10;
  wire [15:0] inst0__out_3_11;
  wire [15:0] inst0__out_3_12;
  wire [15:0] inst0__out_3_13;
  wire [15:0] inst0__out_3_14;
  wire [15:0] inst0__out_3_15;
  wire [15:0] inst0__out_3_16;
  wire [15:0] inst0__out_3_17;
  wire [15:0] inst0__out_3_18;
  wire [15:0] inst0__out_3_19;
  wire [15:0] inst0__out_3_2;
  wire [15:0] inst0__out_3_3;
  wire [15:0] inst0__out_3_4;
  wire [15:0] inst0__out_3_5;
  wire [15:0] inst0__out_3_6;
  wire [15:0] inst0__out_3_7;
  wire [15:0] inst0__out_3_8;
  wire [15:0] inst0__out_3_9;
  wire [15:0] inst0__out_4_0;
  wire [15:0] inst0__out_4_1;
  wire [15:0] inst0__out_4_10;
  wire [15:0] inst0__out_4_11;
  wire [15:0] inst0__out_4_12;
  wire [15:0] inst0__out_4_13;
  wire [15:0] inst0__out_4_14;
  wire [15:0] inst0__out_4_15;
  wire [15:0] inst0__out_4_16;
  wire [15:0] inst0__out_4_17;
  wire [15:0] inst0__out_4_18;
  wire [15:0] inst0__out_4_19;
  wire [15:0] inst0__out_4_2;
  wire [15:0] inst0__out_4_3;
  wire [15:0] inst0__out_4_4;
  wire [15:0] inst0__out_4_5;
  wire [15:0] inst0__out_4_6;
  wire [15:0] inst0__out_4_7;
  wire [15:0] inst0__out_4_8;
  wire [15:0] inst0__out_4_9;
  wire [15:0] inst0__out_5_0;
  wire [15:0] inst0__out_5_1;
  wire [15:0] inst0__out_5_10;
  wire [15:0] inst0__out_5_11;
  wire [15:0] inst0__out_5_12;
  wire [15:0] inst0__out_5_13;
  wire [15:0] inst0__out_5_14;
  wire [15:0] inst0__out_5_15;
  wire [15:0] inst0__out_5_16;
  wire [15:0] inst0__out_5_17;
  wire [15:0] inst0__out_5_18;
  wire [15:0] inst0__out_5_19;
  wire [15:0] inst0__out_5_2;
  wire [15:0] inst0__out_5_3;
  wire [15:0] inst0__out_5_4;
  wire [15:0] inst0__out_5_5;
  wire [15:0] inst0__out_5_6;
  wire [15:0] inst0__out_5_7;
  wire [15:0] inst0__out_5_8;
  wire [15:0] inst0__out_5_9;
  wire [15:0] inst0__out_6_0;
  wire [15:0] inst0__out_6_1;
  wire [15:0] inst0__out_6_10;
  wire [15:0] inst0__out_6_11;
  wire [15:0] inst0__out_6_12;
  wire [15:0] inst0__out_6_13;
  wire [15:0] inst0__out_6_14;
  wire [15:0] inst0__out_6_15;
  wire [15:0] inst0__out_6_16;
  wire [15:0] inst0__out_6_17;
  wire [15:0] inst0__out_6_18;
  wire [15:0] inst0__out_6_19;
  wire [15:0] inst0__out_6_2;
  wire [15:0] inst0__out_6_3;
  wire [15:0] inst0__out_6_4;
  wire [15:0] inst0__out_6_5;
  wire [15:0] inst0__out_6_6;
  wire [15:0] inst0__out_6_7;
  wire [15:0] inst0__out_6_8;
  wire [15:0] inst0__out_6_9;
  wire [15:0] inst0__out_7_0;
  wire [15:0] inst0__out_7_1;
  wire [15:0] inst0__out_7_10;
  wire [15:0] inst0__out_7_11;
  wire [15:0] inst0__out_7_12;
  wire [15:0] inst0__out_7_13;
  wire [15:0] inst0__out_7_14;
  wire [15:0] inst0__out_7_15;
  wire [15:0] inst0__out_7_16;
  wire [15:0] inst0__out_7_17;
  wire [15:0] inst0__out_7_18;
  wire [15:0] inst0__out_7_19;
  wire [15:0] inst0__out_7_2;
  wire [15:0] inst0__out_7_3;
  wire [15:0] inst0__out_7_4;
  wire [15:0] inst0__out_7_5;
  wire [15:0] inst0__out_7_6;
  wire [15:0] inst0__out_7_7;
  wire [15:0] inst0__out_7_8;
  wire [15:0] inst0__out_7_9;
  wire [15:0] inst0__out_8_0;
  wire [15:0] inst0__out_8_1;
  wire [15:0] inst0__out_8_10;
  wire [15:0] inst0__out_8_11;
  wire [15:0] inst0__out_8_12;
  wire [15:0] inst0__out_8_13;
  wire [15:0] inst0__out_8_14;
  wire [15:0] inst0__out_8_15;
  wire [15:0] inst0__out_8_16;
  wire [15:0] inst0__out_8_17;
  wire [15:0] inst0__out_8_18;
  wire [15:0] inst0__out_8_19;
  wire [15:0] inst0__out_8_2;
  wire [15:0] inst0__out_8_3;
  wire [15:0] inst0__out_8_4;
  wire [15:0] inst0__out_8_5;
  wire [15:0] inst0__out_8_6;
  wire [15:0] inst0__out_8_7;
  wire [15:0] inst0__out_8_8;
  wire [15:0] inst0__out_8_9;
  wire [15:0] inst0__out_9_0;
  wire [15:0] inst0__out_9_1;
  wire [15:0] inst0__out_9_10;
  wire [15:0] inst0__out_9_11;
  wire [15:0] inst0__out_9_12;
  wire [15:0] inst0__out_9_13;
  wire [15:0] inst0__out_9_14;
  wire [15:0] inst0__out_9_15;
  wire [15:0] inst0__out_9_16;
  wire [15:0] inst0__out_9_17;
  wire [15:0] inst0__out_9_18;
  wire [15:0] inst0__out_9_19;
  wire [15:0] inst0__out_9_2;
  wire [15:0] inst0__out_9_3;
  wire [15:0] inst0__out_9_4;
  wire [15:0] inst0__out_9_5;
  wire [15:0] inst0__out_9_6;
  wire [15:0] inst0__out_9_7;
  wire [15:0] inst0__out_9_8;
  wire [15:0] inst0__out_9_9;
  wire  inst0__valid;
  wire  inst0__valid_chain;
  wire  inst0__wen;
  linebuffer_U0 inst0(
    .clk(inst0__clk),
    .in_0_0(inst0__in_0_0),
    .out_0_0(inst0__out_0_0),
    .out_0_1(inst0__out_0_1),
    .out_0_10(inst0__out_0_10),
    .out_0_11(inst0__out_0_11),
    .out_0_12(inst0__out_0_12),
    .out_0_13(inst0__out_0_13),
    .out_0_14(inst0__out_0_14),
    .out_0_15(inst0__out_0_15),
    .out_0_16(inst0__out_0_16),
    .out_0_17(inst0__out_0_17),
    .out_0_18(inst0__out_0_18),
    .out_0_19(inst0__out_0_19),
    .out_0_2(inst0__out_0_2),
    .out_0_3(inst0__out_0_3),
    .out_0_4(inst0__out_0_4),
    .out_0_5(inst0__out_0_5),
    .out_0_6(inst0__out_0_6),
    .out_0_7(inst0__out_0_7),
    .out_0_8(inst0__out_0_8),
    .out_0_9(inst0__out_0_9),
    .out_10_0(inst0__out_10_0),
    .out_10_1(inst0__out_10_1),
    .out_10_10(inst0__out_10_10),
    .out_10_11(inst0__out_10_11),
    .out_10_12(inst0__out_10_12),
    .out_10_13(inst0__out_10_13),
    .out_10_14(inst0__out_10_14),
    .out_10_15(inst0__out_10_15),
    .out_10_16(inst0__out_10_16),
    .out_10_17(inst0__out_10_17),
    .out_10_18(inst0__out_10_18),
    .out_10_19(inst0__out_10_19),
    .out_10_2(inst0__out_10_2),
    .out_10_3(inst0__out_10_3),
    .out_10_4(inst0__out_10_4),
    .out_10_5(inst0__out_10_5),
    .out_10_6(inst0__out_10_6),
    .out_10_7(inst0__out_10_7),
    .out_10_8(inst0__out_10_8),
    .out_10_9(inst0__out_10_9),
    .out_11_0(inst0__out_11_0),
    .out_11_1(inst0__out_11_1),
    .out_11_10(inst0__out_11_10),
    .out_11_11(inst0__out_11_11),
    .out_11_12(inst0__out_11_12),
    .out_11_13(inst0__out_11_13),
    .out_11_14(inst0__out_11_14),
    .out_11_15(inst0__out_11_15),
    .out_11_16(inst0__out_11_16),
    .out_11_17(inst0__out_11_17),
    .out_11_18(inst0__out_11_18),
    .out_11_19(inst0__out_11_19),
    .out_11_2(inst0__out_11_2),
    .out_11_3(inst0__out_11_3),
    .out_11_4(inst0__out_11_4),
    .out_11_5(inst0__out_11_5),
    .out_11_6(inst0__out_11_6),
    .out_11_7(inst0__out_11_7),
    .out_11_8(inst0__out_11_8),
    .out_11_9(inst0__out_11_9),
    .out_12_0(inst0__out_12_0),
    .out_12_1(inst0__out_12_1),
    .out_12_10(inst0__out_12_10),
    .out_12_11(inst0__out_12_11),
    .out_12_12(inst0__out_12_12),
    .out_12_13(inst0__out_12_13),
    .out_12_14(inst0__out_12_14),
    .out_12_15(inst0__out_12_15),
    .out_12_16(inst0__out_12_16),
    .out_12_17(inst0__out_12_17),
    .out_12_18(inst0__out_12_18),
    .out_12_19(inst0__out_12_19),
    .out_12_2(inst0__out_12_2),
    .out_12_3(inst0__out_12_3),
    .out_12_4(inst0__out_12_4),
    .out_12_5(inst0__out_12_5),
    .out_12_6(inst0__out_12_6),
    .out_12_7(inst0__out_12_7),
    .out_12_8(inst0__out_12_8),
    .out_12_9(inst0__out_12_9),
    .out_13_0(inst0__out_13_0),
    .out_13_1(inst0__out_13_1),
    .out_13_10(inst0__out_13_10),
    .out_13_11(inst0__out_13_11),
    .out_13_12(inst0__out_13_12),
    .out_13_13(inst0__out_13_13),
    .out_13_14(inst0__out_13_14),
    .out_13_15(inst0__out_13_15),
    .out_13_16(inst0__out_13_16),
    .out_13_17(inst0__out_13_17),
    .out_13_18(inst0__out_13_18),
    .out_13_19(inst0__out_13_19),
    .out_13_2(inst0__out_13_2),
    .out_13_3(inst0__out_13_3),
    .out_13_4(inst0__out_13_4),
    .out_13_5(inst0__out_13_5),
    .out_13_6(inst0__out_13_6),
    .out_13_7(inst0__out_13_7),
    .out_13_8(inst0__out_13_8),
    .out_13_9(inst0__out_13_9),
    .out_14_0(inst0__out_14_0),
    .out_14_1(inst0__out_14_1),
    .out_14_10(inst0__out_14_10),
    .out_14_11(inst0__out_14_11),
    .out_14_12(inst0__out_14_12),
    .out_14_13(inst0__out_14_13),
    .out_14_14(inst0__out_14_14),
    .out_14_15(inst0__out_14_15),
    .out_14_16(inst0__out_14_16),
    .out_14_17(inst0__out_14_17),
    .out_14_18(inst0__out_14_18),
    .out_14_19(inst0__out_14_19),
    .out_14_2(inst0__out_14_2),
    .out_14_3(inst0__out_14_3),
    .out_14_4(inst0__out_14_4),
    .out_14_5(inst0__out_14_5),
    .out_14_6(inst0__out_14_6),
    .out_14_7(inst0__out_14_7),
    .out_14_8(inst0__out_14_8),
    .out_14_9(inst0__out_14_9),
    .out_15_0(inst0__out_15_0),
    .out_15_1(inst0__out_15_1),
    .out_15_10(inst0__out_15_10),
    .out_15_11(inst0__out_15_11),
    .out_15_12(inst0__out_15_12),
    .out_15_13(inst0__out_15_13),
    .out_15_14(inst0__out_15_14),
    .out_15_15(inst0__out_15_15),
    .out_15_16(inst0__out_15_16),
    .out_15_17(inst0__out_15_17),
    .out_15_18(inst0__out_15_18),
    .out_15_19(inst0__out_15_19),
    .out_15_2(inst0__out_15_2),
    .out_15_3(inst0__out_15_3),
    .out_15_4(inst0__out_15_4),
    .out_15_5(inst0__out_15_5),
    .out_15_6(inst0__out_15_6),
    .out_15_7(inst0__out_15_7),
    .out_15_8(inst0__out_15_8),
    .out_15_9(inst0__out_15_9),
    .out_1_0(inst0__out_1_0),
    .out_1_1(inst0__out_1_1),
    .out_1_10(inst0__out_1_10),
    .out_1_11(inst0__out_1_11),
    .out_1_12(inst0__out_1_12),
    .out_1_13(inst0__out_1_13),
    .out_1_14(inst0__out_1_14),
    .out_1_15(inst0__out_1_15),
    .out_1_16(inst0__out_1_16),
    .out_1_17(inst0__out_1_17),
    .out_1_18(inst0__out_1_18),
    .out_1_19(inst0__out_1_19),
    .out_1_2(inst0__out_1_2),
    .out_1_3(inst0__out_1_3),
    .out_1_4(inst0__out_1_4),
    .out_1_5(inst0__out_1_5),
    .out_1_6(inst0__out_1_6),
    .out_1_7(inst0__out_1_7),
    .out_1_8(inst0__out_1_8),
    .out_1_9(inst0__out_1_9),
    .out_2_0(inst0__out_2_0),
    .out_2_1(inst0__out_2_1),
    .out_2_10(inst0__out_2_10),
    .out_2_11(inst0__out_2_11),
    .out_2_12(inst0__out_2_12),
    .out_2_13(inst0__out_2_13),
    .out_2_14(inst0__out_2_14),
    .out_2_15(inst0__out_2_15),
    .out_2_16(inst0__out_2_16),
    .out_2_17(inst0__out_2_17),
    .out_2_18(inst0__out_2_18),
    .out_2_19(inst0__out_2_19),
    .out_2_2(inst0__out_2_2),
    .out_2_3(inst0__out_2_3),
    .out_2_4(inst0__out_2_4),
    .out_2_5(inst0__out_2_5),
    .out_2_6(inst0__out_2_6),
    .out_2_7(inst0__out_2_7),
    .out_2_8(inst0__out_2_8),
    .out_2_9(inst0__out_2_9),
    .out_3_0(inst0__out_3_0),
    .out_3_1(inst0__out_3_1),
    .out_3_10(inst0__out_3_10),
    .out_3_11(inst0__out_3_11),
    .out_3_12(inst0__out_3_12),
    .out_3_13(inst0__out_3_13),
    .out_3_14(inst0__out_3_14),
    .out_3_15(inst0__out_3_15),
    .out_3_16(inst0__out_3_16),
    .out_3_17(inst0__out_3_17),
    .out_3_18(inst0__out_3_18),
    .out_3_19(inst0__out_3_19),
    .out_3_2(inst0__out_3_2),
    .out_3_3(inst0__out_3_3),
    .out_3_4(inst0__out_3_4),
    .out_3_5(inst0__out_3_5),
    .out_3_6(inst0__out_3_6),
    .out_3_7(inst0__out_3_7),
    .out_3_8(inst0__out_3_8),
    .out_3_9(inst0__out_3_9),
    .out_4_0(inst0__out_4_0),
    .out_4_1(inst0__out_4_1),
    .out_4_10(inst0__out_4_10),
    .out_4_11(inst0__out_4_11),
    .out_4_12(inst0__out_4_12),
    .out_4_13(inst0__out_4_13),
    .out_4_14(inst0__out_4_14),
    .out_4_15(inst0__out_4_15),
    .out_4_16(inst0__out_4_16),
    .out_4_17(inst0__out_4_17),
    .out_4_18(inst0__out_4_18),
    .out_4_19(inst0__out_4_19),
    .out_4_2(inst0__out_4_2),
    .out_4_3(inst0__out_4_3),
    .out_4_4(inst0__out_4_4),
    .out_4_5(inst0__out_4_5),
    .out_4_6(inst0__out_4_6),
    .out_4_7(inst0__out_4_7),
    .out_4_8(inst0__out_4_8),
    .out_4_9(inst0__out_4_9),
    .out_5_0(inst0__out_5_0),
    .out_5_1(inst0__out_5_1),
    .out_5_10(inst0__out_5_10),
    .out_5_11(inst0__out_5_11),
    .out_5_12(inst0__out_5_12),
    .out_5_13(inst0__out_5_13),
    .out_5_14(inst0__out_5_14),
    .out_5_15(inst0__out_5_15),
    .out_5_16(inst0__out_5_16),
    .out_5_17(inst0__out_5_17),
    .out_5_18(inst0__out_5_18),
    .out_5_19(inst0__out_5_19),
    .out_5_2(inst0__out_5_2),
    .out_5_3(inst0__out_5_3),
    .out_5_4(inst0__out_5_4),
    .out_5_5(inst0__out_5_5),
    .out_5_6(inst0__out_5_6),
    .out_5_7(inst0__out_5_7),
    .out_5_8(inst0__out_5_8),
    .out_5_9(inst0__out_5_9),
    .out_6_0(inst0__out_6_0),
    .out_6_1(inst0__out_6_1),
    .out_6_10(inst0__out_6_10),
    .out_6_11(inst0__out_6_11),
    .out_6_12(inst0__out_6_12),
    .out_6_13(inst0__out_6_13),
    .out_6_14(inst0__out_6_14),
    .out_6_15(inst0__out_6_15),
    .out_6_16(inst0__out_6_16),
    .out_6_17(inst0__out_6_17),
    .out_6_18(inst0__out_6_18),
    .out_6_19(inst0__out_6_19),
    .out_6_2(inst0__out_6_2),
    .out_6_3(inst0__out_6_3),
    .out_6_4(inst0__out_6_4),
    .out_6_5(inst0__out_6_5),
    .out_6_6(inst0__out_6_6),
    .out_6_7(inst0__out_6_7),
    .out_6_8(inst0__out_6_8),
    .out_6_9(inst0__out_6_9),
    .out_7_0(inst0__out_7_0),
    .out_7_1(inst0__out_7_1),
    .out_7_10(inst0__out_7_10),
    .out_7_11(inst0__out_7_11),
    .out_7_12(inst0__out_7_12),
    .out_7_13(inst0__out_7_13),
    .out_7_14(inst0__out_7_14),
    .out_7_15(inst0__out_7_15),
    .out_7_16(inst0__out_7_16),
    .out_7_17(inst0__out_7_17),
    .out_7_18(inst0__out_7_18),
    .out_7_19(inst0__out_7_19),
    .out_7_2(inst0__out_7_2),
    .out_7_3(inst0__out_7_3),
    .out_7_4(inst0__out_7_4),
    .out_7_5(inst0__out_7_5),
    .out_7_6(inst0__out_7_6),
    .out_7_7(inst0__out_7_7),
    .out_7_8(inst0__out_7_8),
    .out_7_9(inst0__out_7_9),
    .out_8_0(inst0__out_8_0),
    .out_8_1(inst0__out_8_1),
    .out_8_10(inst0__out_8_10),
    .out_8_11(inst0__out_8_11),
    .out_8_12(inst0__out_8_12),
    .out_8_13(inst0__out_8_13),
    .out_8_14(inst0__out_8_14),
    .out_8_15(inst0__out_8_15),
    .out_8_16(inst0__out_8_16),
    .out_8_17(inst0__out_8_17),
    .out_8_18(inst0__out_8_18),
    .out_8_19(inst0__out_8_19),
    .out_8_2(inst0__out_8_2),
    .out_8_3(inst0__out_8_3),
    .out_8_4(inst0__out_8_4),
    .out_8_5(inst0__out_8_5),
    .out_8_6(inst0__out_8_6),
    .out_8_7(inst0__out_8_7),
    .out_8_8(inst0__out_8_8),
    .out_8_9(inst0__out_8_9),
    .out_9_0(inst0__out_9_0),
    .out_9_1(inst0__out_9_1),
    .out_9_10(inst0__out_9_10),
    .out_9_11(inst0__out_9_11),
    .out_9_12(inst0__out_9_12),
    .out_9_13(inst0__out_9_13),
    .out_9_14(inst0__out_9_14),
    .out_9_15(inst0__out_9_15),
    .out_9_16(inst0__out_9_16),
    .out_9_17(inst0__out_9_17),
    .out_9_18(inst0__out_9_18),
    .out_9_19(inst0__out_9_19),
    .out_9_2(inst0__out_9_2),
    .out_9_3(inst0__out_9_3),
    .out_9_4(inst0__out_9_4),
    .out_9_5(inst0__out_9_5),
    .out_9_6(inst0__out_9_6),
    .out_9_7(inst0__out_9_7),
    .out_9_8(inst0__out_9_8),
    .out_9_9(inst0__out_9_9),
    .valid(inst0__valid),
    .valid_chain(inst0__valid_chain),
    .wen(inst0__wen)
  );

  //Wire declarations for instance 'inst1' (Module reduceParallel_U1)
  wire [15:0] inst1__in_data_0;
  wire [15:0] inst1__in_data_1;
  wire [15:0] inst1__in_data_10;
  wire [15:0] inst1__in_data_11;
  wire [15:0] inst1__in_data_12;
  wire [15:0] inst1__in_data_13;
  wire [15:0] inst1__in_data_14;
  wire [15:0] inst1__in_data_15;
  wire [15:0] inst1__in_data_2;
  wire [15:0] inst1__in_data_3;
  wire [15:0] inst1__in_data_4;
  wire [15:0] inst1__in_data_5;
  wire [15:0] inst1__in_data_6;
  wire [15:0] inst1__in_data_7;
  wire [15:0] inst1__in_data_8;
  wire [15:0] inst1__in_data_9;
  wire [15:0] inst1__in_identity;
  wire [15:0] inst1__out;
  reduceParallel_U1 inst1(
    .in_data_0(inst1__in_data_0),
    .in_data_1(inst1__in_data_1),
    .in_data_10(inst1__in_data_10),
    .in_data_11(inst1__in_data_11),
    .in_data_12(inst1__in_data_12),
    .in_data_13(inst1__in_data_13),
    .in_data_14(inst1__in_data_14),
    .in_data_15(inst1__in_data_15),
    .in_data_2(inst1__in_data_2),
    .in_data_3(inst1__in_data_3),
    .in_data_4(inst1__in_data_4),
    .in_data_5(inst1__in_data_5),
    .in_data_6(inst1__in_data_6),
    .in_data_7(inst1__in_data_7),
    .in_data_8(inst1__in_data_8),
    .in_data_9(inst1__in_data_9),
    .in_identity(inst1__in_identity),
    .out(inst1__out)
  );

  //Wire declarations for instance 'inst2' (Module coreir_const160)
  wire [15:0] inst2__out;
  coreir_const160 inst2(
    .out(inst2__out)
  );

  //All the connections
  assign V = inst0__valid;
  assign inst0__wen = WE;
  assign inst1__in_identity[15:0] = inst2__out[15:0];
  assign O[15:0] = inst1__out[15:0];
  assign inst0__clk = CLK;
  assign inst1__in_data_0[15:0] = inst0__out_0_0[15:0];
  assign inst1__in_data_9[15:0] = inst0__out_10_6[15:0];
  assign inst1__in_data_7[15:0] = inst0__out_4_19[15:0];
  assign inst1__in_data_4[15:0] = inst0__out_4_0[15:0];
  assign inst1__in_data_3[15:0] = inst0__out_0_19[15:0];
  assign inst1__in_data_2[15:0] = inst0__out_0_13[15:0];
  assign inst1__in_data_1[15:0] = inst0__out_0_6[15:0];
  assign inst0__in_0_0[15:0] = I_0_0[15:0];
  assign inst1__in_data_6[15:0] = inst0__out_4_13[15:0];
  assign inst1__in_data_5[15:0] = inst0__out_4_6[15:0];
  assign inst1__in_data_8[15:0] = inst0__out_10_0[15:0];
  assign inst1__in_data_15[15:0] = inst0__out_14_19[15:0];
  assign inst1__in_data_14[15:0] = inst0__out_14_13[15:0];
  assign inst1__in_data_13[15:0] = inst0__out_14_6[15:0];
  assign inst1__in_data_12[15:0] = inst0__out_14_0[15:0];
  assign inst1__in_data_11[15:0] = inst0__out_10_19[15:0];
  assign inst1__in_data_10[15:0] = inst0__out_10_13[15:0];

endmodule //Downscale
