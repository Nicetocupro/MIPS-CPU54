`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:21:26
// Design Name: 
// Module Name: Instruction_Decoder
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


module Instruction_Decoder(
    input [31:0] instruction,
    output reg add_,
    output reg addu_,
    output reg sub_,
    output reg subu_,
    output reg and_,
    output reg or_,
    output reg xor_,
    output reg nor_,
    output reg slt_,
    output reg sltu_,
    output reg sll_,
    output reg srl_,
    output reg sra_,
    output reg sllv_,
    output reg srlv_,
    output reg srav_,
    output reg jr_,
    output reg addi_,
    output reg addiu_,
    output reg andi_,
    output reg ori_,
    output reg xori_,
    output reg lw_,
    output reg sw_,
    output reg beq_,
    output reg bne_,
    output reg slti_,
    output reg sltiu_,
    output reg lui_,
    output reg j_,
    output reg jal_,
    output reg break_,
    output reg syscall_,
    output reg teq_,
    output reg eret_,
    output reg mfc0_,
    output reg mtc0_,
    output reg clz_,
    output reg divu_,
    output reg div_,
    output reg lb_,
    output reg lbu_,
    output reg lhu_,
    output reg lh_,
    output reg sb_,
    output reg sh_,
    output reg mfhi_,
    output reg mflo_,
    output reg mthi_,
    output reg mtlo_,
    output reg mult_,
    output reg multu_,
    output reg bgez_,
    output reg jalr_
);

    wire [5:0] opcode = instruction[31:26];
    wire [5:0] funct = instruction[5:0];
    wire [4:0] rs = instruction[25:21];
    wire [4:0] rt = instruction[20:16];

    always @ (*) begin
        // Reset all outputs to 0
        add_ = 0;
        addu_ = 0;
        sub_ = 0;
        subu_ = 0;
        and_ = 0;
        or_ = 0;
        xor_ = 0;
        nor_ = 0;
        slt_ = 0;
        sltu_ = 0;
        sll_ = 0;
        srl_ = 0;
        sra_ = 0;
        sllv_ = 0;
        srlv_ = 0;
        srav_ = 0;
        jr_ = 0;
        addi_ = 0;
        addiu_ = 0;
        andi_ = 0;
        ori_ = 0;
        xori_ = 0;
        lw_ = 0;
        sw_ = 0;
        beq_ = 0;
        bne_ = 0;
        slti_ = 0;
        sltiu_ = 0;
        lui_ = 0;
        j_ = 0;
        jal_ = 0;
        break_ = 0;
        syscall_ = 0;
        teq_ = 0;
        eret_ = 0;
        mfc0_ = 0;
        mtc0_ = 0;
        clz_ = 0;
        divu_ = 0;
        div_ = 0;
        lb_ = 0;
        lbu_ = 0;
        lhu_ = 0;
        lh_ = 0;
        sb_ = 0;
        sh_ = 0;
        mfhi_ = 0;
        mflo_ = 0;
        mthi_ = 0;
        mtlo_ = 0;
        mult_ = 0;
        multu_ = 0;
        bgez_ = 0;
        jalr_ = 0;

        // Decode instruction
        case (opcode)
            6'b000000: begin // R-type instructions
                case (funct)
                    6'b100000: add_ = 1;
                    6'b100001: addu_ = 1;
                    6'b100010: sub_ = 1;
                    6'b100011: subu_ = 1;
                    6'b100100: and_ = 1;
                    6'b100101: or_ = 1;
                    6'b100110: xor_ = 1;
                    6'b100111: nor_ = 1;
                    6'b101010: slt_ = 1;
                    6'b101011: sltu_ = 1;
                    6'b000000: sll_ = 1;
                    6'b000010: srl_ = 1;
                    6'b000011: sra_ = 1;
                    6'b000100: sllv_ = 1;
                    6'b000110: srlv_ = 1;
                    6'b000111: srav_ = 1;
                    6'b001000: jr_ = 1;
                    6'b011010: div_ = 1;
                    6'b011011: divu_ = 1;
                    6'b011000: mult_ = 1;
                    6'b011001: multu_ = 1;
                    6'b010000: mfhi_ = 1;
                    6'b010010: mflo_ = 1;
                    6'b010001: mthi_ = 1;
                    6'b010011: mtlo_ = 1;
                    6'b001101: break_ = 1;
                    6'b001100: syscall_ = 1;
                    6'b110100: teq_ = 1;
                endcase
            end
            6'b001000: addi_ = 1;
            6'b001001: addiu_ = 1;
            6'b001100: andi_ = 1;
            6'b001101: ori_ = 1;
            6'b001110: xori_ = 1;
            6'b100011: lw_ = 1;
            6'b101011: sw_ = 1;
            6'b000100: beq_ = 1;
            6'b000101: bne_ = 1;
            6'b001010: slti_ = 1;
            6'b001011: sltiu_ = 1;
            6'b001111: lui_ = 1;
            6'b000010: j_ = 1;
            6'b000011: jal_ = 1;
            6'b100000: lb_ = 1;
            6'b100100: lbu_ = 1;
            6'b100101: lhu_ = 1;
            6'b100001: lh_ = 1;
            6'b101000: sb_ = 1;
            6'b101001: sh_ = 1;
            6'b010000: begin
                if (rs == 5'b10000 && instruction[25:21] == 5'b10000) // ERET
                    eret_ = 1;
                else if (rs == 5'b00000) // MFC0
                    mfc0_ = 1;
                else if (rs == 5'b00100) // MTC0
                    mtc0_ = 1;
            end
            6'b011100: begin
                if (funct == 6'b100000) // CLZ
                    clz_ = 1;
            end
            6'b000001: begin
                if (rt == 5'b00001) // BGEZ
                    bgez_ = 1;
            end
            6'b000000: begin
                if (funct == 6'b001001) // JALR
                    jalr_ = 1;
            end
        endcase
    end    
endmodule

