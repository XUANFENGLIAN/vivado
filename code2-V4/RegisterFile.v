//----------------------------------------------------------------------
//--SAYEH (Simple Architecture Yet Enough Hardware) CPU
//----------------------------------------------------------------------
// 寄存器文件模块：实现CPU的通用寄存器阵列
// 功能：提供4个16位通用寄存器，支持双端口同时读取和单端口灵活写入

`timescale 1 ns /1 ns

module RegisterFile (
	input [15:0] in,            // 16位数据输入端口
	input clk,                  // 时钟信号
	input RFLwrite,             // 寄存器低8位写入使能（高电平有效）
	input RFHwrite,             // 寄存器高8位写入使能（高电平有效）
	// 左右地址分别控制左右读取端口。使能写入时，左地址作为写入地址
	input [1:0] Laddr,          // 左地址端口（2位，可访问4个寄存器）
	input [1:0] Raddr,          // 右地址端口（2位，可访问4个寄存器）
	output [15:0] Lout,         // 左端口16位数据输出
	output [15:0] Rout          // 右端口16位数据输出
);

// 内部存储结构：将寄存器分为高8位和低8位两个独立的存储阵列
// 每个存储阵列包含4个8位寄存器（地址0-3）
reg [7:0] MemoryFileH [0:3];  // 寄存器文件高8位存储阵列
reg [7:0] MemoryFileL [0:3];  // 寄存器文件低8位存储阵列

// 读取逻辑：双端口并行读取
// 左端口输出：根据Laddr地址，将对应寄存器的高8位和低8位拼接输出
assign Lout = {MemoryFileH[Laddr], MemoryFileL[Laddr]};
// 右端口输出：根据Raddr地址，将对应寄存器的高8位和低8位拼接输出
assign Rout = {MemoryFileH[Raddr], MemoryFileL[Raddr]};

// 写入逻辑：在时钟下降沿执行，支持三种写入模式
// 由RFHwrite和RFLwrite的组合控制写入操作类型
always @(negedge clk) begin
	case({RFHwrite, RFLwrite})
		// 模式0：不写入（保持当前值）
		2'b00: begin 
			MemoryFileH[Laddr] <= MemoryFileH[Laddr];
			MemoryFileL[Laddr] <= MemoryFileL[Laddr];
		end
		// 模式1：仅写入低8位
		2'b01: begin 
			MemoryFileH[Laddr] <= MemoryFileH[Laddr];
			MemoryFileL[Laddr] <= in[7:0];  // 将输入数据的低8位写入指定寄存器的低8位
		end
		// 模式2：仅写入高8位
		2'b10: begin 
			MemoryFileH[Laddr] <= in[15:8]; // 将输入数据的高8位写入指定寄存器的高8位
			MemoryFileL[Laddr] <= MemoryFileL[Laddr];
		end
		// 模式3：同时写入16位完整数据
		2'b11: begin 
			{MemoryFileH[Laddr], MemoryFileL[Laddr]} <= in; // 同时写入高8位和低8位
		end
	endcase
end

endmodule


  