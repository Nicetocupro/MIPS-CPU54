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
    input [31:0] a,  //������a(������) 
    input [31:0] b,  //������b�������� 
    output reg [63:0] z //�˻����z 
);
    // �޷��ŵĳ˷���
    reg [63:0] midnum; // ���Դ洢�м���
    reg [31:0] temp_a; // ��ʱ�洢a������ı�����
    reg [31:0] temp_b; // ��ʱ�洢b������ı�����
    integer i;
    
    always @* 
    begin
        temp_a = a;
        temp_b = b;
        midnum = 0;
        for(i = 0 ; i < 32 ; i = i + 1) begin
            if(temp_b[0] == 1'b1) begin
                midnum = midnum + (temp_a << i); // ͨ����λ���ۼ���ʵ�ֳ˷�
            end
            temp_b = temp_b >> 1; // ����temp_b
        end
        z = midnum; // �����ս���������
    end
endmodule
