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

module Register4 (input [3:0] I, output [3:0] O, input  CLK);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
SB_DFF inst0 (.C(CLK), .D(I[0]), .Q(inst0_Q));
SB_DFF inst1 (.C(CLK), .D(I[1]), .Q(inst1_Q));
SB_DFF inst2 (.C(CLK), .D(I[2]), .Q(inst2_Q));
SB_DFF inst3 (.C(CLK), .D(I[3]), .Q(inst3_Q));
assign O = {inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Counter4 (output [3:0] O, output  COUT, input  CLK);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [3:0] inst1_O;
Add4Cout inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b1}), .O(inst0_O), .COUT(inst0_COUT));
Register4 inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK));
assign O = inst1_O;
assign COUT = inst0_COUT;
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

module EQ4 (input [3:0] I0, input [3:0] I1, output  O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
SB_LUT4 #(.LUT_INIT(16'h8282)) inst0 (.I0(1'b1), .I1(I0[0]), .I2(I1[0]), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst1 (.I0(inst0_O), .I1(I0[1]), .I2(I1[1]), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst2 (.I0(inst1_O), .I1(I0[2]), .I2(I1[2]), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h8282)) inst3 (.I0(inst2_O), .I1(I0[3]), .I2(I1[3]), .I3(1'b0), .O(inst3_O));
assign O = inst3_O;
endmodule

module And2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'h8888)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
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

module Decoder4 (input [3:0] I, output [15:0] O);
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
SB_LUT4 #(.LUT_INIT(16'h0001)) inst0 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h0002)) inst1 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h0004)) inst2 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h0008)) inst3 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h0010)) inst4 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h0020)) inst5 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'h0040)) inst6 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h0080)) inst7 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst7_O));
SB_LUT4 #(.LUT_INIT(16'h0100)) inst8 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst8_O));
SB_LUT4 #(.LUT_INIT(16'h0200)) inst9 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst9_O));
SB_LUT4 #(.LUT_INIT(16'h0400)) inst10 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst10_O));
SB_LUT4 #(.LUT_INIT(16'h0800)) inst11 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst11_O));
SB_LUT4 #(.LUT_INIT(16'h1000)) inst12 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst12_O));
SB_LUT4 #(.LUT_INIT(16'h2000)) inst13 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst13_O));
SB_LUT4 #(.LUT_INIT(16'h4000)) inst14 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst14_O));
SB_LUT4 #(.LUT_INIT(16'h8000)) inst15 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst15_O));
assign O = {inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module And2x16 (input [15:0] I0, input [15:0] I1, output [15:0] O);
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
And2 inst0 (.I({I1[0],I0[0]}), .O(inst0_O));
And2 inst1 (.I({I1[1],I0[1]}), .O(inst1_O));
And2 inst2 (.I({I1[2],I0[2]}), .O(inst2_O));
And2 inst3 (.I({I1[3],I0[3]}), .O(inst3_O));
And2 inst4 (.I({I1[4],I0[4]}), .O(inst4_O));
And2 inst5 (.I({I1[5],I0[5]}), .O(inst5_O));
And2 inst6 (.I({I1[6],I0[6]}), .O(inst6_O));
And2 inst7 (.I({I1[7],I0[7]}), .O(inst7_O));
And2 inst8 (.I({I1[8],I0[8]}), .O(inst8_O));
And2 inst9 (.I({I1[9],I0[9]}), .O(inst9_O));
And2 inst10 (.I({I1[10],I0[10]}), .O(inst10_O));
And2 inst11 (.I({I1[11],I0[11]}), .O(inst11_O));
And2 inst12 (.I({I1[12],I0[12]}), .O(inst12_O));
And2 inst13 (.I({I1[13],I0[13]}), .O(inst13_O));
And2 inst14 (.I({I1[14],I0[14]}), .O(inst14_O));
And2 inst15 (.I({I1[15],I0[15]}), .O(inst15_O));
assign O = {inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module RAM16x16 (input [3:0] RADDR, output [15:0] RDATA, input [3:0] WADDR, input [15:0] WDATA, input  WE, input  CLK);
wire [15:0] inst0_O;
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
wire [15:0] inst16_O;
wire [15:0] inst17_O;
wire [15:0] inst18_O;
wire [15:0] inst19_O;
wire [15:0] inst20_O;
wire [15:0] inst21_O;
wire [15:0] inst22_O;
wire [15:0] inst23_O;
wire [15:0] inst24_O;
wire [15:0] inst25_O;
wire [15:0] inst26_O;
wire [15:0] inst27_O;
wire [15:0] inst28_O;
wire [15:0] inst29_O;
wire [15:0] inst30_O;
wire [15:0] inst31_O;
wire [15:0] inst32_O;
Register16CE inst0 (.I(WDATA), .O(inst0_O), .CLK(CLK), .CE(inst17_O[0]));
Register16CE inst1 (.I(WDATA), .O(inst1_O), .CLK(CLK), .CE(inst17_O[1]));
Register16CE inst2 (.I(WDATA), .O(inst2_O), .CLK(CLK), .CE(inst17_O[2]));
Register16CE inst3 (.I(WDATA), .O(inst3_O), .CLK(CLK), .CE(inst17_O[3]));
Register16CE inst4 (.I(WDATA), .O(inst4_O), .CLK(CLK), .CE(inst17_O[4]));
Register16CE inst5 (.I(WDATA), .O(inst5_O), .CLK(CLK), .CE(inst17_O[5]));
Register16CE inst6 (.I(WDATA), .O(inst6_O), .CLK(CLK), .CE(inst17_O[6]));
Register16CE inst7 (.I(WDATA), .O(inst7_O), .CLK(CLK), .CE(inst17_O[7]));
Register16CE inst8 (.I(WDATA), .O(inst8_O), .CLK(CLK), .CE(inst17_O[8]));
Register16CE inst9 (.I(WDATA), .O(inst9_O), .CLK(CLK), .CE(inst17_O[9]));
Register16CE inst10 (.I(WDATA), .O(inst10_O), .CLK(CLK), .CE(inst17_O[10]));
Register16CE inst11 (.I(WDATA), .O(inst11_O), .CLK(CLK), .CE(inst17_O[11]));
Register16CE inst12 (.I(WDATA), .O(inst12_O), .CLK(CLK), .CE(inst17_O[12]));
Register16CE inst13 (.I(WDATA), .O(inst13_O), .CLK(CLK), .CE(inst17_O[13]));
Register16CE inst14 (.I(WDATA), .O(inst14_O), .CLK(CLK), .CE(inst17_O[14]));
Register16CE inst15 (.I(WDATA), .O(inst15_O), .CLK(CLK), .CE(inst17_O[15]));
Decoder4 inst16 (.I(WADDR), .O(inst16_O));
And2x16 inst17 (.I0(inst16_O), .I1({WE,WE,WE,WE,WE,WE,WE,WE,WE,WE,WE,WE,WE,WE,WE,WE}), .O(inst17_O));
Mux2x16 inst18 (.I0(inst0_O), .I1(inst1_O), .S(RADDR[0]), .O(inst18_O));
Mux2x16 inst19 (.I0(inst2_O), .I1(inst3_O), .S(RADDR[0]), .O(inst19_O));
Mux2x16 inst20 (.I0(inst4_O), .I1(inst5_O), .S(RADDR[0]), .O(inst20_O));
Mux2x16 inst21 (.I0(inst6_O), .I1(inst7_O), .S(RADDR[0]), .O(inst21_O));
Mux2x16 inst22 (.I0(inst8_O), .I1(inst9_O), .S(RADDR[0]), .O(inst22_O));
Mux2x16 inst23 (.I0(inst10_O), .I1(inst11_O), .S(RADDR[0]), .O(inst23_O));
Mux2x16 inst24 (.I0(inst12_O), .I1(inst13_O), .S(RADDR[0]), .O(inst24_O));
Mux2x16 inst25 (.I0(inst14_O), .I1(inst15_O), .S(RADDR[0]), .O(inst25_O));
Mux2x16 inst26 (.I0(inst18_O), .I1(inst19_O), .S(RADDR[1]), .O(inst26_O));
Mux2x16 inst27 (.I0(inst20_O), .I1(inst21_O), .S(RADDR[1]), .O(inst27_O));
Mux2x16 inst28 (.I0(inst22_O), .I1(inst23_O), .S(RADDR[1]), .O(inst28_O));
Mux2x16 inst29 (.I0(inst24_O), .I1(inst25_O), .S(RADDR[1]), .O(inst29_O));
Mux2x16 inst30 (.I0(inst26_O), .I1(inst27_O), .S(RADDR[2]), .O(inst30_O));
Mux2x16 inst31 (.I0(inst28_O), .I1(inst29_O), .S(RADDR[2]), .O(inst31_O));
Mux2x16 inst32 (.I0(inst30_O), .I1(inst31_O), .S(RADDR[3]), .O(inst32_O));
assign RDATA = inst32_O;
endmodule

module MEM (input [3:0] IDX, input [3:0] CYCLE, input  CLK, input [15:0] DATA, input [3:0] WADDR, input  WE, output [15:0] WEIGHT, output [15:0] IMAGE);
wire [15:0] inst0_RDATA;
wire [15:0] inst1_RDATA;
SB_RAM40_4K #(.INIT_0(256'h770FEA140D861B00EE5A1436641B341CDE0A1E1941DD26F2D0F019CD2C8162CB),
.INIT_1(256'h7F6E3828E003D002C304E101C1800103410340C04081C0004033714FD394F3A1),
.INIT_2(256'hA1A4EA02782F2E375F2EB7FF3D0041A060020020C030DD5A9B405FE65882981C),
.INIT_3(256'h23221E648C89FD715050F05A0015C162A3D7A0D3C0F6D1284FE28C06BFA43405),
.INIT_4(256'h8BBFD00A5037C016C001694624621E642E7ACE614415302D5009E815E31101CE),
.INIT_5(256'h082B0C7E49815B6D5113A03D8001A61389838E00030F023A4C0FBC5CD2A3B423),
.INIT_6(256'h5DFAA00E8007418247F80F7E4438C0A7CD7DAA0081018001900601DAECFE0BF1),
.INIT_7(256'h83B27EB7B81B6003010340C1A06280013073ED6947FA0C4220035001CB7321BE),
.INIT_8(256'h78187831E7B511D60E0065414280C3C603D895734D1D871DA371428936D951CD),
.INIT_9(256'h781DA8F9A0348009800380C12441AEE39EF3DE704503814390430806318B2A66),
.INIT_A(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_B(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_C(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_D(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_E(256'h0000000000000000000000000000000000000000000000000000000000000000),
.INIT_F(256'h0000000000000000000000000000000000000000000000000000000000000000),
.READ_MODE(0),
.WRITE_MODE(0)) inst0 (.RDATA(inst0_RDATA), .RADDR({1'b0,1'b0,1'b0,IDX[3],IDX[2],IDX[1],IDX[0],CYCLE[3],CYCLE[2],CYCLE[1],CYCLE[0]}), .RCLK(CLK), .RCLKE(1'b1), .RE(1'b1), .WCLK(CLK), .WCLKE(1'b0), .WE(1'b0), .WADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .MASK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .WDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
RAM16x16 inst1 (.RADDR(CYCLE), .RDATA(inst1_RDATA), .WADDR(WADDR), .WDATA(DATA), .WE(WE), .CLK(CLK));
assign WEIGHT = inst0_RDATA;
assign IMAGE = inst1_RDATA;
endmodule

module Add4 (input [3:0] I0, input [3:0] I1, output [3:0] O);
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
endmodule

module Register4R (input [3:0] I, output [3:0] O, input  CLK, input  RESET);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
SB_DFFSR inst0 (.C(CLK), .R(RESET), .D(I[0]), .Q(inst0_Q));
SB_DFFSR inst1 (.C(CLK), .R(RESET), .D(I[1]), .Q(inst1_Q));
SB_DFFSR inst2 (.C(CLK), .R(RESET), .D(I[2]), .Q(inst2_Q));
SB_DFFSR inst3 (.C(CLK), .R(RESET), .D(I[3]), .Q(inst3_Q));
assign O = {inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module NAnd2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'h7777)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Controller (input  CLK, output [3:0] IDX, output [3:0] CYCLE);
wire [3:0] inst0_O;
wire [3:0] inst1_O;
wire [3:0] inst2_O;
wire [3:0] inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
Add4 inst0 (.I0(inst1_O), .I1({1'b0,1'b0,1'b0,1'b1}), .O(inst0_O));
Register4R inst1 (.I(inst0_O), .O(inst1_O), .CLK(CLK), .RESET(inst4_O));
Add4 inst2 (.I0(inst3_O), .I1({1'b0,1'b0,1'b0,inst6_O}), .O(inst2_O));
Register4CE inst3 (.I(inst2_O), .O(inst3_O), .CLK(CLK), .CE(inst4_O));
EQ4 inst4 (.I0(inst1_O), .I1({1'b1,1'b1,1'b1,1'b1}), .O(inst4_O));
EQ4 inst5 (.I0(inst3_O), .I1({1'b1,1'b0,1'b0,1'b1}), .O(inst5_O));
NAnd2 inst6 (.I({inst5_O,inst4_O}), .O(inst6_O));
assign IDX = inst3_O;
assign CYCLE = inst0_O;
endmodule

module Register24 (input [23:0] I, output [23:0] O, input  CLK);
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
wire  inst17_Q;
wire  inst18_Q;
wire  inst19_Q;
wire  inst20_Q;
wire  inst21_Q;
wire  inst22_Q;
wire  inst23_Q;
SB_DFF inst0 (.C(CLK), .D(I[0]), .Q(inst0_Q));
SB_DFF inst1 (.C(CLK), .D(I[1]), .Q(inst1_Q));
SB_DFF inst2 (.C(CLK), .D(I[2]), .Q(inst2_Q));
SB_DFF inst3 (.C(CLK), .D(I[3]), .Q(inst3_Q));
SB_DFF inst4 (.C(CLK), .D(I[4]), .Q(inst4_Q));
SB_DFF inst5 (.C(CLK), .D(I[5]), .Q(inst5_Q));
SB_DFF inst6 (.C(CLK), .D(I[6]), .Q(inst6_Q));
SB_DFF inst7 (.C(CLK), .D(I[7]), .Q(inst7_Q));
SB_DFF inst8 (.C(CLK), .D(I[8]), .Q(inst8_Q));
SB_DFF inst9 (.C(CLK), .D(I[9]), .Q(inst9_Q));
SB_DFF inst10 (.C(CLK), .D(I[10]), .Q(inst10_Q));
SB_DFF inst11 (.C(CLK), .D(I[11]), .Q(inst11_Q));
SB_DFF inst12 (.C(CLK), .D(I[12]), .Q(inst12_Q));
SB_DFF inst13 (.C(CLK), .D(I[13]), .Q(inst13_Q));
SB_DFF inst14 (.C(CLK), .D(I[14]), .Q(inst14_Q));
SB_DFF inst15 (.C(CLK), .D(I[15]), .Q(inst15_Q));
SB_DFF inst16 (.C(CLK), .D(I[16]), .Q(inst16_Q));
SB_DFF inst17 (.C(CLK), .D(I[17]), .Q(inst17_Q));
SB_DFF inst18 (.C(CLK), .D(I[18]), .Q(inst18_Q));
SB_DFF inst19 (.C(CLK), .D(I[19]), .Q(inst19_Q));
SB_DFF inst20 (.C(CLK), .D(I[20]), .Q(inst20_Q));
SB_DFF inst21 (.C(CLK), .D(I[21]), .Q(inst21_Q));
SB_DFF inst22 (.C(CLK), .D(I[22]), .Q(inst22_Q));
SB_DFF inst23 (.C(CLK), .D(I[23]), .Q(inst23_Q));
assign O = {inst23_Q,inst22_Q,inst21_Q,inst20_Q,inst19_Q,inst18_Q,inst17_Q,inst16_Q,inst15_Q,inst14_Q,inst13_Q,inst12_Q,inst11_Q,inst10_Q,inst9_Q,inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module NXOr2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'h9999)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module NXOr2x16 (input [15:0] I0, input [15:0] I1, output [15:0] O);
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
NXOr2 inst0 (.I({I1[0],I0[0]}), .O(inst0_O));
NXOr2 inst1 (.I({I1[1],I0[1]}), .O(inst1_O));
NXOr2 inst2 (.I({I1[2],I0[2]}), .O(inst2_O));
NXOr2 inst3 (.I({I1[3],I0[3]}), .O(inst3_O));
NXOr2 inst4 (.I({I1[4],I0[4]}), .O(inst4_O));
NXOr2 inst5 (.I({I1[5],I0[5]}), .O(inst5_O));
NXOr2 inst6 (.I({I1[6],I0[6]}), .O(inst6_O));
NXOr2 inst7 (.I({I1[7],I0[7]}), .O(inst7_O));
NXOr2 inst8 (.I({I1[8],I0[8]}), .O(inst8_O));
NXOr2 inst9 (.I({I1[9],I0[9]}), .O(inst9_O));
NXOr2 inst10 (.I({I1[10],I0[10]}), .O(inst10_O));
NXOr2 inst11 (.I({I1[11],I0[11]}), .O(inst11_O));
NXOr2 inst12 (.I({I1[12],I0[12]}), .O(inst12_O));
NXOr2 inst13 (.I({I1[13],I0[13]}), .O(inst13_O));
NXOr2 inst14 (.I({I1[14],I0[14]}), .O(inst14_O));
NXOr2 inst15 (.I({I1[15],I0[15]}), .O(inst15_O));
assign O = {inst15_O,inst14_O,inst13_O,inst12_O,inst11_O,inst10_O,inst9_O,inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module BitCounter4 (input [3:0] I, output [2:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
SB_LUT4 #(.LUT_INIT(27030)) inst0 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(32488)) inst1 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(32768)) inst2 (.I0(I[0]), .I1(I[1]), .I2(I[2]), .I3(I[3]), .O(inst2_O));
assign O = {inst2_O,inst1_O,inst0_O};
endmodule

module HalfAdder (input  I0, input  I1, output  O, output  COUT);
wire  inst0_O;
wire  inst1_CO;
SB_LUT4 #(.LUT_INIT(16'h6666)) inst0 (.I0(I0), .I1(I1), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_CARRY inst1 (.I0(I0), .I1(I1), .CI(1'b0), .CO(inst1_CO));
assign O = inst0_O;
assign COUT = inst1_CO;
endmodule

module BitCounter8 (input [7:0] I, output [3:0] O);
wire [2:0] inst0_O;
wire [2:0] inst1_O;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
wire  inst4_O;
wire  inst4_COUT;
BitCounter4 inst0 (.I({I[3],I[2],I[1],I[0]}), .O(inst0_O));
BitCounter4 inst1 (.I({I[7],I[6],I[5],I[4]}), .O(inst1_O));
HalfAdder inst2 (.I0(inst0_O[0]), .I1(inst1_O[0]), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(inst0_O[1]), .I1(inst1_O[1]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(inst0_O[2]), .I1(inst1_O[2]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
assign O = {inst4_COUT,inst4_O,inst3_O,inst2_O};
endmodule

module BitCounter16 (input [15:0] I, output [4:0] O);
wire [3:0] inst0_O;
wire [3:0] inst1_O;
wire  inst2_O;
wire  inst2_COUT;
wire  inst3_O;
wire  inst3_COUT;
wire  inst4_O;
wire  inst4_COUT;
wire  inst5_O;
wire  inst5_COUT;
BitCounter8 inst0 (.I({I[7],I[6],I[5],I[4],I[3],I[2],I[1],I[0]}), .O(inst0_O));
BitCounter8 inst1 (.I({I[15],I[14],I[13],I[12],I[11],I[10],I[9],I[8]}), .O(inst1_O));
HalfAdder inst2 (.I0(inst0_O[0]), .I1(inst1_O[0]), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(inst0_O[1]), .I1(inst1_O[1]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(inst0_O[2]), .I1(inst1_O[2]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
FullAdder inst5 (.I0(inst0_O[3]), .I1(inst1_O[3]), .CIN(inst4_COUT), .O(inst5_O), .COUT(inst5_COUT));
assign O = {inst5_COUT,inst5_O,inst4_O,inst3_O,inst2_O};
endmodule

module Add9 (input [8:0] I0, input [8:0] I1, output [8:0] O);
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
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(1'b0), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(I0[4]), .I1(I1[4]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
FullAdder inst5 (.I0(I0[5]), .I1(I1[5]), .CIN(inst4_COUT), .O(inst5_O), .COUT(inst5_COUT));
FullAdder inst6 (.I0(I0[6]), .I1(I1[6]), .CIN(inst5_COUT), .O(inst6_O), .COUT(inst6_COUT));
FullAdder inst7 (.I0(I0[7]), .I1(I1[7]), .CIN(inst6_COUT), .O(inst7_O), .COUT(inst7_COUT));
FullAdder inst8 (.I0(I0[8]), .I1(I1[8]), .CIN(inst7_COUT), .O(inst8_O), .COUT(inst8_COUT));
assign O = {inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Mux2x9 (input [8:0] I0, input [8:0] I1, input  S, output [8:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
wire  inst8_O;
Mux2 inst0 (.I({I1[0],I0[0]}), .S(S), .O(inst0_O));
Mux2 inst1 (.I({I1[1],I0[1]}), .S(S), .O(inst1_O));
Mux2 inst2 (.I({I1[2],I0[2]}), .S(S), .O(inst2_O));
Mux2 inst3 (.I({I1[3],I0[3]}), .S(S), .O(inst3_O));
Mux2 inst4 (.I({I1[4],I0[4]}), .S(S), .O(inst4_O));
Mux2 inst5 (.I({I1[5],I0[5]}), .S(S), .O(inst5_O));
Mux2 inst6 (.I({I1[6],I0[6]}), .S(S), .O(inst6_O));
Mux2 inst7 (.I({I1[7],I0[7]}), .S(S), .O(inst7_O));
Mux2 inst8 (.I({I1[8],I0[8]}), .S(S), .O(inst8_O));
assign O = {inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Register9 (input [8:0] I, output [8:0] O, input  CLK);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
wire  inst8_Q;
SB_DFF inst0 (.C(CLK), .D(I[0]), .Q(inst0_Q));
SB_DFF inst1 (.C(CLK), .D(I[1]), .Q(inst1_Q));
SB_DFF inst2 (.C(CLK), .D(I[2]), .Q(inst2_Q));
SB_DFF inst3 (.C(CLK), .D(I[3]), .Q(inst3_Q));
SB_DFF inst4 (.C(CLK), .D(I[4]), .Q(inst4_Q));
SB_DFF inst5 (.C(CLK), .D(I[5]), .Q(inst5_Q));
SB_DFF inst6 (.C(CLK), .D(I[6]), .Q(inst6_Q));
SB_DFF inst7 (.C(CLK), .D(I[7]), .Q(inst7_Q));
SB_DFF inst8 (.C(CLK), .D(I[8]), .Q(inst8_Q));
assign O = {inst8_Q,inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Register8 (input [7:0] I, output [7:0] O, input  CLK);
wire  inst0_Q;
wire  inst1_Q;
wire  inst2_Q;
wire  inst3_Q;
wire  inst4_Q;
wire  inst5_Q;
wire  inst6_Q;
wire  inst7_Q;
SB_DFF inst0 (.C(CLK), .D(I[0]), .Q(inst0_Q));
SB_DFF inst1 (.C(CLK), .D(I[1]), .Q(inst1_Q));
SB_DFF inst2 (.C(CLK), .D(I[2]), .Q(inst2_Q));
SB_DFF inst3 (.C(CLK), .D(I[3]), .Q(inst3_Q));
SB_DFF inst4 (.C(CLK), .D(I[4]), .Q(inst4_Q));
SB_DFF inst5 (.C(CLK), .D(I[5]), .Q(inst5_Q));
SB_DFF inst6 (.C(CLK), .D(I[6]), .Q(inst6_Q));
SB_DFF inst7 (.C(CLK), .D(I[7]), .Q(inst7_Q));
assign O = {inst7_Q,inst6_Q,inst5_Q,inst4_Q,inst3_Q,inst2_Q,inst1_Q,inst0_Q};
endmodule

module Invert9 (input [8:0] I, output [8:0] O);
wire  inst0_O;
wire  inst1_O;
wire  inst2_O;
wire  inst3_O;
wire  inst4_O;
wire  inst5_O;
wire  inst6_O;
wire  inst7_O;
wire  inst8_O;
SB_LUT4 #(.LUT_INIT(16'h5555)) inst0 (.I0(I[0]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst0_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(I[1]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst2 (.I0(I[2]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst2_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst3 (.I0(I[3]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst3_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst4 (.I0(I[4]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst4_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst5 (.I0(I[5]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst5_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst6 (.I0(I[6]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst7 (.I0(I[7]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst7_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst8 (.I0(I[8]), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst8_O));
assign O = {inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
endmodule

module Add9CinCout (input [8:0] I0, input [8:0] I1, input  CIN, output [8:0] O, output  COUT);
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
FullAdder inst0 (.I0(I0[0]), .I1(I1[0]), .CIN(CIN), .O(inst0_O), .COUT(inst0_COUT));
FullAdder inst1 (.I0(I0[1]), .I1(I1[1]), .CIN(inst0_COUT), .O(inst1_O), .COUT(inst1_COUT));
FullAdder inst2 (.I0(I0[2]), .I1(I1[2]), .CIN(inst1_COUT), .O(inst2_O), .COUT(inst2_COUT));
FullAdder inst3 (.I0(I0[3]), .I1(I1[3]), .CIN(inst2_COUT), .O(inst3_O), .COUT(inst3_COUT));
FullAdder inst4 (.I0(I0[4]), .I1(I1[4]), .CIN(inst3_COUT), .O(inst4_O), .COUT(inst4_COUT));
FullAdder inst5 (.I0(I0[5]), .I1(I1[5]), .CIN(inst4_COUT), .O(inst5_O), .COUT(inst5_COUT));
FullAdder inst6 (.I0(I0[6]), .I1(I1[6]), .CIN(inst5_COUT), .O(inst6_O), .COUT(inst6_COUT));
FullAdder inst7 (.I0(I0[7]), .I1(I1[7]), .CIN(inst6_COUT), .O(inst7_O), .COUT(inst7_COUT));
FullAdder inst8 (.I0(I0[8]), .I1(I1[8]), .CIN(inst7_COUT), .O(inst8_O), .COUT(inst8_COUT));
assign O = {inst8_O,inst7_O,inst6_O,inst5_O,inst4_O,inst3_O,inst2_O,inst1_O,inst0_O};
assign COUT = inst8_COUT;
endmodule

module Sub9Cout (input [8:0] I0, input [8:0] I1, output [8:0] O, output  COUT);
wire [8:0] inst0_O;
wire [8:0] inst1_O;
wire  inst1_COUT;
Invert9 inst0 (.I(I1), .O(inst0_O));
Add9CinCout inst1 (.I0(I0), .I1(inst0_O), .CIN(1'b1), .O(inst1_O), .COUT(inst1_COUT));
assign O = inst1_O;
assign COUT = inst1_COUT;
endmodule

module UGT9 (input [8:0] I0, input [8:0] I1, output  O);
wire [8:0] inst0_O;
wire  inst0_COUT;
wire  inst1_O;
Sub9Cout inst0 (.I0(I1), .I1(I0), .O(inst0_O), .COUT(inst0_COUT));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(inst0_COUT), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
assign O = inst1_O;
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

module Classifier (input [8:0] I, input [3:0] IDX, input  CLK, output [3:0] O);
wire  inst0_O;
wire [8:0] inst1_O;
wire [3:0] inst2_O;
UGT9 inst0 (.I0(I), .I1(inst1_O), .O(inst0_O));
Register9CE inst1 (.I(I), .O(inst1_O), .CLK(CLK), .CE(inst0_O));
Register4CE inst2 (.I(IDX), .O(inst2_O), .CLK(CLK), .CE(inst0_O));
assign O = inst2_O;
endmodule

module Or2 (input [1:0] I, output  O);
wire  inst0_O;
SB_LUT4 #(.LUT_INIT(16'hEEEE)) inst0 (.I0(I[0]), .I1(I[1]), .I2(1'b0), .I3(1'b0), .O(inst0_O));
assign O = inst0_O;
endmodule

module Pipeline (input  CLK, input [15:0] DATA, input [3:0] WADDR, input  RUN, output [3:0] O, output  D);
wire [15:0] inst0_WEIGHT;
wire [15:0] inst0_IMAGE;
wire  inst1_O;
wire  inst2_O;
wire [3:0] inst3_IDX;
wire [3:0] inst3_CYCLE;
wire [3:0] inst4_O;
wire  inst5_Q;
wire  inst6_O;
wire  inst7_O;
wire [23:0] inst8_O;
wire  inst9_Q;
wire [15:0] inst10_O;
wire [4:0] inst11_O;
wire [8:0] inst12_O;
wire [8:0] inst13_O;
wire [8:0] inst14_O;
wire [8:0] inst15_O;
wire [7:0] inst16_O;
wire  inst17_O;
wire [3:0] inst18_O;
wire [7:0] inst19_O;
wire [3:0] inst20_O;
wire  inst21_O;
wire  inst22_O;
wire  inst23_O;
wire  inst24_Q;
wire  inst25_O;
MEM inst0 (.IDX(inst3_IDX), .CYCLE(inst4_O), .CLK(CLK), .DATA(DATA), .WADDR(WADDR), .WE(inst1_O), .WEIGHT(inst0_WEIGHT), .IMAGE(inst0_IMAGE));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst1 (.I0(RUN), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst1_O));
And2 inst2 (.I({RUN,CLK}), .O(inst2_O));
Controller inst3 (.CLK(inst2_O), .IDX(inst3_IDX), .CYCLE(inst3_CYCLE));
Register4 inst4 (.I(inst3_CYCLE), .O(inst4_O), .CLK(inst2_O));
SB_DFF inst5 (.C(inst2_O), .D(inst6_O), .Q(inst5_Q));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst6 (.I0(1'b1), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst6_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst7 (.I0(inst5_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst7_O));
Register24 inst8 (.I({inst4_O[3],inst4_O[2],inst4_O[1],inst4_O[0],inst3_IDX[3],inst3_IDX[2],inst3_IDX[1],inst3_IDX[0],inst0_IMAGE[15],inst0_IMAGE[14],inst0_IMAGE[13],inst0_IMAGE[12],inst0_IMAGE[11],inst0_IMAGE[10],inst0_IMAGE[9],inst0_IMAGE[8],inst0_IMAGE[7],inst0_IMAGE[6],inst0_IMAGE[5],inst0_IMAGE[4],inst0_IMAGE[3],inst0_IMAGE[2],inst0_IMAGE[1],inst0_IMAGE[0]}), .O(inst8_O), .CLK(inst2_O));
SB_DFF inst9 (.C(inst2_O), .D(inst7_O), .Q(inst9_Q));
NXOr2x16 inst10 (.I0(inst0_WEIGHT), .I1({inst8_O[15],inst8_O[14],inst8_O[13],inst8_O[12],inst8_O[11],inst8_O[10],inst8_O[9],inst8_O[8],inst8_O[7],inst8_O[6],inst8_O[5],inst8_O[4],inst8_O[3],inst8_O[2],inst8_O[1],inst8_O[0]}), .O(inst10_O));
BitCounter16 inst11 (.I(inst10_O), .O(inst11_O));
Add9 inst12 (.I0(inst13_O), .I1(inst14_O), .O(inst12_O));
Mux2x9 inst13 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,inst11_O[4],inst11_O[3],inst11_O[2],inst11_O[1],inst11_O[0]}), .S(inst9_Q), .O(inst13_O));
Mux2x9 inst14 (.I0(inst15_O), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst17_O), .O(inst14_O));
Register9 inst15 (.I(inst12_O), .O(inst15_O), .CLK(inst2_O));
Register8 inst16 (.I({inst8_O[23],inst8_O[22],inst8_O[21],inst8_O[20],inst8_O[19],inst8_O[18],inst8_O[17],inst8_O[16]}), .O(inst16_O), .CLK(inst2_O));
SB_LUT4 #(.LUT_INIT(1)) inst17 (.I0(inst8_O[20]), .I1(inst8_O[21]), .I2(inst8_O[22]), .I3(inst8_O[23]), .O(inst17_O));
Classifier inst18 (.I(inst15_O), .IDX({inst16_O[3],inst16_O[2],inst16_O[1],inst16_O[0]}), .CLK(inst2_O), .O(inst18_O));
Register8 inst19 (.I(inst16_O), .O(inst19_O), .CLK(inst2_O));
Register4CE inst20 (.I(inst18_O), .O(inst20_O), .CLK(inst2_O), .CE(inst23_O));
EQ4 inst21 (.I0({inst19_O[3],inst19_O[2],inst19_O[1],inst19_O[0]}), .I1({1'b1,1'b0,1'b0,1'b1}), .O(inst21_O));
EQ4 inst22 (.I0({inst19_O[7],inst19_O[6],inst19_O[5],inst19_O[4]}), .I1({1'b1,1'b1,1'b1,1'b1}), .O(inst22_O));
And2 inst23 (.I({inst22_O,inst21_O}), .O(inst23_O));
SB_DFF inst24 (.C(inst2_O), .D(inst25_O), .Q(inst24_Q));
Or2 inst25 (.I({inst24_Q,inst23_O}), .O(inst25_O));
assign O = inst20_O;
assign D = inst24_Q;
endmodule

module main (output  D5, output  D4, output  D3, output  D2, output  D1, input  CLKIN);
wire [3:0] inst0_O;
wire  inst0_COUT;
wire [3:0] inst1_O;
wire  inst1_COUT;
wire  inst2_Q;
wire  inst3_O;
wire  inst4_O;
wire  inst5_Q;
wire  inst6_O;
wire  inst7_Q;
wire  inst8_O;
wire  inst9_O;
wire  inst10_O;
wire [15:0] inst11_O;
wire [15:0] inst12_O;
wire [15:0] inst13_O;
wire [15:0] inst14_O;
wire [15:0] inst15_O;
wire [15:0] inst16_O;
wire [15:0] inst17_O;
wire [15:0] inst18_O;
wire [15:0] inst19_O;
wire [15:0] inst20_O;
wire [15:0] inst21_O;
wire [15:0] inst22_O;
wire [15:0] inst23_O;
wire [15:0] inst24_O;
wire [15:0] inst25_O;
wire [3:0] inst26_O;
wire  inst26_D;
Counter4 inst0 (.O(inst0_O), .COUT(inst0_COUT), .CLK(CLKIN));
Counter4CE inst1 (.O(inst1_O), .COUT(inst1_COUT), .CLK(CLKIN), .CE(inst10_O));
SB_DFFE inst2 (.C(CLKIN), .E(inst6_O), .D(inst3_O), .Q(inst2_Q));
SB_LUT4 #(.LUT_INIT(16'h0E0E)) inst3 (.I0(inst2_Q), .I1(inst4_O), .I2(1'b0), .I3(1'b0), .O(inst3_O));
EQ4 inst4 (.I0(inst1_O), .I1({1'b1,1'b1,1'b1,1'b1}), .O(inst4_O));
SB_DFF inst5 (.C(CLKIN), .D(inst0_O[3]), .Q(inst5_Q));
SB_LUT4 #(.LUT_INIT(16'h4444)) inst6 (.I0(inst0_O[3]), .I1(inst5_Q), .I2(1'b0), .I3(1'b0), .O(inst6_O));
SB_DFF inst7 (.C(CLKIN), .D(inst0_O[3]), .Q(inst7_Q));
SB_LUT4 #(.LUT_INIT(16'h2222)) inst8 (.I0(inst0_O[3]), .I1(inst7_Q), .I2(1'b0), .I3(1'b0), .O(inst8_O));
SB_LUT4 #(.LUT_INIT(16'h5555)) inst9 (.I0(inst2_Q), .I1(1'b0), .I2(1'b0), .I3(1'b0), .O(inst9_O));
And2 inst10 (.I({inst9_O,inst8_O}), .O(inst10_O));
Mux2x16 inst11 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst11_O));
Mux2x16 inst12 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst12_O));
Mux2x16 inst13 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst13_O));
Mux2x16 inst14 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst14_O));
Mux2x16 inst15 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst15_O));
Mux2x16 inst16 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst16_O));
Mux2x16 inst17 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst17_O));
Mux2x16 inst18 (.I0({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .I1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}), .S(inst1_O[0]), .O(inst18_O));
Mux2x16 inst19 (.I0(inst11_O), .I1(inst12_O), .S(inst1_O[1]), .O(inst19_O));
Mux2x16 inst20 (.I0(inst13_O), .I1(inst14_O), .S(inst1_O[1]), .O(inst20_O));
Mux2x16 inst21 (.I0(inst15_O), .I1(inst16_O), .S(inst1_O[1]), .O(inst21_O));
Mux2x16 inst22 (.I0(inst17_O), .I1(inst18_O), .S(inst1_O[1]), .O(inst22_O));
Mux2x16 inst23 (.I0(inst19_O), .I1(inst20_O), .S(inst1_O[2]), .O(inst23_O));
Mux2x16 inst24 (.I0(inst21_O), .I1(inst22_O), .S(inst1_O[2]), .O(inst24_O));
Mux2x16 inst25 (.I0(inst23_O), .I1(inst24_O), .S(inst1_O[3]), .O(inst25_O));
Pipeline inst26 (.CLK(inst0_O[3]), .DATA(inst25_O), .WADDR(inst1_O), .RUN(inst2_Q), .O(inst26_O), .D(inst26_D));
assign D5 = inst26_D;
assign D4 = inst26_O[3];
assign D3 = inst26_O[2];
assign D2 = inst26_O[1];
assign D1 = inst26_O[0];
endmodule

