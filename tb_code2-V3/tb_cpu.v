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
	forever #50 clk = ~clk;
// --> end                                             
$display("Running testbench");                       
end

initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
	Databus = 16'b0000_0000_0000_0000;
	ExternalReset =0;
	IO_datain = 16'b0000_0000_0000_0000;
	MemDataready = 0;
	
	// 仿真三条指令执行
    
	// 1. 复位CPU
	#100 ExternalReset = 1;  // 释放复位
    
	// 2. 执行mil R0 10101111指令
	#100;
	// 指令周期：取指阶段
	if(ReadMem == 1'b1) begin
	    // 提供mil R0 10101111指令 (16'b1111000010101111)
	    Databus = 16'b1111000010101111;
	    MemDataready = 1'b1;
	    $display("[时间 %t] 提供指令: mil R0 10101111 (16'b1111000010101111)", $time);
	    #100 MemDataready = 1'b0; // 清除就绪信号
	end
    
	// 3. 执行mih R0 10000001指令
	#200;
	// 指令周期：取指阶段
	if(ReadMem == 1'b1) begin
	    // 提供mih R0 10000001指令 (16'b1111000110000001)
	    Databus = 16'b1111000110000001;
	    MemDataready = 1'b1;
	    $display("[时间 %t] 提供指令: mih R0 10000001 (16'b1111000110000001)", $time);
	    #100 MemDataready = 1'b0; // 清除就绪信号
	end
    
	// 4. 执行mvr R1 R0指令
	#200;
	// 指令周期：取指阶段
	if(ReadMem == 1'b1) begin
	    // 提供mvr R1 R0指令 (16'b0001010000000000)
	    Databus = 16'b0001010000000000;
	    MemDataready = 1'b1;
	    $display("[时间 %t] 提供指令: mvr R1 R0 (16'b0001010000000000)", $time);
	    #100 MemDataready = 1'b0; // 清除就绪信号
	end
    
	// 5. 等待指令执行完成
	#500;
	$display("[时间 %t] 指令执行完成，仿真结束", $time);
	$stop;
end                            
endmodule
