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
    input [31:0] in0,  // ����0
    input [31:0] in1,  // ����1
    input [31:0] in2,  // ����2
    input [31:0] in3,  // ����3
    input [31:0] in4,  // ����4
    input [31:0] in5,  // ����5
    input [31:0] in6,  // ����6
    input [31:0] in7,  // ����7
    input [2:0] select,  // 3λѡ���ź�
    output reg [31:0] out  // ���
);
    // ѡ���߼�
    always @(*) begin
        case (select)
            3'b000: out = in0;  // ��selectΪ000ʱѡ��in0
            3'b001: out = in1;  // ��selectΪ001ʱѡ��in1
            3'b010: out = in2;  // ��selectΪ010ʱѡ��in2
            3'b011: out = in3;  // ��selectΪ011ʱѡ��in3
            3'b100: out = in4;  // ��selectΪ100ʱѡ��in4
            3'b101: out = in5;  // ��selectΪ101ʱѡ��in5
            3'b110: out = in6;  // ��selectΪ110ʱѡ��in6
            3'b111: out = in7;  // ��selectΪ111ʱѡ��in7
            default: out = 32'bx;  // Ĭ���������̬
        endcase
    end
endmodule

