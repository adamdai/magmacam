//Module: pullresistor defined externally
//Module: Add16 defined externally


module corebit_tribuf (
  input in,
  input en,
  inout out
);
  assign out = en ? in : 1'bz;

endmodule //corebit_tribuf

module coreir_or #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 | in1;

endmodule //coreir_or

module bitopn_U18 (
  input [0:0] in,
  output  out
);
  //All the connections
  assign out = in[0];

endmodule //bitopn_U18

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

module corebit_mux (
  input in0,
  input in1,
  input sel,
  output out
);
  assign out = sel ? in1 : in0;

endmodule //corebit_mux

module coreir_const #(parameter value=1, parameter width=1) (
  output [width-1:0] out
);
  assign out = value;

endmodule //coreir_const

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

module bitopn_U17 (
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

endmodule //bitopn_U17

module bitopn_U8 (
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

  //Wire declarations for instance 'opN_0' (Module bitopn_U17)
  wire [1:0] opN_0__in;
  wire  opN_0__out;
  bitopn_U17 opN_0(
    .in(opN_0__in),
    .out(opN_0__out)
  );

  //Wire declarations for instance 'opN_1' (Module bitopn_U18)
  wire [0:0] opN_1__in;
  wire  opN_1__out;
  bitopn_U18 opN_1(
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

endmodule //bitopn_U8

module corebit_concat (
  input in0,
  input in1,
  output [1:0] out
);
  assign out = {in0, in1};

endmodule //corebit_concat

module coreir_add #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  output [width-1:0] out
);
  assign out = in0 + in1;

endmodule //coreir_add

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
  assign out[15:0] = inst0__O[15:0];
  assign inst0__I0[15:0] = in0[15:0];
  assign inst0__I1[15:0] = in1[15:0];

endmodule //renamedForReduce_opAdd16_I0_In_Bits_16___I1_In_Bits_16___O_Out_Bits_16___

module reduceParallelPower2Inputs_U2 (
  input [15:0] in_0,
  input [15:0] in_1,
  input [15:0] in_2,
  input [15:0] in_3,
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

  //All the connections
  assign op_1_0__in1[15:0] = in_1[15:0];
  assign op_1_1__in0[15:0] = in_2[15:0];
  assign op_0_0__in1[15:0] = op_1_1__out[15:0];
  assign op_1_1__in1[15:0] = in_3[15:0];
  assign op_0_0__in0[15:0] = op_1_0__out[15:0];
  assign out[15:0] = op_0_0__out[15:0];
  assign op_1_0__in0[15:0] = in_0[15:0];

endmodule //reduceParallelPower2Inputs_U2

module reduceParallel_U1 (
  input [15:0] in_data_0,
  input [15:0] in_data_1,
  input [15:0] in_data_2,
  input [15:0] in_data_3,
  input [15:0] in_identity,
  output [15:0] out
);
  //Wire declarations for instance 'reducer' (Module reduceParallelPower2Inputs_U2)
  wire [15:0] reducer__in_0;
  wire [15:0] reducer__in_1;
  wire [15:0] reducer__in_2;
  wire [15:0] reducer__in_3;
  wire [15:0] reducer__out;
  reduceParallelPower2Inputs_U2 reducer(
    .in_0(reducer__in_0),
    .in_1(reducer__in_1),
    .in_2(reducer__in_2),
    .in_3(reducer__in_3),
    .out(reducer__out)
  );

  //All the connections
  assign out[15:0] = reducer__out[15:0];
  assign reducer__in_2[15:0] = in_data_2[15:0];
  assign reducer__in_3[15:0] = in_data_3[15:0];
  assign reducer__in_1[15:0] = in_data_1[15:0];
  assign reducer__in_0[15:0] = in_data_0[15:0];

endmodule //reduceParallel_U1

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

module coreir_mux #(parameter width=1) (
  input [width-1:0] in0,
  input [width-1:0] in1,
  input sel,
  output [width-1:0] out
);
  assign out = sel ? in1 : in0;

endmodule //coreir_mux

module reg_U24 #(parameter init=1) (
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

endmodule //reg_U24

module counter_U10 #(parameter init=1, parameter max=1) (
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

  //Wire declarations for instance 'r' (Module reg_U24)
  wire  r__clk;
  wire  r__clr;
  wire  r__en;
  wire [1:0] r__in;
  wire [1:0] r__out;
  reg_U24 #(.init(init)) r(
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

endmodule //counter_U10

module linebuffer_U3 (
  input  clk,
  input [15:0] in_0,
  output [15:0] out_0,
  output [15:0] out_1,
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

  //All the connections
  assign out_1[15:0] = in_0[15:0];
  assign reg_1__in[15:0] = in_0[15:0];
  assign out_0[15:0] = reg_1__out[15:0];
  assign valid = wen;
  assign valid_chain = wen;
  assign reg_1__clk = clk;

endmodule //linebuffer_U3

module reg_U19 #(parameter init=1) (
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

endmodule //reg_U19

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

  //Wire declarations for instance 'count' (Module reg_U19)
  wire  count__clk;
  wire  count__clr;
  wire  count__en;
  wire [15:0] count__in;
  wire [15:0] count__out;
  reg_U19 #(.init(16'b0000000000000000)) count(
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
  coreir_const #(.value(16'b0000000000000011),.width(16)) max(
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

module reg_U11 #(parameter init=1) (
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

endmodule //reg_U11

module reg_U12 #(parameter init=1) (
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

endmodule //reg_U12

module rowbuffer_U4 (
  input  clk,
  input  flush,
  output [15:0] rdata,
  output  valid,
  input [15:0] wdata,
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

  //Wire declarations for instance 'cnt' (Module reg_U11)
  wire  cnt__clk;
  wire  cnt__clr;
  wire  cnt__en;
  wire [2:0] cnt__in;
  wire [2:0] cnt__out;
  reg_U11 #(.init(3'b000)) cnt(
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
  wire [15:0] mem__rdata;
  wire [1:0] mem__waddr;
  wire [15:0] mem__wdata;
  wire  mem__wen;
  coreir_mem #(.depth(4),.has_init(0),.width(16)) mem(
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

  //Wire declarations for instance 'raddr' (Module counter_U10)
  wire  raddr__clk;
  wire  raddr__en;
  wire [1:0] raddr__out;
  wire  raddr__srst;
  counter_U10 #(.init(2'b00),.max(2'b11)) raddr(
    .clk(raddr__clk),
    .en(raddr__en),
    .out(raddr__out),
    .srst(raddr__srst)
  );

  //Wire declarations for instance 'state' (Module reg_U12)
  wire  state__clk;
  wire  state__clr;
  wire  state__en;
  wire [0:0] state__in;
  wire [0:0] state__out;
  reg_U12 #(.init(1'b0)) state(
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

  //Wire declarations for instance 'waddr' (Module counter_U10)
  wire  waddr__clk;
  wire  waddr__en;
  wire [1:0] waddr__out;
  wire  waddr__srst;
  counter_U10 #(.init(2'b00),.max(2'b11)) waddr(
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
  assign cnt__clk = clk;
  assign mem__clk = clk;
  assign raddr__clk = clk;
  assign waddr__clk = clk;
  assign state__clk = clk;
  assign mem__raddr[1:0] = raddr__out[1:0];
  assign mem__waddr[1:0] = waddr__out[1:0];
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
  assign add_wen__in0[2:0] = wen_ext__out[2:0];
  assign add_wen__in1[2:0] = cnt__out[2:0];
  assign cnt__in[2:0] = add_wen__out[2:0];
  assign eq_depth__in1[2:0] = add_wen__out[2:0];
  assign eq_depth__in0[2:0] = depth_m1__out[2:0];
  assign state__en = eq_depth__out;
  assign state__in[0] = c1__out;

endmodule //rowbuffer_U4

module linebuffer_U0 (
  input  clk,
  input [15:0] in_0_0,
  output [15:0] out_0_0,
  output [15:0] out_0_1,
  output [15:0] out_1_0,
  output [15:0] out_1_1,
  output  valid,
  output  valid_chain,
  input  wen
);
  //Wire declarations for instance 'const_stencil0' (Module coreir_const)
  wire [15:0] const_stencil0__out;
  coreir_const #(.value(16'b0000000000000001),.width(16)) const_stencil0(
    .out(const_stencil0__out)
  );

  //Wire declarations for instance 'const_stencil1' (Module coreir_const)
  wire [15:0] const_stencil1__out;
  coreir_const #(.value(16'b0000000000000001),.width(16)) const_stencil1(
    .out(const_stencil1__out)
  );

  //Wire declarations for instance 'lb1d_0' (Module linebuffer_U3)
  wire  lb1d_0__clk;
  wire [15:0] lb1d_0__in_0;
  wire [15:0] lb1d_0__out_0;
  wire [15:0] lb1d_0__out_1;
  wire  lb1d_0__valid;
  wire  lb1d_0__valid_chain;
  wire  lb1d_0__wen;
  linebuffer_U3 lb1d_0(
    .clk(lb1d_0__clk),
    .in_0(lb1d_0__in_0),
    .out_0(lb1d_0__out_0),
    .out_1(lb1d_0__out_1),
    .valid(lb1d_0__valid),
    .valid_chain(lb1d_0__valid_chain),
    .wen(lb1d_0__wen)
  );

  //Wire declarations for instance 'lb1d_1' (Module linebuffer_U3)
  wire  lb1d_1__clk;
  wire [15:0] lb1d_1__in_0;
  wire [15:0] lb1d_1__out_0;
  wire [15:0] lb1d_1__out_1;
  wire  lb1d_1__valid;
  wire  lb1d_1__valid_chain;
  wire  lb1d_1__wen;
  linebuffer_U3 lb1d_1(
    .clk(lb1d_1__clk),
    .in_0(lb1d_1__in_0),
    .out_0(lb1d_1__out_0),
    .out_1(lb1d_1__out_1),
    .valid(lb1d_1__valid),
    .valid_chain(lb1d_1__valid_chain),
    .wen(lb1d_1__wen)
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

  //Wire declarations for instance 'valcounter_1' (Module counter_U7)
  wire  valcounter_1__clk;
  wire  valcounter_1__en;
  wire [15:0] valcounter_1__out;
  wire  valcounter_1__overflow;
  wire  valcounter_1__reset;
  counter_U7 valcounter_1(
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

  //Wire declarations for instance 'valid_andr' (Module bitopn_U8)
  wire [2:0] valid_andr__in;
  wire  valid_andr__out;
  bitopn_U8 valid_andr(
    .in(valid_andr__in),
    .out(valid_andr__out)
  );

  //All the connections
  assign out_0_1[15:0] = lb1d_1__out_1[15:0];
  assign lb1d_1__in_0[15:0] = lbmem_1_0__rdata[15:0];
  assign lbmem_1_0__wen = wen;
  assign valcounter_0__en = wen;
  assign valid_andr__in[0] = wen;
  assign lb1d_1__wen = wen;
  assign lb1d_0__wen = wen;
  assign valcompare_0__in0[15:0] = const_stencil0__out[15:0];
  assign valcounter_0__reset = valcounter_0_reset__out;
  assign valcompare_0__in1[15:0] = valcounter_0__out[15:0];
  assign lbmem_1_0__flush = lbmem_1_0_flush__out;
  assign valid_chain = lbmem_1_0__valid;
  assign valcounter_1__reset = valcounter_1_reset__out;
  assign lbmem_1_0__wdata[15:0] = in_0_0[15:0];
  assign lb1d_0__in_0[15:0] = in_0_0[15:0];
  assign valid = valid_andr__out;
  assign valcounter_1__en = valcounter_0__overflow;
  assign valcompare_1__in0[15:0] = const_stencil1__out[15:0];
  assign valcompare_1__in1[15:0] = valcounter_1__out[15:0];
  assign valid_andr__in[1] = valcompare_0__out;
  assign valid_andr__in[2] = valcompare_1__out;
  assign lb1d_0__clk = clk;
  assign lb1d_1__clk = clk;
  assign lbmem_1_0__clk = clk;
  assign valcounter_0__clk = clk;
  assign valcounter_1__clk = clk;
  assign out_1_0[15:0] = lb1d_0__out_0[15:0];
  assign out_1_1[15:0] = lb1d_0__out_1[15:0];
  assign out_0_0[15:0] = lb1d_1__out_0[15:0];

endmodule //linebuffer_U0

module STEN (
  input  CLK,
  input [15:0] I_0_0,
  output [15:0] L00,
  output [15:0] L01,
  output [15:0] L10,
  output [15:0] L11,
  output [15:0] O,
  output  V,
  input  WE
);
  //Wire declarations for instance 'inst0' (Module linebuffer_U0)
  wire  inst0__clk;
  wire [15:0] inst0__in_0_0;
  wire [15:0] inst0__out_0_0;
  wire [15:0] inst0__out_0_1;
  wire [15:0] inst0__out_1_0;
  wire [15:0] inst0__out_1_1;
  wire  inst0__valid;
  wire  inst0__valid_chain;
  wire  inst0__wen;
  linebuffer_U0 inst0(
    .clk(inst0__clk),
    .in_0_0(inst0__in_0_0),
    .out_0_0(inst0__out_0_0),
    .out_0_1(inst0__out_0_1),
    .out_1_0(inst0__out_1_0),
    .out_1_1(inst0__out_1_1),
    .valid(inst0__valid),
    .valid_chain(inst0__valid_chain),
    .wen(inst0__wen)
  );

  //Wire declarations for instance 'inst1' (Module reduceParallel_U1)
  wire [15:0] inst1__in_data_0;
  wire [15:0] inst1__in_data_1;
  wire [15:0] inst1__in_data_2;
  wire [15:0] inst1__in_data_3;
  wire [15:0] inst1__in_identity;
  wire [15:0] inst1__out;
  reduceParallel_U1 inst1(
    .in_data_0(inst1__in_data_0),
    .in_data_1(inst1__in_data_1),
    .in_data_2(inst1__in_data_2),
    .in_data_3(inst1__in_data_3),
    .in_identity(inst1__in_identity),
    .out(inst1__out)
  );

  //Wire declarations for instance 'inst2' (Module coreir_const160)
  wire [15:0] inst2__out;
  coreir_const160 inst2(
    .out(inst2__out)
  );

  //All the connections
  assign inst1__in_data_1[15:0] = inst0__out_0_1[15:0];
  assign L00[15:0] = inst0__out_0_0[15:0];
  assign L01[15:0] = inst0__out_0_1[15:0];
  assign L10[15:0] = inst0__out_1_0[15:0];
  assign L11[15:0] = inst0__out_1_1[15:0];
  assign V = inst0__valid;
  assign inst0__wen = WE;
  assign inst1__in_identity[15:0] = inst2__out[15:0];
  assign O[15:0] = inst1__out[15:0];
  assign inst0__clk = CLK;
  assign inst1__in_data_2[15:0] = inst0__out_1_0[15:0];
  assign inst1__in_data_0[15:0] = inst0__out_0_0[15:0];
  assign inst1__in_data_3[15:0] = inst0__out_1_1[15:0];
  assign inst0__in_0_0[15:0] = I_0_0[15:0];

endmodule //STEN
