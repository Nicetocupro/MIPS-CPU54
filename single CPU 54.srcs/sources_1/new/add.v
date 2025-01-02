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
    // ֱ�ӽ��мӷ�����
    assign r = a + b;

    // ������������������ķ���λ��ͬ�ҽ���ķ���λ�����벻ͬʱ����ʾ���
    assign overflow = (a[31] == b[31]) && (r[31] != a[31]) ? 1'b1 : 1'b0;
endmodule

