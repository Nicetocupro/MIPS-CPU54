`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 11:13:48
// Design Name: 
// Module Name: add
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

module add(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output overflow
);
    // 直接进行加法操作
    assign r = a + b;

    // 检测溢出：当两个输入的符号位相同且结果的符号位与输入不同时，表示溢出
    assign overflow = (a[31] == b[31]) && (r[31] != a[31]) ? 1'b1 : 1'b0;
endmodule

