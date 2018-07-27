module FullAdder (input  I0, input  I1, input  CIN, output  O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
SB_LUT4 #(.LUT_INIT(16'h9696)) inst0 (.I0(I0), .I1(I1), .I2(CIN), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0), .I1(I1), .CI(CIN), .CO(inst1_CO));
assign O = inst0_O;
assign COUT = inst1_CO;
endmodule

module Add8 (input [7:0] I0, input [7:0] I1, output [7:0] O);
wire  inst0_O;
wire  inst0_COUT;
wire  inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
wire  inst4_O;
wire  inst4_COUT;
wire  inst5_O;
wire  inst5_COUT;
wire  inst6_O;
wire  inst6_COUT;
wire  inst7_O;
wire  inst7_COUT;
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(1'b0), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(I0[4]), .I1(I1[4]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
FullAdder inst5 (.I0(I0[5]), .I1(I1[5]), .CIN(inst4_COUT), .O(inst5_O), .COUT(inst5_COUT));
FullAdder inst6 (.I0(I0[6]), .I1(I1[6]), .CIN(inst5_COUT), .O(inst6_O), .COUT(inst6_COUT));
FullAdder inst7 (.I0(I0[7]), .I1(I1[7]), .CIN(inst6_COUT), .O(inst7_O), .COUT(inst7_COUT));
assign O = {inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Register8R (input [7:0] I, output [7:0] O, input  CLK, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
SB_DFFSR inst0 (.C(CLK), .R(RESET), .D(I[0]), .Q(inst0_Q));
SB_DFFSR inst1 (.C(CLK), .R(RESET), .D(I[1]), .Q(inst1_Q));
SB_DFFSR inst2 (.C(CLK), .R(RESET), .D(I[2]), .Q(inst2_Q));
SB_DFFSR inst3 (.C(CLK), .R(RESET), .D(I[3]), .Q(inst3_Q));
SB_DFFSR inst4 (.C(CLK), .R(RESET), .D(I[4]), .Q(inst4_Q));
SB_DFFSR inst5 (.C(CLK), .R(RESET), .D(I[5]), .Q(inst5_Q));
SB_DFFSR inst6 (.C(CLK), .R(RESET), .D(I[6]), .Q(inst6_Q));
SB_DFFSR inst7 (.C(CLK), .R(RESET), .D(I[7]), .Q(inst7_Q));
assign O = {inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter8R (output [7:0] O, input  CLK, input  RESET);
wire [7:0] inst0_O;
wire [7:0] inst1_O;
Add8 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O));
Register8R inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .RESET(RESET));
assign O = inst1_O;
endmodule

module EQ8 (input [7:0] I0, input [7:0] I1, output  O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
SB_LUT4 #(.LUT_INIT(16'h8282)) inst0 (.I0(1'b1), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst1 (.I0(inst0_O), .I1(I0[1]), .I2(I1[1]), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst2 (.I0(inst1_O), .I1(I0[2]), .I2(I1[2]), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst3 (.I0(inst2_O), .I1(I0[3]), .I2(I1[3]), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst4 (.I0(inst3_O), .I1(I0[4]), .I2(I1[4]), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst5 (.I0(inst4_O), .I1(I0[5]), .I2(I1[5]), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst6 (.I0(inst5_O), .I1(I0[6]), .I2(I1[6]), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst7 (.I0(inst6_O), .I1(I0[7]), .I2(I1[7]), .I3(1'b0), .O(inst7_O));
assign O = inst7_O;
endmodule

module Decode1028 (input [7:0] I, output  O);
wire  inst0_O;
EQ8 inst0 (.I0(I), .I1({1'b0,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,1'b0}), .O(inst0_O));
assign O = inst0_O;
endmodule

module Counter8Mod103COUT (output [7:0] O, output  COUT, input  CLK);
wire [7:0] inst0_O;
wire  inst1_O;
Counter8R inst0 (.O(inst0_O), .CLK(CLK), .RESET(inst1_O));
Decode1028 inst1 (.I(inst0_O), .O(inst1_O));
assign O = inst0_O;
assign COUT = inst1_O;
endmodule

module Add5Cout (input [4:0] I0, input [4:0] I1, output [4:0] O, output  COUT);
wire  inst0_O;
wire  inst0_COUT;
wire  inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
wire  inst4_O;
wire  inst4_COUT;
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(1'b0), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(I0[4]), .I1(I1[4]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
assign O = {inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
assign COUT = inst4_COUT;
endmodule

module Register5CE (input [4:0] I, output [4:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(I[4]), .Q(inst4_Q));
assign O = {inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter5CE (output [4:0] O, output  COUT, input  CLK, input  CE);
wire [4:0] inst0_O;
wire  inst0_COUT;
wire [4:0] inst1_O;
Add5Cout inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register5CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module EQ5 (input [4:0] I0, input [4:0] I1, output  O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
SB_LUT4 #(.LUT_INIT(16'h8282)) inst0 (.I0(1'b1), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst1 (.I0(inst0_O), .I1(I0[1]), .I2(I1[1]), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst2 (.I0(inst1_O), .I1(I0[2]), .I2(I1[2]), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst3 (.I0(inst2_O), .I1(I0[3]), .I2(I1[3]), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst4 (.I0(inst3_O), .I1(I0[4]), .I2(I1[4]), .I3(1'b0), .O(inst4_O));
assign O = inst4_O;
endmodule

module Decode05 (input [4:0] I, output  O);
wire  inst0_O;
EQ5 inst0 (.I0(I), .I1({1'b0,1'b0,1'b0,1'b0,1'b0}), .O(inst0_O));
assign O = inst0_O;
endmodule

module Add16 (input [15:0] I0, input [15:0] I1, output [15:0] O);
wire  inst0_O;
wire  inst0_COUT;
wire  inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
wire  inst4_O;
wire  inst4_COUT;
wire  inst5_O;
wire  inst5_COUT;
wire  inst6_O;
wire  inst6_COUT;
wire  inst7_O;
wire  inst7_COUT;
wire  inst8_O;
wire  inst8_COUT;
wire  inst9_O;
wire  inst9_COUT;
wire  inst10_O;
wire  inst10_COUT;
wire  inst11_O;
wire  inst11_COUT;
wire  inst12_O;
wire  inst12_COUT;
wire  inst13_O;
wire  inst13_COUT;
wire  inst14_O;
wire  inst14_COUT;
wire  inst15_O;
wire  inst15_COUT;
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(1'b0), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(I0[4]), .I1(I1[4]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
FullAdder inst5 (.I0(I0[5]), .I1(I1[5]), .CIN(inst4_COUT), .O(inst5_O), .COUT(inst5_COUT));
FullAdder inst6 (.I0(I0[6]), .I1(I1[6]), .CIN(inst5_COUT), .O(inst6_O), .COUT(inst6_COUT));
FullAdder inst7 (.I0(I0[7]), .I1(I1[7]), .CIN(inst6_COUT), .O(inst7_O), .COUT(inst7_COUT));
FullAdder inst8 (.I0(I0[8]), .I1(I1[8]), .CIN(inst7_COUT), .O(inst8_O), .COUT(inst8_COUT));
FullAdder inst9 (.I0(I0[9]), .I1(I1[9]), .CIN(inst8_COUT), .O(inst9_O), .COUT(inst9_COUT));
FullAdder inst10 (.I0(I0[10]), .I1(I1[10]), .CIN(inst9_COUT), .O(inst10_O), .COUT(inst10_COUT));
FullAdder inst11 (.I0(I0[11]), .I1(I1[11]), .CIN(inst10_COUT), .O(inst11_O), .COUT(inst11_COUT));
FullAdder inst12 (.I0(I0[12]), .I1(I1[12]), .CIN(inst11_COUT), .O(inst12_O), .COUT(inst12_COUT));
FullAdder inst13 (.I0(I0[13]), .I1(I1[13]), .CIN(inst12_COUT), .O(inst13_O), .COUT(inst13_COUT));
FullAdder inst14 (.I0(I0[14]), .I1(I1[14]), .CIN(inst13_COUT), .O(inst14_O), .COUT(inst14_COUT));
FullAdder inst15 (.I0(I0[15]), .I1(I1[15]), .CIN(inst14_COUT), .O(inst15_O), .COUT(inst15_COUT));
assign O = {inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Mux2 (input [1:0] I, input  S, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst0 (.I0(I[0]), .I1(I[1]), .I2(S), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Register17CE (input [16:0] I, output [16:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
wire  inst8_Q;
wire  inst9_Q;
wire  inst10_Q;
wire  inst11_Q;
wire  inst12_Q;
wire  inst13_Q;
wire  inst14_Q;
wire  inst15_Q;
wire  inst16_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(I[5]), .Q(inst5_Q));
SB_DFFE inst6 (.C(CLK), .E(CE), .D(I[6]), .Q(inst6_Q));
SB_DFFE inst7 (.C(CLK), .E(CE), .D(I[7]), .Q(inst7_Q));
SB_DFFE inst8 (.C(CLK), .E(CE), .D(I[8]), .Q(inst8_Q));
SB_DFFE inst9 (.C(CLK), .E(CE), .D(I[9]), .Q(inst9_Q));
SB_DFFE inst10 (.C(CLK), .E(CE), .D(I[10]), .Q(inst10_Q));
SB_DFFE inst11 (.C(CLK), .E(CE), .D(I[11]), .Q(inst11_Q));
SB_DFFE inst12 (.C(CLK), .E(CE), .D(I[12]), .Q(inst12_Q));
SB_DFFE inst13 (.C(CLK), .E(CE), .D(I[13]), .Q(inst13_Q));
SB_DFFE inst14 (.C(CLK), .E(CE), .D(I[14]), .Q(inst14_Q));
SB_DFFE inst15 (.C(CLK), .E(CE), .D(I[15]), .Q(inst15_Q));
SB_DFFE inst16 (.C(CLK), .E(CE), .D(I[16]), .Q(inst16_Q));
assign O = {inst16_Q,inst15_Q,inst14_Q,inst13_Q,inst12_Q,inst11_Q,inst10_Q,inst9_Q,inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module PISO17CE (input  SI, input [16:0] PI, input  LOAD, output  O, input  CLK, input  CE);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
wire  inst8_O;
wire  inst9_O;
wire  inst10_O;
wire  inst11_O;
wire  inst12_O;
wire  inst13_O;
wire  inst14_O;
wire  inst15_O;
wire  inst16_O;
wire [16:0] inst17_O;
Mux2 inst0 (.I({PI[0],SI}), .S(LOAD), .O(inst0_O));
Mux2 inst1 (.I({PI[1],inst17_O[0]}), .S(LOAD), .O(inst1_O));
Mux2 inst2 (.I({PI[2],inst17_O[1]}), .S(LOAD), .O(inst2_O));
Mux2 inst3 (.I({PI[3],inst17_O[2]}), .S(LOAD), .O(inst3_O));
Mux2 inst4 (.I({PI[4],inst17_O[3]}), .S(LOAD), .O(inst4_O));
Mux2 inst5 (.I({PI[5],inst17_O[4]}), .S(LOAD), .O(inst5_O));
Mux2 inst6 (.I({PI[6],inst17_O[5]}), .S(LOAD), .O(inst6_O));
Mux2 inst7 (.I({PI[7],inst17_O[6]}), .S(LOAD), .O(inst7_O));
Mux2 inst8 (.I({PI[8],inst17_O[7]}), .S(LOAD), .O(inst8_O));
Mux2 inst9 (.I({PI[9],inst17_O[8]}), .S(LOAD), .O(inst9_O));
Mux2 inst10 (.I({PI[10],inst17_O[9]}), .S(LOAD), .O(inst10_O));
Mux2 inst11 (.I({PI[11],inst17_O[10]}), .S(LOAD), .O(inst11_O));
Mux2 inst12 (.I({PI[12],inst17_O[11]}), .S(LOAD), .O(inst12_O));
Mux2 inst13 (.I({PI[13],inst17_O[12]}), .S(LOAD), .O(inst13_O));
Mux2 inst14 (.I({PI[14],inst17_O[13]}), .S(LOAD), .O(inst14_O));
Mux2 inst15 (.I({PI[15],inst17_O[14]}), .S(LOAD), .O(inst15_O));
Mux2 inst16 (.I({PI[16],inst17_O[15]}), .S(LOAD), .O(inst16_O));
Register17CE inst17 (.I({inst16_O,inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O}), .O(inst17_O), .CLK(CLK), .CE(CE));
assign O = inst17_O[16];
endmodule

module UART16 (input  CLK, input  BAUD, input [15:0] DATA, input  LOAD, output  O);
wire  inst0_O;
PISO17CE inst0 (.SI(1'b1), .PI({1'b0,DATA[0],DATA[1],DATA[2],DATA[3],DATA[4],DATA[5],DATA[6],DATA[7],DATA[8],DATA[9],DATA[10],DATA[11],DATA[12],DATA[13],DATA[14],DATA[15]}), .LOAD(LOAD), .O(inst0_O), .CLK(CLK), .CE(BAUD));
assign O = inst0_O;
endmodule

module main (output [2:0] J3, input  CLKIN);
wire [7:0] inst0_O;
wire  inst0_COUT;
wire [4:0] inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire [15:0] inst3_O;
wire  inst3_V;
wire [15:0] inst4_O;
wire  inst5_O;
Counter8Mod103COUT inst0 (.O(inst0_O), .COUT(inst0_COUT), .CLK(CLKIN));
Counter5CE inst1 (.O(inst1_O), .COUT(inst1_COUT), .CLK(CLKIN), .CE(inst0_COUT));
Decode05 inst2 (.I(inst1_O), .O(inst2_O));
ReduceHybrid inst3 (.O(inst3_O), .WE(1'b1), .V(inst3_V), .CLK(inst2_O));
Add16 inst4 (.O(inst4_O));
UART16 inst5 (.CLK(CLKIN), .BAUD(inst0_COUT), .DATA(inst3_O), .LOAD(inst2_O), .O(inst5_O));
assign J3 = {inst5_O,inst2_O,inst3_V};
endmodule

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
