`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/21 14:48:03
// Design Name: 
// Module Name: tb_AddressingUnit
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
   
  /*Add your code here*/
   
    #10 $stop;
  end
endmodule
