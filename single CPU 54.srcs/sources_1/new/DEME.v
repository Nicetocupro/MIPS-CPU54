`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 16:24:12
// Design Name: 
// Module Name: DEME
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


module DMEM(
    input clk,
    input cs,
    input rw,
    input [1:0] mode,          // 00: byte, 01: half-word, 10: word
    input [10:0] DM_addr,      //字节输入
    input [31:0] DM_wdata,
    input B1,                  // Control signal for sign or zero extension
    input H1,
    output reg [31:0] DM_rdata // 修改为reg类型，因为需要在always块中赋值
);

    reg [31:0] D_mem[0:2047];  // 扩展内存大小以匹配11位地址
    wire [31:0] extended_data;
    wire [9:0] word_addr = DM_addr[10:2]; // 字地址，忽略最低两位
    wire [1:0] byte_offset = DM_addr[1:0]; // 字节偏移

    // Create instances of ByteEXT and HalfEXT
    wire [31:0] half_ext_out;
    wire [31:0] byte_ext_out;
    
    ByteEXT byte_ext_inst (
        .ByteIN(D_mem[word_addr][byte_offset*8 +: 8]),
        .B1(B1),
        .ByteOUT(byte_ext_out)
    );
    
    HalfEXT half_ext_inst (
        .HalfIN(byte_offset[1] ? D_mem[word_addr][31:16] : D_mem[word_addr][15:0]),
        .H1(H1),
        .HalfOUT(half_ext_out)
    );

    always @(posedge clk) begin
        if (!cs) begin  // 仅在芯片选中时进行操作
            if (rw) begin
                case (mode)
                    2'b00: begin // Byte write
                        case (byte_offset)
                            2'b00: D_mem[word_addr][7:0] <= DM_wdata[7:0];
                            2'b01: D_mem[word_addr][15:8] <= DM_wdata[7:0];
                            2'b10: D_mem[word_addr][23:16] <= DM_wdata[7:0];
                            2'b11: D_mem[word_addr][31:24] <= DM_wdata[7:0];
                        endcase
                    end
                    2'b01: begin // Half-word write
                        if (byte_offset[1] == 1'b0) begin
                            D_mem[word_addr][15:0] <= DM_wdata[15:0];
                        end else begin
                            D_mem[word_addr][31:16] <= DM_wdata[15:0];
                        end
                    end
                    2'b10: // Word write
                        D_mem[word_addr] <= DM_wdata;
                endcase
            end
        end
    end

    always @(*) begin
        if (!cs) begin
            if (!rw) begin
                case (mode)
                    2'b00: // Byte read with extension
                        DM_rdata = byte_ext_out;
                    2'b01: // Half-word read with extension
                        DM_rdata = half_ext_out;
                    2'b10: // Word read
                        DM_rdata = D_mem[word_addr];
                    default:
                        DM_rdata = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
                endcase
            end else begin
                DM_rdata = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
            end
        end
    end

endmodule
