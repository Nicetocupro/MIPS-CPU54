`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/19 12:06:16
// Design Name: 
// Module Name: mux5
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


module mux5(
    input [4:0] a,
    input [4:0] b,
    input choose,
    output reg [4:0] z
);
    always @(*) begin
        case (choose)
            1'b1: z = b;
            1'b0: z = a;
            default: z = 4'bx;
        endcase
    end
endmodule
