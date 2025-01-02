`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/17 17:46:46
// Design Name: 
// Module Name: cpu54_tb
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


module cpu54_tb;
    reg clk; //时钟信号
    reg rst; //复位信号
    wire [31:0] inst; //要执行的指令
    wire [31:0] pc; //下一条指令的地址
    //integer file_open;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #100 rst = 1'b0;
    end
    
    always begin
        #100 clk = ~clk;
    end
    
    sccomp_dataflow dataflowtb(clk,rst,inst,pc);
    
endmodule
