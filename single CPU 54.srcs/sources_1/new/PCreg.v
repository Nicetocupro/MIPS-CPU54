`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:06:35
// Design Name: 
// Module Name: PCreg
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

module PcReg(
    input clk,
    input rst,
    input ena,
    input [31:0] PR_in,
    output [31:0] PR_out
);
    reg [31:0] PcRegister = 32'h00400000;

    always @(negedge clk or posedge rst) begin
        if (ena) begin
            if (rst) begin
                PcRegister <= 32'h00400000;
            end
            else begin
                PcRegister <= PR_in;
            end
        end
    end
    
   assign PR_out = (ena) ? PcRegister : 32'hz;
endmodule
