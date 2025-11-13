`timescale 1ns / 1ps

module tb_cpu_top();
// test vector input registers
reg ExternalReset;
reg clk;
reg [7:0] in;
// wires                                               
wire [7:0] out;
// assign statements (if any)                          
cpu_top test_cpu_top (
// port map - connection between master ports and signals/registers   
	.in(in),
	.out(out),
	.ExternalReset(ExternalReset),
	.clk(clk)
);
initial                                                
begin                                                                    
	clk = 0;
	forever #1 clk = ~clk;                      
end

initial                                                
begin                                                  
   ExternalReset = 0;
   in = 8'b00000000;
   #5; 
   ExternalReset = 1;
   #4000;
    $stop;
 
end                            
endmodule