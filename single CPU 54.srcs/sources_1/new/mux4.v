`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 11:09:51
// Design Name: 
// Module Name: mux4
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


module mux4(
    input [31:0] in0,  // 输入0
    input [31:0] in1,  // 输入1
    input [31:0] in2,  // 输入2
    input [31:0] in3,  // 输入3
    input [1:0] select,  // 2位选择信号
    output reg [31:0] out  // 输出
);
    // 选择逻辑
    always @(*) begin
        case (select)
            2'b00: out = in0;  // 当select为00时选择in0
            2'b01: out = in1;  // 当select为01时选择in1
            2'b10: out = in2;  // 当select为10时选择in2
            2'b11: out = in3;  // 当select为11时选择in3
            default: out = 32'bx;  // 默认输出不定态
        endcase
    end
endmodule

