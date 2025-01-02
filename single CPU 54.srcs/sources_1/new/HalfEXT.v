`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 16:23:45
// Design Name: 
// Module Name: HalfEXT
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


module HalfEXT(
    input [15:0] HalfIN,   // 16-bit half-word input
    input H1,              // Control signal for sign or zero extension
    output reg [31:0] HalfOUT // 32-bit output
);

always @(*) begin
    if (H1) begin
        // Sign extension
        HalfOUT = {{16{HalfIN[15]}}, HalfIN}; // Extend the sign bit (HalfIN[15])
    end else begin
        // Zero extension
        HalfOUT = {16'b0, HalfIN};            // Extend with zeros
    end
end

endmodule

