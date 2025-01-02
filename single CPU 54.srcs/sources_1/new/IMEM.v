`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 16:11:35
// Design Name: 
// Module Name: IMEM
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

module IMEM(
    input [10:0] address,
    input read_enable,
    output [31:0] instruction
    );
    dist_mem_gen_0 instr_mem(
            .a(address),
            .spo(instruction),
            .qspo_ce(read_enable)
        );
endmodule
