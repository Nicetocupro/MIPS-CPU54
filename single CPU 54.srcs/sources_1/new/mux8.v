`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/16 16:00:13
// Design Name: 
// Module Name: mux8
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


module mux8(
    input [31:0] in0,  // 输入0
    input [31:0] in1,  // 输入1
    input [31:0] in2,  // 输入2
    input [31:0] in3,  // 输入3
    input [31:0] in4,  // 输入4
    input [31:0] in5,  // 输入5
    input [31:0] in6,  // 输入6
    input [31:0] in7,  // 输入7
    input [2:0] select,  // 3位选择信号
    output reg [31:0] out  // 输出
);
    // 选择逻辑
    always @(*) begin
        case (select)
            3'b000: out = in0;  // 当select为000时选择in0
            3'b001: out = in1;  // 当select为001时选择in1
            3'b010: out = in2;  // 当select为010时选择in2
            3'b011: out = in3;  // 当select为011时选择in3
            3'b100: out = in4;  // 当select为100时选择in4
            3'b101: out = in5;  // 当select为101时选择in5
            3'b110: out = in6;  // 当select为110时选择in6
            3'b111: out = in7;  // 当select为111时选择in7
            default: out = 32'bx;  // 默认输出不定态
        endcase
    end
endmodule

