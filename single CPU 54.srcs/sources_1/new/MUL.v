`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 17:00:18
// Design Name: 
// Module Name: MUL
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


module MUL(
    input [31:0] a,
    input [31:0] b,
    output reg [63:0] z
);
    reg [63:0] midnum;
    reg [31:0] temp_a;
    reg [31:0] temp_b;
    reg signed [63:0] signed_midnum; // 添加有符号中间变量
    reg temp;
    integer i;

    always @* 
    begin
        temp = a[31] ^ b[31];
        temp_a = a[31] ? (~a + 1'b1) : a;
        temp_b = b[31] ? (~b + 1'b1) : b;
        midnum = 0;
        
        for(i = 0; i < 32; i = i + 1)
        begin
            if(temp_b[0])
            begin
                midnum = midnum + ((temp_a << i));
            end
            temp_b = temp_b >> 1;
        end
        
        // 有符号数结果的处理
        signed_midnum = temp ? -midnum : midnum;
        z = signed_midnum;
    end
endmodule
