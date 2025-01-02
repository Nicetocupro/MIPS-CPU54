`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 16:49:47
// Design Name: 
// Module Name: DIVU
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
module DIVU(
    input [31:0] dividend,  // 被除数
    input [31:0] divisor,   // 除数
    input start,            // 启动除法运算
    input clock,
    input reset,            // 高电平有效复位
    output [31:0] q,    // 商
    output [31:0] r,    // 余数
    output reg busy         // 除法器忙标志位
);
    reg [5:0] i;
    reg [31:0] reg_r; //余数
    reg [31:0] reg_b; //除数
    reg [31:0] reg_q; //商、被除数
    
    //符号位
    reg r_sign;
    // 加减法器
    wire [32:0] sub_add = r_sign ? ({reg_r , q[31]} + {1'b0 , reg_b}):({reg_r , q[31]} - {1'b0 , reg_b});
    assign r = r_sign ? reg_r + reg_b : reg_r;
    assign q = reg_q;
    
    always @ (posedge clock or posedge reset)
        begin 
            if (reset) 
                begin  
                    i <= 0;
                    busy <= 0; 
                end 
            else 
                begin 
                    if (start && !busy) 
                        begin  
                            //重置 
                            //开始除法运算，初始化 
                            reg_r <= 32'b0; 
                            r_sign <= 0; 
                            reg_q <= dividend; 
                            reg_b <= divisor; 
                            i <= 0;
                            busy <= 1'b1; 
                        end 
                    else if (busy)
                        begin     
                            reg_r <= sub_add[31:0];     
                            r_sign <= sub_add[32];      
                            reg_q <= {reg_q[30:0],~sub_add[32]};
                            i <= i + 1;
                            if (i == 31) 
                                begin
                                    busy <= 0;     
                                end
                        end 
                end 
        end 
endmodule
