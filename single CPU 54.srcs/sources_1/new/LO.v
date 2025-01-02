`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 17:05:21
// Design Name: 
// Module Name: LO
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


module LO(
    input clk,
    input reset,
    input [31:0] data,
    input lo_w,   // 读写控制信号
    input lo_r,
    output [31:0] out
);

reg [31:0] save;  // 用于存储LO的数据
reg [31:0] lo_out;

assign out = lo_out;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        save <= 0;
    end else if (lo_w) begin
        save <= data;
    end
end

always @(*) begin
    if (reset) begin
        lo_out <= 0;
    end else if (lo_r) begin
        lo_out <= save;
    end else begin
        lo_out <= 32'bz;  // High-impedance state when not reading
    end
end

endmodule
