`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 16:58:31
// Design Name: 
// Module Name: RegFile
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

module RegFile(
    input RF_ena,
    input RF_rst,
    input RF_clk,
    input [4:0] Rdc,
    input [4:0] Rsc,
    input [4:0] Rtc,
    input [31:0] Rd,
    output [31:0] Rs,
    output [31:0] Rt,
    input RF_W
);
    reg [31:0] array_reg [31:0];
    integer i;
    always @(posedge RF_clk or posedge RF_rst) begin
        if (RF_rst & RF_ena) begin
            for (i = 0; i < 32; i = i + 1) begin
                array_reg[i] <= 32'b0;
            end
        end else if (RF_W && RF_ena && Rdc != 5'b0) begin
            array_reg[Rdc] <= Rd;
        end
    end

    // 无条件输出，移除三态逻辑
    assign Rs = (RF_ena) ? array_reg[Rsc] : 32'b0;
    assign Rt = (RF_ena) ? array_reg[Rtc] : 32'b0;
endmodule