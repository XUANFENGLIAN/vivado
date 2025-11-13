`timescale 1ns / 1ps

module tb_AddressingUnit();
  reg [15:0] Rside;
  reg [7:0] Iside;
  reg ResetPC, PCplusI, PCplus1, Iplus0, Rplus0, PCenable;
  reg clk;
  wire [15:0] Address;
  
  AddressingUnit test_AddressingUnit(Rside, Iside, Address, clk, ResetPC, PCplusI, PCplus1, Iplus0, Rplus0, PCenable);
  
  always #5 clk=~clk;
  
  initial begin
	clk=0;
   
    // 初始化信号
    Rside = 16'h0000;
    Iside = 8'h00;
    ResetPC = 0;
    PCplusI = 0;
    PCplus1 = 0;
    Iplus0 = 0;
    Rplus0 = 0;
    PCenable = 0;
    
    // 测试1: 重置PC
    #10 ResetPC = 1;
    #10 ResetPC = 0;
    #5 $display("Reset PC Test: Address = 0x%h", Address);
    
    // 测试2: PC+1模式
    #10 PCplus1 = 1;
    #10 PCenable = 1;  // 上升沿使能PC更新
    #10 PCenable = 0;
    #5 $display("PC+1 Test: Address = 0x%h", Address);
    
    // 测试3: PC+I模式
    #10 PCplus1 = 0;
    #10 PCplusI = 1;
    Iside = 8'h10;  // 立即数
    #10 PCenable = 1;
    #10 PCenable = 0;
    #5 $display("PC+I Test: Address = 0x%h", Address);
    
    // 测试4: R+0模式
    #10 PCplusI = 0;
    #10 Rplus0 = 1;
    Rside = 16'h2000;  // 寄存器值
    #5 $display("R+0 Test: Address = 0x%h", Address);
    
    // 测试5: I+0模式
    #10 Rplus0 = 0;
    #10 Iplus0 = 1;
    Iside = 8'h30;  // 立即数
    #5 $display("I+0 Test: Address = 0x%h", Address);
    
    // 测试6: 连续更新PC
    #10 Iplus0 = 0;
    #10 PCplus1 = 1;
    PCenable = 1;
    #10 $display("PC Increment 1: Address = 0x%h", Address);
    #10 $display("PC Increment 2: Address = 0x%h", Address);
    #10 $display("PC Increment 3: Address = 0x%h", Address);
    #10 PCenable = 0;
    
    // 测试7: 重置后的PC
    #10 ResetPC = 1;
    #10 ResetPC = 0;
    #5 $display("Reset PC Again: Address = 0x%h", Address);
    
    #10 $stop;
  end
endmodule
