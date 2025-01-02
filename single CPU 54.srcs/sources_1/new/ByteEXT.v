`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/15 16:23:24
// Design Name: 
// Module Name: ByteEXT
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


module ByteEXT(
    input [7:0] ByteIN,    // 8-bit byte input
    input B1,              // Control signal for sign or zero extension
    output reg [31:0] ByteOUT // 32-bit output
);

always @(*) begin
    if (B1) begin
        // Sign extension
        ByteOUT = {{24{ByteIN[7]}}, ByteIN}; // Extend the sign bit (ByteIN[7])
    end else begin
        // Zero extension
        ByteOUT = {24'b0, ByteIN};           // Extend with zeros
    end
end

endmodule

