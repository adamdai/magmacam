module FullAdder (input  I0, input  I1, input  CIN, output  O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
SB_LUT4 #(.LUT_INIT(16'h9696)) inst0 (.I0(I0), .I1(I1), .I2(CIN), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0), .I1(I1), .CI(CIN), .CO(inst1_CO));
assign O = inst0_O;
assign COUT = inst1_CO;
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

module And2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'h8888)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Counter3Mod8COUTCE (output [2:0] O, output  COUT, input  CLK, input  CE);
wire [2:0] inst0_O;
wire  inst1_O;
wire  inst2_O;
Counter3CER inst0 (.O(inst0_O), .CLK(CLK), .CE(CE), .RESET(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst1 (.I0(inst0_O[0]), .I1(inst0_O[1]), .I2(inst0_O[2]), .I3(1'b0), .O(inst1_O));
And2 inst2 (.I({CE,inst1_O}), .O(inst2_O));
assign O = inst0_O;
assign COUT = inst2_O;
endmodule

module Or2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
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

module Register16R (input [15:0] I, output [15:0] O, input  CLK, input  RESET);
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
SB_DFFSR inst0 (.C(CLK), .R(RESET), .D(I[0]), .Q(inst0_Q));
SB_DFFSR inst1 (.C(CLK), .R(RESET), .D(I[1]), .Q(inst1_Q));
SB_DFFSR inst2 (.C(CLK), .R(RESET), .D(I[2]), .Q(inst2_Q));
SB_DFFSR inst3 (.C(CLK), .R(RESET), .D(I[3]), .Q(inst3_Q));
SB_DFFSR inst4 (.C(CLK), .R(RESET), .D(I[4]), .Q(inst4_Q));
SB_DFFSR inst5 (.C(CLK), .R(RESET), .D(I[5]), .Q(inst5_Q));
SB_DFFSR inst6 (.C(CLK), .R(RESET), .D(I[6]), .Q(inst6_Q));
SB_DFFSR inst7 (.C(CLK), .R(RESET), .D(I[7]), .Q(inst7_Q));
SB_DFFSR inst8 (.C(CLK), .R(RESET), .D(I[8]), .Q(inst8_Q));
SB_DFFSR inst9 (.C(CLK), .R(RESET), .D(I[9]), .Q(inst9_Q));
SB_DFFSR inst10 (.C(CLK), .R(RESET), .D(I[10]), .Q(inst10_Q));
SB_DFFSR inst11 (.C(CLK), .R(RESET), .D(I[11]), .Q(inst11_Q));
SB_DFFSR inst12 (.C(CLK), .R(RESET), .D(I[12]), .Q(inst12_Q));
SB_DFFSR inst13 (.C(CLK), .R(RESET), .D(I[13]), .Q(inst13_Q));
SB_DFFSR inst14 (.C(CLK), .R(RESET), .D(I[14]), .Q(inst14_Q));
SB_DFFSR inst15 (.C(CLK), .R(RESET), .D(I[15]), .Q(inst15_Q));
assign O = {inst15_Q,inst14_Q,inst13_Q,inst12_Q,inst11_Q,inst10_Q,inst9_Q,inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter16R (output [15:0] O, input  CLK, input  RESET);
wire [15:0] inst0_O;
wire [15:0] inst1_O;
Add16 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .O(inst0_O));
Register16R inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .RESET(RESET));
assign O = inst1_O;
endmodule

module EQ16 (input [15:0] I0, input [15:0] I1, output  O);
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
SB_LUT4 #(.LUT_INIT(16'h8282)) inst0 (.I0(1'b1), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst1 (.I0(inst0_O), .I1(I0[1]), .I2(I1[1]), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst2 (.I0(inst1_O), .I1(I0[2]), .I2(I1[2]), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst3 (.I0(inst2_O), .I1(I0[3]), .I2(I1[3]), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst4 (.I0(inst3_O), .I1(I0[4]), .I2(I1[4]), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst5 (.I0(inst4_O), .I1(I0[5]), .I2(I1[5]), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst6 (.I0(inst5_O), .I1(I0[6]), .I2(I1[6]), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst7 (.I0(inst6_O), .I1(I0[7]), .I2(I1[7]), .I3(1'b0), .O(inst7_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst8 (.I0(inst7_O), .I1(I0[8]), .I2(I1[8]), .I3(1'b0), .O(inst8_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst9 (.I0(inst8_O), .I1(I0[9]), .I2(I1[9]), .I3(1'b0), .O(inst9_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst10 (.I0(inst9_O), .I1(I0[10]), .I2(I1[10]), .I3(1'b0), .O(inst10_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst11 (.I0(inst10_O), .I1(I0[11]), .I2(I1[11]), .I3(1'b0), .O(inst11_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst12 (.I0(inst11_O), .I1(I0[12]), .I2(I1[12]), .I3(1'b0), .O(inst12_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst13 (.I0(inst12_O), .I1(I0[13]), .I2(I1[13]), .I3(1'b0), .O(inst13_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst14 (.I0(inst13_O), .I1(I0[14]), .I2(I1[14]), .I3(1'b0), .O(inst14_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst15 (.I0(inst14_O), .I1(I0[15]), .I2(I1[15]), .I3(1'b0), .O(inst15_O));
assign O = inst15_O;
endmodule

module Decode016 (input [15:0] I, output  O);
wire  inst0_O;
EQ16 inst0 (.I0(I), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .O(inst0_O));
assign O = inst0_O;
endmodule

module Counter16Mod1COUT (output [15:0] O, output  COUT, input  CLK);
wire [15:0] inst0_O;
wire  inst1_O;
Counter16R inst0 (.O(inst0_O), .CLK(CLK), .RESET(inst1_O));
Decode016 inst1 (.I(inst0_O), .O(inst1_O));
assign O = inst0_O;
assign COUT = inst1_O;
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

module main (output [7:0] J3, input  CLKIN);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [15:0] inst1_O;
wire [15:0] inst2_O;
wire [15:0] inst3_O;
wire [15:0] inst4_O;
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
wire [7:0] inst16_O;
wire  inst16_COUT;
wire [4:0] inst17_O;
wire  inst17_COUT;
wire  inst18_O;
wire [2:0] inst19_O;
wire  inst19_COUT;
wire  inst20_O;
wire  inst21_O;
wire  inst22_O;
wire  inst23_O;
wire  inst24_O;
wire  inst25_O;
wire [15:0] inst26_O;
wire [15:0] inst27_O;
wire  inst27_V;
wire  inst27_CLKOut;
wire [15:0] inst27_L00;
wire [15:0] inst27_L01;
wire [15:0] inst27_L10;
wire [15:0] inst27_L11;
wire [15:0] inst28_O;
wire  inst28_COUT;
wire  inst29_O;
wire  inst30_O;
wire  inst31_O;
wire  inst32_O;
wire  inst33_O;
wire  inst34_O;
wire  inst35_O;
Counter4CE inst0 (.O(inst0_O), .COUT(inst0_COUT), .CLK(CLKIN), .CE(inst25_O));
Mux2x16 inst1 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1}), .S(inst0_O[0]), .O(inst1_O));
Mux2x16 inst2 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1}), .S(inst0_O[0]), .O(inst2_O));
Mux2x16 inst3 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1}), .S(inst0_O[0]), .O(inst3_O));
Mux2x16 inst4 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1}), .S(inst0_O[0]), .O(inst4_O));
Mux2x16 inst5 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b1}), .S(inst0_O[0]), .O(inst5_O));
Mux2x16 inst6 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b1,1'b1}), .S(inst0_O[0]), .O(inst6_O));
Mux2x16 inst7 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b1}), .S(inst0_O[0]), .O(inst7_O));
Mux2x16 inst8 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1}), .S(inst0_O[0]), .O(inst8_O));
Mux2x16 inst9 (.I0(inst1_O), .I1(inst2_O), .S(inst0_O[1]), .O(inst9_O));
Mux2x16 inst10 (.I0(inst3_O), .I1(inst4_O), .S(inst0_O[1]), .O(inst10_O));
Mux2x16 inst11 (.I0(inst5_O), .I1(inst6_O), .S(inst0_O[1]), .O(inst11_O));
Mux2x16 inst12 (.I0(inst7_O), .I1(inst8_O), .S(inst0_O[1]), .O(inst12_O));
Mux2x16 inst13 (.I0(inst9_O), .I1(inst10_O), .S(inst0_O[2]), .O(inst13_O));
Mux2x16 inst14 (.I0(inst11_O), .I1(inst12_O), .S(inst0_O[2]), .O(inst14_O));
Mux2x16 inst15 (.I0(inst13_O), .I1(inst14_O), .S(inst0_O[3]), .O(inst15_O));
Counter8Mod103COUT inst16 (.O(inst16_O), .COUT(inst16_COUT), .CLK(CLKIN));
Counter5CE inst17 (.O(inst17_O), .COUT(inst17_COUT), .CLK(CLKIN), .CE(inst16_COUT));
Decode05 inst18 (.I(inst17_O), .O(inst18_O));
Counter3Mod8COUTCE inst19 (.O(inst19_O), .COUT(inst19_COUT), .CLK(CLKIN), .CE(inst20_O));
And2 inst20 (.I({inst16_COUT,inst18_O}), .O(inst20_O));
SB_LUT4 #(.LUT_INIT(16'h0020)) inst21 (.I0(inst19_O[0]), .I1(inst19_O[1]), .I2(inst19_O[2]), .I3(1'b0), .O(inst21_O));
Or2 inst22 (.I({inst21_O,1'b0}), .O(inst22_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst23 (.I0(inst19_O[0]), .I1(inst19_O[1]), .I2(inst19_O[2]), .I3(1'b0), .O(inst23_O));
Or2 inst24 (.I({inst23_O,inst22_O}), .O(inst24_O));
And2 inst25 (.I({inst16_COUT,inst18_O}), .O(inst25_O));
Register16CE inst26 (.I(inst15_O), .O(inst26_O), .CLK(CLKIN), .CE(inst18_O));
STEN inst27 (.I_0_0({{inst26_O}}), .O(inst27_O), .WE(1'b1), .V(inst27_V), .CLK(inst18_O), .CLKOut(inst27_CLKOut), .L00(inst27_L00), .L01(inst27_L01), .L10(inst27_L10), .L11(inst27_L11));
Counter16Mod1COUT inst28 (.O(inst28_O), .COUT(inst28_COUT), .CLK(CLKIN));
UART16 inst29 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst15_O), .LOAD(inst18_O), .O(inst29_O));
UART16 inst30 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst27_O), .LOAD(inst18_O), .O(inst30_O));
UART16 inst31 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst27_L00), .LOAD(inst18_O), .O(inst31_O));
UART16 inst32 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst27_L01), .LOAD(inst18_O), .O(inst32_O));
UART16 inst33 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst27_L10), .LOAD(inst18_O), .O(inst33_O));
UART16 inst34 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst27_L11), .LOAD(inst18_O), .O(inst34_O));
UART16 inst35 (.CLK(CLKIN), .BAUD(inst16_COUT), .DATA(inst26_O), .LOAD(inst18_O), .O(inst35_O));
assign J3 = {inst34_O,inst33_O,inst32_O,inst31_O,inst30_O,inst29_O,inst18_O,inst24_O};
endmodule

