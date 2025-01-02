`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 11:07:13
// Design Name: 
// Module Name: mux
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


module mux(
    input [31:0] a,
    input [31:0] b,
    input choose,
    output reg [31:0] z
);
    always @(*) begin
        case (choose)
            1'b1: z = b;
            1'b0: z = a;
            default: z = 32'bx;
        endcase
    end
endmodule