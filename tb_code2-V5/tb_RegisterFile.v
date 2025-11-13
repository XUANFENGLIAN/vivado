`timescale 1ns / 1ps

module tb_RegisterFile();
// general purpose registers
reg eachvec;
// test vector input registers
reg [1:0] Laddr;
reg RFHwrite;
reg RFLwrite;
reg [1:0] Raddr;
reg clk;
reg [15:0] in;
// wires                                               
wire [15:0]  Lout;
wire [15:0]  Rout;

RegisterFile test_RegisterFile (
// port map - connection between master ports and signals/registers   
	.Laddr(Laddr),
	.Lout(Lout),
	.RFHwrite(RFHwrite),
	.RFLwrite(RFLwrite),
	.Raddr(Raddr),
	.Rout(Rout),
	.clk(clk),
	.in(in)
);
initial                                                
begin                                                  
	in=16'd15;
	clk=0;
	RFLwrite=0;
	RFHwrite=0;
	Laddr=2'd00;
	Raddr=2'd01;
	#10 RFHwrite=1;
	#10 RFHwrite=0;RFLwrite=1;
	#10 RFLwrite=0;
	#40 $stop;
	
end
always #5 clk=~clk;
	
endmodule
