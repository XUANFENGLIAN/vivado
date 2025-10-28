`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/21 17:02:15
// Design Name: 
// Module Name: AddressLogic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 地址逻辑模块 - 实现不同的寻址模式
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module AddressLogic(
    input [15:0] PCside,
    input [15:0] Rside,
    input [7:0] Iside,
    output reg [15:0] ALout,
    input ResetPC,
    input PCplusI,
    input PCplus1,
    input Iplus0,
    input Rplus0
);
    
    // 地址计算逻辑
    always @(*)
    begin
        if (ResetPC) begin
            ALout = 16'h0000;  // 重置时输出0
        end
        else if (PCplus1) begin
            ALout = PCside + 16'h0001;  // PC+1模式
        end
        else if (PCplusI) begin
            ALout = PCside + {8'h00, Iside};  // PC+I模式
        end
        else if (Iplus0) begin
            ALout = {8'h00, Iside};  // I+0模式
        end
        else if (Rplus0) begin
            ALout = Rside;  // R+0模式
        end
        else begin
            ALout = 16'h0000;  // 默认值
        end
    end
    
endmodule