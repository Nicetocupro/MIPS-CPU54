`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 17:01:37
// Design Name: 
// Module Name: MULU
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


module MULU(
    input [31:0] a,  //输入数a(被乘数) 
    input [31:0] b,  //输入数b（乘数） 
    output reg [63:0] z //乘积输出z 
);
    // 无符号的乘法器
    reg [63:0] midnum; // 用以存储中间结果
    reg [31:0] temp_a; // 临时存储a，避免改变输入
    reg [31:0] temp_b; // 临时存储b，避免改变输入
    integer i;
    
    always @* 
    begin
        temp_a = a;
        temp_b = b;
        midnum = 0;
        for(i = 0 ; i < 32 ; i = i + 1) begin
            if(temp_b[0] == 1'b1) begin
                midnum = midnum + (temp_a << i); // 通过移位并累加来实现乘法
            end
            temp_b = temp_b >> 1; // 右移temp_b
        end
        z = midnum; // 将最终结果赋给输出
    end
endmodule
