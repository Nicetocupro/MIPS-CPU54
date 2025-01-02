`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/25 21:13:49
// Design Name: 
// Module Name: Divider
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


module Divider(clk,rst_n,clk_out);
/* ģ������������� */
input clk;                //ϵͳʱ��
input rst_n;              //��λ�ź�,�͵�ƽ��Ч
output reg clk_out;       //�������CPU��ʱ��
/* ģ���м���� */
reg [31:0] count3=32'd0; //50,000,000��Ƶ
//50,000,000��Ƶ
always @(posedge clk) 
begin 
    if(!rst_n)
    begin
      count3 <= 1'b0;
      clk_out <= 0;  
    end
    else if(count3 == 32'd10000000) 
    begin 
        count3 <= 32'd0; 
        clk_out <= ~clk_out; 
    end 
    else
        count3 <= count3+1'b1; 
end
endmodule