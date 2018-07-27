//Module: Add16 defined externally
//Module: pullresistor defined externally


module coreir_or #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 | in1;

endmodule //coreir_or

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

module corebit_and (
  input in0,
  input in1,
  output out
);
  assign out = in0 & in1;

endmodule //corebit_and

module corebit_concat (
  input in0,
  input in1,
  output [1:0] out
);
  assign out = {in0, in1};

endmodule //corebit_concat

module corebit_term (
  input in
);


endmodule //corebit_term

module corebit_const #(parameter value=1) (
  output out
);
  assign out = value;

endmodule //corebit_const

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

module muxn_U7 (
  input [15:0] in_data_0,
  input [15:0] in_data_1,
  input [0:0] in_sel,
  output [15:0] out
);
  //Wire declarations for instance 'join' (Module coreir_mux)
  wire [15:0] join__in0;
  wire [15:0] join__in1;
  wire [15:0] join__out;
  wire  join__sel;
  coreir_mux #(.width(16)) join(
    .in0(join__in0),
    .in1(join__in1),
    .out(join__out),
    .sel(join__sel)
  );

  //All the connections
  assign out[15:0] = join__out[15:0];
  assign join__in0[15:0] = in_data_0[15:0];
  assign join__in1[15:0] = in_data_1[15:0];
  assign join__sel = in_sel[0];

endmodule //muxn_U7

module coreir_const160 (
  output [15:0] out
);
  //Wire declarations for instance 'bit_const_GND' (Module corebit_const)
  wire  bit_const_GND__out;
  corebit_const #(.value(0)) bit_const_GND(
    .out(bit_const_GND__out)
  );

  //All the connections
  assign out[0] = bit_const_GND__out;
  assign out[10] = bit_const_GND__out;
  assign out[11] = bit_const_GND__out;
  assign out[12] = bit_const_GND__out;
  assign out[13] = bit_const_GND__out;
  assign out[14] = bit_const_GND__out;
  assign out[15] = bit_const_GND__out;
  assign out[1] = bit_const_GND__out;
  assign out[2] = bit_const_GND__out;
  assign out[3] = bit_const_GND__out;
  assign out[4] = bit_const_GND__out;
  assign out[5] = bit_const_GND__out;
  assign out[6] = bit_const_GND__out;
  assign out[7] = bit_const_GND__out;
  assign out[8] = bit_const_GND__out;
  assign out[9] = bit_const_GND__out;

endmodule //coreir_const160

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

module corebit_tribuf (
  input in,
  input en,
  inout out
);
  assign out = en ? in : 1'bz;

endmodule //corebit_tribuf

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

module coreir_const #(parameter value=1, parameter width=1) (
  output [width-1:0] out
);
  assign out = value;

endmodule //coreir_const

module coreir_add #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 + in1;

endmodule //coreir_add

module coreir_ult #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output out
);
  assign out = in0 < in1;

endmodule //coreir_ult

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

  //All the connections
  assign op_0_0__in0[15:0] = in_0[15:0];
  assign op_0_0__in1[15:0] = in_1[15:0];
  assign out[15:0] = op_0_0__out[15:0];

endmodule //reduceParallelPower2Inputs_U2

module reduceParallel_U0 (
  input [15:0] in_data_0,
  input [15:0] in_data_1,
  input [15:0] in_identity,
  output [15:0] out
);
  //Wire declarations for instance 'reducer' (Module reduceParallelPower2Inputs_U2)
  wire [15:0] reducer__in_0;
  wire [15:0] reducer__in_1;
  wire [15:0] reducer__out;
  reduceParallelPower2Inputs_U2 reducer(
    .in_0(reducer__in_0),
    .in_1(reducer__in_1),
    .out(reducer__out)
  );

  //All the connections
  assign reducer__in_1[15:0] = in_data_1[15:0];
  assign out[15:0] = reducer__out[15:0];
  assign reducer__in_0[15:0] = in_data_0[15:0];

endmodule //reduceParallel_U0

module reg_U9 #(parameter init=1) (
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

endmodule //reg_U9

