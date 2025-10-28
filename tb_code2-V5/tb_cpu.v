`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/21 14:50:27
// Design Name: 
// Module Name: tb_cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_cpu();
// test vector input registers
reg [15:0] Databus;
reg ExternalReset;
reg [15:0] IO_datain;
reg MemDataready;
reg clk;
// wires                                               
wire [15:0]  Addressbus;
wire ReadIO;
wire ReadMem;
wire WriteIO;
wire WriteMem;
wire [15:0]  aluout;

// assign statements (if any)                          
cpu test_cpu (
// port map - connection between master ports and signals/registers   
	.Addressbus(Addressbus),
	.Databus(Databus),
	.ExternalReset(ExternalReset),
	.IO_datain(IO_datain),
	.MemDataready(MemDataready),
	.ReadIO(ReadIO),
	.ReadMem(ReadMem),
	.WriteIO(WriteIO),
	.WriteMem(WriteMem),
	.aluout(aluout),
	.clk(clk)
);
initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
	clk = 0;
	forever #5 clk = ~clk;
// --> end                                             
$display("Running testbench");                       
end

initial                                                
begin                                                  
// code that executes only once                        
                     
	Databus = 16'b0000_0000_0000_0000;
	ExternalReset =0;
	IO_datain = 16'b0000_0000_0000_0000;
	MemDataready = 1;
	#10 ExternalReset =1;

	// insert code here --> begin     
	// 指令1: mil R0 10101111
	@(posedge ReadMem); // 等待读取内存信号有效
	Databus = 16'b1111_0000_1010_1111; // 指令编码
	#200; // 保持指令足够长的时间
	$display("Executing instruction 1: mil R0 10101111, Databus=%b", Databus);
    
	// 指令2: mih R0 10000001
	@(posedge ReadMem); // 等待下一个读取内存信号有效
	Databus = 16'b1111_0001_1000_0001; // 指令编码
	#200; // 保持指令足够长的时间
	$display("Executing instruction 2: mih R0 10000001, Databus=%b", Databus);
    
	// 指令3: mvr R1 R0
	@(posedge ReadMem); // 等待下一个读取内存信号有效
	Databus = 16'b0001_0100_0000_0000; // 指令编码
	#200; // 保持指令足够长的时间
	$display("Executing instruction 3: mvr R1 R0, Databus=%b", Databus);
    
	#200; // 等待所有指令执行完成
	$stop;
end                            
endmodule
