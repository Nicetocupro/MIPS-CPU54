`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 17:04:07
// Design Name: 
// Module Name: HI
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


module HI(
    input clk,
    input reset,
    input [31:0] data,
    input hi_w,   //读写控制信号
    input hi_r,
    output [31:0] out
);

reg [31:0] save;  //用于存储HI的数据
reg [31:0] hi_out;

assign out = hi_out;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        save <= 0;
    end else if (hi_w) begin
        save <= data;
    end
end

always @(*) begin
    if (reset) begin
        hi_out <= 0;
    end else if (hi_r) begin
        hi_out <= save;
    end else begin
        hi_out <= 32'bz;  // High-impedance state when not reading
    end
end

endmodule

