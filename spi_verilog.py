import magma as m

from loam.boards.icestick import IceStick

icestick = IceStick()
icestick.Clock.on()

main = icestick.main()

verilog_source = '''
module spi_8bit_rw
  (
   input 	    clock,
   input 	    write,
   input [8:0] 	    din,
   output reg [7:0] dout = 16'h0,
   output reg 	    cs = 1'b1,
   output reg 	    sck = 1'b0,
   output reg 	    mosi,
   input 	    miso
   );

   reg [5:0] 	    state = 6'h0;
   reg 		    cs_hold = 0;

   always @ (posedge clock)
     begin
	mosi <= dout[7];
	if(write)
	  begin
	     cs_hold <= din[8];
	     dout <= din[7:0];
	     state <= 1'd1;
	  end
	else if(state != 0)
	  begin
	     if(state[2:0] == 7)
	       dout <= {dout[6:0], miso};
	     state <= state + 1'b1;
	  end
	sck <= state[2];
	cs <= (state == 0) && ~cs_hold;
     end

endmodule'''

SPI_slave = m.DefineFromVerilog(verilog_source)[0]

print(HalfAdder)

