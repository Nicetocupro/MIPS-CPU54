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
    input [31:0] in0,  // ����0
    input [31:0] in1,  // ����1
    input [31:0] in2,  // ����2
    input [31:0] in3,  // ����3
    input [1:0] select,  // 2λѡ���ź�
    output reg [31:0] out  // ���
);
    // ѡ���߼�
    always @(*) begin
        case (select)
            2'b00: out = in0;  // ��selectΪ00ʱѡ��in0
            2'b01: out = in1;  // ��selectΪ01ʱѡ��in1
            2'b10: out = in2;  // ��selectΪ10ʱѡ��in2
            2'b11: out = in3;  // ��selectΪ11ʱѡ��in3
            default: out = 32'bx;  // Ĭ���������̬
        endcase
    end
endmodule

