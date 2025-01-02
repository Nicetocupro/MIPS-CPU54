`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 11:12:41
// Design Name: 
// Module Name: extend5
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


module extend #(
    parameter WIDTH = 16  // 默认位宽为16位
)(
    input [WIDTH - 1:0] a,
    input SEXT ,
    output [31:0] b
);
    // 根据SEXT参数选择符号扩展还是零扩展
    assign b = SEXT ? {{(32 - WIDTH){a[WIDTH - 1]}}, a} : {{(32 - WIDTH){1'b0}}, a};
endmodule

