module FullAdder (input  I0, input  I1, input  CIN, output  O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
SB_LUT4 #(.LUT_INIT(16'h9696)) inst0 (.I0(I0), .I1(I1), .I2(CIN), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0), .I1(I1), .CI(CIN), .CO(inst1_CO));
assign O = inst0_O;
assign COUT = inst1_CO;
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

module Register5 (input [4:0] I, output [4:0] O, input  CLK);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
SB_DFF inst0 (.C(CLK), .D(I[0]), .Q(inst0_Q));
SB_DFF inst1 (.C(CLK), .D(I[1]), .Q(inst1_Q));
SB_DFF inst2 (.C(CLK), .D(I[2]), .Q(inst2_Q));
SB_DFF inst3 (.C(CLK), .D(I[3]), .Q(inst3_Q));
SB_DFF inst4 (.C(CLK), .D(I[4]), .Q(inst4_Q));
assign O = {inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter5 (output [4:0] O, output  COUT, input  CLK);
wire [4:0] inst0_O;
wire  inst0_COUT;
wire [4:0] inst1_O;
Add5Cout inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register5 inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Add4Cout (input [3:0] I0, input [3:0] I1, output [3:0] O, output  COUT);
wire  inst0_O;
wire  inst0_COUT;
wire  inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(1'b0), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
assign O = {inst3_O,inst2_O,inst1_O,inst0_O};
assign COUT = inst3_COUT;
endmodule

module Register4CE (input [3:0] I, output [3:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
assign O = {inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter4CE (output [3:0] O, output  COUT, input  CLK, input  CE);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [3:0] inst1_O;
Add4Cout inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register4CE inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE));
assign O = inst1_O;
assign COUT = inst0_COUT;
endmodule

module Mux2 (input [1:0] I, input  S, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'hCACA)) inst0 (.I0(I[0]), .I1(I[1]), .I2(S), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Mux2x16 (input [15:0] I0, input [15:0] I1, input  S, output [15:0] O);
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
Mux2 inst0 (.I({I1[0],I0[0]}), .S(S), .O(inst0_O));
Mux2 inst1 (.I({I1[1],I0[1]}), .S(S), .O(inst1_O));
Mux2 inst2 (.I({I1[2],I0[2]}), .S(S), .O(inst2_O));
Mux2 inst3 (.I({I1[3],I0[3]}), .S(S), .O(inst3_O));
Mux2 inst4 (.I({I1[4],I0[4]}), .S(S), .O(inst4_O));
Mux2 inst5 (.I({I1[5],I0[5]}), .S(S), .O(inst5_O));
Mux2 inst6 (.I({I1[6],I0[6]}), .S(S), .O(inst6_O));
Mux2 inst7 (.I({I1[7],I0[7]}), .S(S), .O(inst7_O));
Mux2 inst8 (.I({I1[8],I0[8]}), .S(S), .O(inst8_O));
Mux2 inst9 (.I({I1[9],I0[9]}), .S(S), .O(inst9_O));
Mux2 inst10 (.I({I1[10],I0[10]}), .S(S), .O(inst10_O));
Mux2 inst11 (.I({I1[11],I0[11]}), .S(S), .O(inst11_O));
Mux2 inst12 (.I({I1[12],I0[12]}), .S(S), .O(inst12_O));
Mux2 inst13 (.I({I1[13],I0[13]}), .S(S), .O(inst13_O));
Mux2 inst14 (.I({I1[14],I0[14]}), .S(S), .O(inst14_O));
Mux2 inst15 (.I({I1[15],I0[15]}), .S(S), .O(inst15_O));
assign O = {inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Register5CER (input [4:0] I, output [4:0] O, input  CLK, input  CE, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
SB_DFFESR inst0 (.C(CLK), .R(RESET), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFESR inst1 (.C(CLK), .R(RESET), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFESR inst2 (.C(CLK), .R(RESET), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFESR inst3 (.C(CLK), .R(RESET), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFESR inst4 (.C(CLK), .R(RESET), .E(CE), .D(I[4]), .Q(inst4_Q));
assign O = {inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter5CER (output [4:0] O, output  COUT, input  CLK, input  CE, input  RESET);
wire [4:0] inst0_O;
wire  inst0_COUT;
wire [4:0] inst1_O;
Add5Cout inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register5CER inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE), .RESET(RESET));
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

module Decode165 (input [4:0] I, output  O);
wire  inst0_O;
EQ5 inst0 (.I0(I), .I1({1'b1,1'b0,1'b0,1'b0,1'b0}), .O(inst0_O));
assign O = inst0_O;
endmodule

module Invert4 (input [3:0] I, output [3:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
SB_LUT4 #(.LUT_INIT(16'h5555)) inst0 (.I0(I[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(I[1]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst2 (.I0(I[2]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst3 (.I0(I[3]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst3_O));
assign O = {inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Add4CinCout (input [3:0] I0, input [3:0] I1, input  CIN, output [3:0] O, output  COUT);
wire  inst0_O;
wire  inst0_COUT;
wire  inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(CIN), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
assign O = {inst3_O,inst2_O,inst1_O,inst0_O};
assign COUT = inst3_COUT;
endmodule

module Sub4Cout (input [3:0] I0, input [3:0] I1, output [3:0] O, output  COUT);
wire [3:0] inst0_O;
wire [3:0] inst1_O;
wire  inst1_COUT;
Invert4 inst0 (.I(I1), .O(inst0_O));
Add4CinCout inst1 (.I0(I0), .I1(inst0_O), .CIN(1'b1), .O(inst1_O), .COUT(inst1_COUT));
assign O = inst1_O;
assign COUT = inst1_COUT;
endmodule

module ULE4 (input [3:0] I0, input [3:0] I1, output  O);
wire [3:0] inst0_O;
wire  inst0_COUT;
Sub4Cout inst0 (.I0(I1), .I1(I0), .O(inst0_O), .COUT(inst0_COUT));
assign O = inst0_COUT;
endmodule

module UGE4 (input [3:0] I0, input [3:0] I1, output  O);
wire [3:0] inst0_O;
wire  inst0_COUT;
Sub4Cout inst0 (.I0(I0), .I1(I1), .O(inst0_O), .COUT(inst0_COUT));
assign O = inst0_COUT;
endmodule

module Register16CE (input [15:0] I, output [15:0] O, input  CLK, input  CE);
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
assign O = {inst15_Q,inst14_Q,inst13_Q,inst12_Q,inst11_Q,inst10_Q,inst9_Q,inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module PISO16CE (input  SI, input [15:0] PI, input  LOAD, output  O, input  CLK, input  CE);
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
wire [15:0] inst16_O;
Mux2 inst0 (.I({PI[0],SI}), .S(LOAD), .O(inst0_O));
Mux2 inst1 (.I({PI[1],inst16_O[0]}), .S(LOAD), .O(inst1_O));
Mux2 inst2 (.I({PI[2],inst16_O[1]}), .S(LOAD), .O(inst2_O));
Mux2 inst3 (.I({PI[3],inst16_O[2]}), .S(LOAD), .O(inst3_O));
Mux2 inst4 (.I({PI[4],inst16_O[3]}), .S(LOAD), .O(inst4_O));
Mux2 inst5 (.I({PI[5],inst16_O[4]}), .S(LOAD), .O(inst5_O));
Mux2 inst6 (.I({PI[6],inst16_O[5]}), .S(LOAD), .O(inst6_O));
Mux2 inst7 (.I({PI[7],inst16_O[6]}), .S(LOAD), .O(inst7_O));
Mux2 inst8 (.I({PI[8],inst16_O[7]}), .S(LOAD), .O(inst8_O));
Mux2 inst9 (.I({PI[9],inst16_O[8]}), .S(LOAD), .O(inst9_O));
Mux2 inst10 (.I({PI[10],inst16_O[9]}), .S(LOAD), .O(inst10_O));
Mux2 inst11 (.I({PI[11],inst16_O[10]}), .S(LOAD), .O(inst11_O));
Mux2 inst12 (.I({PI[12],inst16_O[11]}), .S(LOAD), .O(inst12_O));
Mux2 inst13 (.I({PI[13],inst16_O[12]}), .S(LOAD), .O(inst13_O));
Mux2 inst14 (.I({PI[14],inst16_O[13]}), .S(LOAD), .O(inst14_O));
Mux2 inst15 (.I({PI[15],inst16_O[14]}), .S(LOAD), .O(inst15_O));
Register16CE inst16 (.I({inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O}), .O(inst16_O), .CLK(CLK), .CE(CE));
assign O = inst16_O[15];
endmodule

module SIPO8CE (input  I, output [7:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(inst0_Q), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(inst1_Q), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(inst2_Q), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(inst3_Q), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(inst4_Q), .Q(inst5_Q));
SB_DFFE inst6 (.C(CLK), .E(CE), .D(inst5_Q), .Q(inst6_Q));
SB_DFFE inst7 (.C(CLK), .E(CE), .D(inst6_Q), .Q(inst7_Q));
assign O = {inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
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

module And2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'h8888)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Or2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Add3 (input [2:0] I0, input [2:0] I1, output [2:0] O);
wire  inst0_O;
wire  inst0_COUT;
wire  inst1_O;
wire  inst1_COUT;
wire  inst2_O;
wire  inst2_COUT;
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(1'b0), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
assign O = {inst2_O,inst1_O,inst0_O};
endmodule

module Register3CER (input [2:0] I, output [2:0] O, input  CLK, input  CE, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
SB_DFFESR inst0 (.C(CLK), .R(RESET), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFESR inst1 (.C(CLK), .R(RESET), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFESR inst2 (.C(CLK), .R(RESET), .E(CE), .D(I[2]), .Q(inst2_Q));
assign O = {inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter3CER (output [2:0] O, input  CLK, input  CE, input  RESET);
wire [2:0] inst0_O;
wire [2:0] inst1_O;
Add3 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b1}), .O(inst0_O));
Register3CER inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .CE(CE), .RESET(RESET));
assign O = inst1_O;
endmodule

module Counter3Mod8COUTCER (output [2:0] O, output  COUT, input  CLK, input  CE, input  RESET);
wire [2:0] inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
Counter3CER inst0 (.O(inst0_O), .CLK(CLK), .CE(CE), .RESET(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst1 (.I0(inst0_O[0]), .I1(inst0_O[1]), .I2(inst0_O[2]), .I3(1'b0), .O(inst1_O));
Or2 inst2 (.I({RESET,inst1_O}), .O(inst2_O));
And2 inst3 (.I({CE,inst2_O}), .O(inst3_O));
assign O = inst0_O;
assign COUT = inst3_O;
endmodule

module Register9CE (input [8:0] I, output [8:0] O, input  CLK, input  CE);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
wire  inst8_Q;
SB_DFFE inst0 (.C(CLK), .E(CE), .D(I[0]), .Q(inst0_Q));
SB_DFFE inst1 (.C(CLK), .E(CE), .D(I[1]), .Q(inst1_Q));
SB_DFFE inst2 (.C(CLK), .E(CE), .D(I[2]), .Q(inst2_Q));
SB_DFFE inst3 (.C(CLK), .E(CE), .D(I[3]), .Q(inst3_Q));
SB_DFFE inst4 (.C(CLK), .E(CE), .D(I[4]), .Q(inst4_Q));
SB_DFFE inst5 (.C(CLK), .E(CE), .D(I[5]), .Q(inst5_Q));
SB_DFFE inst6 (.C(CLK), .E(CE), .D(I[6]), .Q(inst6_Q));
SB_DFFE inst7 (.C(CLK), .E(CE), .D(I[7]), .Q(inst7_Q));
SB_DFFE inst8 (.C(CLK), .E(CE), .D(I[8]), .Q(inst8_Q));
assign O = {inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module PISO9CE (input  SI, input [8:0] PI, input  LOAD, output  O, input  CLK, input  CE);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
wire  inst8_O;
wire [8:0] inst9_O;
Mux2 inst0 (.I({PI[0],SI}), .S(LOAD), .O(inst0_O));
Mux2 inst1 (.I({PI[1],inst9_O[0]}), .S(LOAD), .O(inst1_O));
Mux2 inst2 (.I({PI[2],inst9_O[1]}), .S(LOAD), .O(inst2_O));
Mux2 inst3 (.I({PI[3],inst9_O[2]}), .S(LOAD), .O(inst3_O));
Mux2 inst4 (.I({PI[4],inst9_O[3]}), .S(LOAD), .O(inst4_O));
Mux2 inst5 (.I({PI[5],inst9_O[4]}), .S(LOAD), .O(inst5_O));
Mux2 inst6 (.I({PI[6],inst9_O[5]}), .S(LOAD), .O(inst6_O));
Mux2 inst7 (.I({PI[7],inst9_O[6]}), .S(LOAD), .O(inst7_O));
Mux2 inst8 (.I({PI[8],inst9_O[7]}), .S(LOAD), .O(inst8_O));
Register9CE inst9 (.I({inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O}), .O(inst9_O), .CLK(CLK), .CE(CE));
assign O = inst9_O[8];
endmodule

module ArduCAM (input  CLK, input  SCK, input  MISO, output  EN, output  MOSI, output [7:0] DATA, output  UART);
wire  inst0_Q;
wire  inst1_O;
wire  inst2_Q;
wire  inst3_O;
wire [3:0] inst4_O;
wire  inst4_COUT;
wire [15:0] inst5_O;
wire [15:0] inst6_O;
wire [15:0] inst7_O;
wire [15:0] inst8_O;
wire [15:0] inst9_O;
wire [15:0] inst10_O;
wire [15:0] inst11_O;
wire [15:0] inst12_O;
wire [15:0] inst13_O;
wire [15:0] inst14_O;
wire [15:0] inst15_O;
wire [15:0] inst16_O;
wire [15:0] inst17_O;
wire [15:0] inst18_O;
wire [15:0] inst19_O;
wire [4:0] inst20_O;
wire  inst20_COUT;
wire  inst21_O;
wire  inst22_Q;
wire  inst23_O;
wire  inst24_O;
wire  inst25_O;
wire  inst26_O;
wire  inst27_O;
wire  inst28_O;
wire  inst29_O;
wire  inst30_O;
wire [7:0] inst31_O;
wire  inst32_O;
wire  inst33_Q;
wire  inst34_O;
wire  inst35_O;
wire  inst36_O;
wire  inst37_O;
wire  inst38_O;
wire  inst39_Q;
wire  inst40_O;
wire [2:0] inst41_O;
wire  inst41_COUT;
wire  inst42_Q;
wire  inst43_O;
wire  inst44_O;
wire  inst45_O;
SB_DFF inst0 (.C(CLK), .D(SCK), .Q(inst0_Q));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst1 (.I0(SCK), .I1(inst0_Q), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_DFF inst2 (.C(CLK), .D(SCK), .Q(inst2_Q));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst3 (.I0(SCK), .I1(inst2_Q), .I2(1'b0), .I3(1'b0), .O(inst3_O));
Counter4CE inst4 (.O(inst4_O), .COUT(inst4_COUT), .CLK(CLK), .CE(inst37_O));
Mux2x16 inst5 (.I0({1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .S(inst4_O[0]), .O(inst5_O));
Mux2x16 inst6 (.I0({1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .I1({1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0}), .S(inst4_O[0]), .O(inst6_O));
Mux2x16 inst7 (.I0({1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst4_O[0]), .O(inst7_O));
Mux2x16 inst8 (.I0({1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b1,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst4_O[0]), .O(inst8_O));
Mux2x16 inst9 (.I0({1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst4_O[0]), .O(inst9_O));
Mux2x16 inst10 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst4_O[0]), .O(inst10_O));
Mux2x16 inst11 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst4_O[0]), .O(inst11_O));
Mux2x16 inst12 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst4_O[0]), .O(inst12_O));
Mux2x16 inst13 (.I0(inst5_O), .I1(inst6_O), .S(inst4_O[1]), .O(inst13_O));
Mux2x16 inst14 (.I0(inst7_O), .I1(inst8_O), .S(inst4_O[1]), .O(inst14_O));
Mux2x16 inst15 (.I0(inst9_O), .I1(inst10_O), .S(inst4_O[1]), .O(inst15_O));
Mux2x16 inst16 (.I0(inst11_O), .I1(inst12_O), .S(inst4_O[1]), .O(inst16_O));
Mux2x16 inst17 (.I0(inst13_O), .I1(inst14_O), .S(inst4_O[2]), .O(inst17_O));
Mux2x16 inst18 (.I0(inst15_O), .I1(inst16_O), .S(inst4_O[2]), .O(inst18_O));
Mux2x16 inst19 (.I0(inst17_O), .I1(inst18_O), .S(inst4_O[3]), .O(inst19_O));
Counter5CER inst20 (.O(inst20_O), .COUT(inst20_COUT), .CLK(CLK), .CE(inst3_O), .RESET(inst24_O));
Decode165 inst21 (.I(inst20_O), .O(inst21_O));
SB_DFFE inst22 (.C(CLK), .E(inst1_O), .D(inst23_O), .Q(inst22_Q));
SB_LUT4 #(.LUT_INIT(16'h0054)) inst23 (.I0(inst21_O), .I1(1'b1), .I2(inst22_Q), .I3(1'b0), .O(inst23_O));
SB_LUT4 #(.LUT_INIT(16'hBBBB)) inst24 (.I0(inst21_O), .I1(inst22_Q), .I2(1'b0), .I3(1'b0), .O(inst24_O));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst25 (.I0(inst22_Q), .I1(inst1_O), .I2(1'b0), .I3(1'b0), .O(inst25_O));
ULE4 inst26 (.I0(inst4_O), .I1({1'b0,1'b0,1'b1,1'b1}), .O(inst26_O));
UGE4 inst27 (.I0(inst4_O), .I1({1'b1,1'b0,1'b0,1'b1}), .O(inst27_O));
PISO16CE inst28 (.SI(inst30_O), .PI(inst19_O), .LOAD(inst29_O), .O(inst28_O), .CLK(CLK), .CE(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h0202)) inst29 (.I0(1'b1), .I1(inst22_Q), .I2(inst27_O), .I3(1'b0), .O(inst29_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst30 (.I0(inst27_O), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst30_O));
SIPO8CE inst31 (.I(MISO), .O(inst31_O), .CLK(CLK), .CE(inst32_O));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst32 (.I0(inst29_O), .I1(inst3_O), .I2(1'b0), .I3(1'b0), .O(inst32_O));
SB_DFFE inst33 (.C(CLK), .E(inst36_O), .D(inst34_O), .Q(inst33_Q));
SB_LUT4 #(.LUT_INIT(16'h0E0E)) inst34 (.I0(inst33_Q), .I1(inst35_O), .I2(1'b0), .I3(1'b0), .O(inst34_O));
EQ8 inst35 (.I0(inst31_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0}), .O(inst35_O));
And2 inst36 (.I({inst3_O,inst29_O}), .O(inst36_O));
SB_LUT4 #(.LUT_INIT(16'h00A8)) inst37 (.I0(inst25_O), .I1(inst26_O), .I2(inst33_Q), .I3(inst27_O), .O(inst37_O));
Or2 inst38 (.I({inst1_O,inst3_O}), .O(inst38_O));
SB_DFFE inst39 (.C(CLK), .E(inst3_O), .D(inst27_O), .Q(inst39_Q));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst40 (.I0(inst27_O), .I1(inst39_Q), .I2(1'b0), .I3(1'b0), .O(inst40_O));
Counter3Mod8COUTCER inst41 (.O(inst41_O), .COUT(inst41_COUT), .CLK(CLK), .CE(inst3_O), .RESET(inst40_O));
SB_DFF inst42 (.C(CLK), .D(inst41_COUT), .Q(inst42_Q));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst43 (.I0(inst41_COUT), .I1(inst42_Q), .I2(1'b0), .I3(1'b0), .O(inst43_O));
And2 inst44 (.I({inst43_O,inst27_O}), .O(inst44_O));
PISO9CE inst45 (.SI(1'b1), .PI({1'b0,inst31_O[0],inst31_O[1],inst31_O[2],inst31_O[3],inst31_O[4],inst31_O[5],inst31_O[6],inst31_O[7]}), .LOAD(inst44_O), .O(inst45_O), .CLK(CLK), .CE(inst38_O));
assign EN = inst29_O;
assign MOSI = inst28_O;
assign DATA = inst31_O;
assign UART = inst45_O;
endmodule

module main (input  J1, output  D1, output [3:0] J3, input  CLKIN);
wire [4:0] inst0_O;
wire  inst0_COUT;
wire  inst1_EN;
wire  inst1_MOSI;
wire [7:0] inst1_DATA;
wire  inst1_UART;
Counter5 inst0 (.O(inst0_O), .COUT(inst0_COUT), .CLK(CLKIN));
ArduCAM inst1 (.CLK(CLKIN), .SCK(inst0_O[4]), .MISO(J1), .EN(inst1_EN), .MOSI(inst1_MOSI), .DATA(inst1_DATA), .UART(inst1_UART));
assign J3 = {inst1_UART,inst1_MOSI,inst1_EN,inst0_O[4]};
endmodule

