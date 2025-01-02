`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/12 16:57:32
// Design Name: 
// Module Name: DIV
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

module DIV( 
    input [31:0]dividend, 
    input [31:0]divisor,    
    input start,    
    input clock, 
    input reset, 
    output [31:0]q,    
    output [31:0]r,    
    output reg busy   
);
    reg [5:0] i;
    reg [31:0] reg_r; //余数
    reg [31:0] reg_b; //除数
    reg [31:0] reg_q; //商、被除数
   
    //符号位
    reg r_sign;
    wire [31:0] temp_r;
    // 加减法器
    wire [32:0] sub_add = r_sign ? ({reg_r , reg_q[31]} + {1'b0 , reg_b}):({reg_r , reg_q[31]} - {1'b0 , reg_b});
    
    assign temp_r = r_sign ? (reg_r + reg_b) : reg_r;
    assign r = dividend[31] ? (~temp_r + 1) : temp_r;
    assign q = (divisor[31] ^ dividend[31]) ? (~reg_q+1): reg_q;

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
                            if(dividend[31])
                                begin
                                    reg_q <= ~dividend + 1;
                                end
                            else
                                begin
                                    reg_q <= dividend;
                                end
                            if(divisor[31])
                                begin
                                    reg_b <= ~divisor + 1;
                                end
                            else
                                begin
                                    reg_b <= divisor;
                                end
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