module counter_U3 (
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

  //Wire declarations for instance 'count' (Module reg_U9)
  wire  count__clk;
  wire  count__clr;
  wire  count__en;
  wire [15:0] count__in;
  wire [15:0] count__out;
  reg_U9 #(.init(16'b0000000000000000)) count(
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
  coreir_const #(.value(16'b0000000000000001),.width(16)) max(
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
  assign out[15:0] = count__out[15:0];
  assign add__in0[15:0] = count__out[15:0];
  assign add__in1[15:0] = inc__out[15:0];
  assign count__en = en;
  assign count__in[15:0] = add__out[15:0];
  assign ult__in1[15:0] = add__out[15:0];
  assign ult__in0[15:0] = max__out[15:0];
  assign resetOr__in0[0] = ult__out;
  assign overflow = ult__out;
  assign resetOr__in1[0] = reset;
  assign count__clr = resetOr__out[0];
  assign count__clk = clk;

endmodule //counter_U3

module reduceSequential_U1 (
  input  clk,
  input [15:0] in,
  output [15:0] out,
  output  valid
);
  //Wire declarations for instance 'accumulatorInputMux' (Module muxn_U7)
  wire [15:0] accumulatorInputMux__in_data_0;
  wire [15:0] accumulatorInputMux__in_data_1;
  wire [0:0] accumulatorInputMux__in_sel;
  wire [15:0] accumulatorInputMux__out;
  muxn_U7 accumulatorInputMux(
    .in_data_0(accumulatorInputMux__in_data_0),
    .in_data_1(accumulatorInputMux__in_data_1),
    .in_sel(accumulatorInputMux__in_sel),
    .out(accumulatorInputMux__out)
  );

  //Wire declarations for instance 'accumulatorReg' (Module coreir_reg)
  wire  accumulatorReg__clk;
  wire [15:0] accumulatorReg__in;
  wire [15:0] accumulatorReg__out;
  coreir_reg #(.clk_posedge(1),.init(16'bxxxxxxxxxxxxxxxx),.width(16)) accumulatorReg(
    .clk(accumulatorReg__clk),
    .in(accumulatorReg__in),
    .out(accumulatorReg__out)
  );

  //Wire declarations for instance 'constInput_1-h0' (Module coreir_const)
  wire [0:0] constInput_1-h0__out;
  coreir_const #(.value(1'b0),.width(1)) constInput_1-h0(
    .out(constInput_1-h0__out)
  );

  //Wire declarations for instance 'constInput_1-h1' (Module coreir_const)
  wire [0:0] constInput_1-h1__out;
  coreir_const #(.value(1'b1),.width(1)) constInput_1-h1(
    .out(constInput_1-h1__out)
  );

  //Wire declarations for instance 'counter' (Module counter_U3)
  wire  counter__clk;
  wire  counter__en;
  wire [15:0] counter__out;
  wire  counter__overflow;
  wire  counter__reset;
  counter_U3 counter(
    .clk(counter__clk),
    .en(counter__en),
    .out(counter__out),
    .overflow(counter__overflow),
    .reset(counter__reset)
  );

  //Wire declarations for instance 'equal' (Module coreir_eq)
  wire [15:0] equal__in0;
  wire [15:0] equal__in1;
  wire  equal__out;
  coreir_eq #(.width(16)) equal(
    .in0(equal__in0),
    .in1(equal__in1),
    .out(equal__out)
  );

  //Wire declarations for instance 'op' (Module renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___)
  wire [15:0] op__in0;
  wire [15:0] op__in1;
  wire [15:0] op__out;
  renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___ op(
    .in0(op__in0),
    .in1(op__in1),
    .out(op__out)
  );

  //Wire declarations for instance 'zero' (Module coreir_const)
  wire [15:0] zero__out;
  coreir_const #(.value(16'b0000000000000000),.width(16)) zero(
    .out(zero__out)
  );

  //All the connections
  assign op__in0[15:0] = in[15:0];
  assign accumulatorInputMux__in_data_1[15:0] = in[15:0];
  assign op__in1[15:0] = accumulatorReg__out[15:0];
  assign accumulatorInputMux__in_data_0[15:0] = op__out[15:0];
  assign accumulatorReg__in[15:0] = accumulatorInputMux__out[15:0];
  assign out[15:0] = accumulatorInputMux__out[15:0];
  assign equal__in0[15:0] = zero__out[15:0];
  assign equal__in1[15:0] = counter__out[15:0];
  assign accumulatorInputMux__in_sel[0] = equal__out;
  assign valid = counter__overflow;
  assign counter__reset = constInput_1-h0__out[0];
  assign counter__en = constInput_1-h1__out[0];
  assign accumulatorReg__clk = clk;
  assign counter__clk = clk;

endmodule //reduceSequential_U1

module ReduceHybrid (
  input  CLK,
  input [15:0] I_0,
  input [15:0] I_1,
  output [15:0] O,
  output  V,
  input  WE
);
  //Wire declarations for instance 'inst0' (Module reduceParallel_U0)
  wire [15:0] inst0__in_data_0;
  wire [15:0] inst0__in_data_1;
  wire [15:0] inst0__in_identity;
  wire [15:0] inst0__out;
  reduceParallel_U0 inst0(
    .in_data_0(inst0__in_data_0),
    .in_data_1(inst0__in_data_1),
    .in_identity(inst0__in_identity),
    .out(inst0__out)
  );

  //Wire declarations for instance 'inst1' (Module coreir_const160)
  wire [15:0] inst1__out;
  coreir_const160 inst1(
    .out(inst1__out)
  );

  //Wire declarations for instance 'inst2' (Module reduceSequential_U1)
  wire  inst2__clk;
  wire [15:0] inst2__in;
  wire [15:0] inst2__out;
  wire  inst2__valid;
  reduceSequential_U1 inst2(
    .clk(inst2__clk),
    .in(inst2__in),
    .out(inst2__out),
    .valid(inst2__valid)
  );

  //All the connections
  assign inst0__in_data_0[15:0] = I_0[15:0];
  assign inst0__in_data_1[15:0] = I_1[15:0];
  assign inst0__in_identity[15:0] = inst1__out[15:0];
  assign inst2__in[15:0] = inst0__out[15:0];
  assign O[15:0] = inst2__out[15:0];
  assign V = inst2__valid;
  assign inst2__clk = CLK;

endmodule //ReduceHybrid
