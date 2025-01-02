`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 17:26:30
// Design Name: 
// Module Name: Control
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


module Control(
    input clk,
    input [31:0] IM_inst,
    input zero,
    input negative,
    input div_busy,
    input divu_busy,
    output [2:0] M1,
    output M2,
    output M3,
    output [1:0] M4,
    output [2:0] M5,
    output M6,
    output [2:0] M7,
    output [2:0] M8,
    output read_enalbe,
    output DM_CS,
    output DM_RW,
    output [1:0] DM_mode,
    output DM_B1,
    output DM_H1,
    output [3:0] ALUC,
    output cp0_mfc0,
    output cp0_mtc0,
    output cp0_eret,
    output [4:0] cp0_cause,
    output div_start,
    output divu_start,
    output hi_w,
    output hi_r,
    output lo_w,
    output lo_r,
    output RF_W,
    output C_EXT,
    output [4:0] Rdc,  // 源寄存器
    output [4:0] Rsc,  // 目的寄存器
    output [4:0] Rtc   // 目标寄存器或立即数指令的寄存器
    );
    //指令译码器，分析属于哪条指令。
    wire add_, addu_, sub_, subu_, and_, or_, xor_, nor_, slt_, sltu_, sll_, srl_, sra_;
    wire sllv_, srlv_, srav_, jr_, addi_, addiu_, andi_, ori_, xori_, lw_, sw_;
    wire beq_, bne_, slti_, sltiu_, lui_, j_, jal_, break_, syscall_, teq_;
    wire eret_, mfc0_, mtc0_, clz_, divu_, div_, lb_, lbu_, lhu_, lh_, sb_, sh_;
    wire mfhi_, mflo_, mthi_, mtlo_, mult_, multu_, bgez_, jalr_;
    
    Instruction_Decoder decoder(
        .instruction(IM_inst),
        .add_(add_),
        .addu_(addu_),
        .sub_(sub_),
        .subu_(subu_),
        .and_(and_),
        .or_(or_),
        .xor_(xor_),
        .nor_(nor_),
        .slt_(slt_),
        .sltu_(sltu_),
        .sll_(sll_),
        .srl_(srl_),
        .sra_(sra_),
        .sllv_(sllv_),
        .srlv_(srlv_),
        .srav_(srav_),
        .jr_(jr_),
        .addi_(addi_),
        .addiu_(addiu_),
        .andi_(andi_),
        .ori_(ori_),
        .xori_(xori_),
        .lw_(lw_),
        .sw_(sw_),
        .beq_(beq_),
        .bne_(bne_),
        .slti_(slti_),
        .sltiu_(sltiu_),
        .lui_(lui_),
        .j_(j_),
        .jal_(jal_),
        .break_(break_),
        .syscall_(syscall_),
        .teq_(teq_),
        .eret_(eret_),
        .mfc0_(mfc0_),
        .mtc0_(mtc0_),
        .clz_(clz_),
        .divu_(divu_),
        .div_(div_),
        .lb_(lb_),
        .lbu_(lbu_),
        .lhu_(lhu_),
        .lh_(lh_),
        .sb_(sb_),
        .sh_(sh_),
        .mfhi_(mfhi_),
        .mflo_(mflo_),
        .mthi_(mthi_),
        .mtlo_(mtlo_),
        .mult_(mult_),
        .multu_(multu_),
        .bgez_(bgez_),
        .jalr_(jalr_)
    );
    
    //多路选择器
    assign M1[0] = jr_ || j_ || jal_ || jalr_ || break_ || syscall_ || (teq_ & zero);//1
    assign M1[1] = (beq_ && zero) || (bne_ && !zero) || j_ || jal_ || (bgez_ && !negative);//2
    assign M1[2] = eret_ || break_ || syscall_ || (teq_ & zero);//4
    assign M2 = sll_ || srl_ || sra_ || sllv_|| srlv_ || srav_;
    assign M3 = sll_ || srl_ || sra_;
    assign M4[0] = addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || sw_ || slti_ || sltiu_ || lui_ || lb_ || lbu_ || lh_ || lhu_ || sb_ || sh_;
    assign M4[1] = bgez_;
    assign M5[0] = lw_ || clz_ || lb_ || lbu_ || lh_ || lhu_ || mfhi_;//1
    assign M5[1] = lw_ || jal_ || mfc0_ || lb_ || lbu_ || lh_ || lhu_ || jalr_;//2
    assign M5[2] = jal_ || mfhi_ || mflo_ || jalr_ ;//4
    assign M6 = jal_ || jalr_;
    assign M7[0] = div_ || mult_ ;//1
    assign M7[1] = mult_ || multu_;//2
    assign M7[2] = mtlo_;//4
    assign M8[0] = div_ || mult_;//1
    assign M8[1] = mult_ || multu_;//2
    assign M8[2] = mthi_;//4
    
    //IMEM
    assign read_enalbe = 1;
    
    //DEME
    assign DM_CS = ~(lw_ | sw_ | lb_ | lbu_ | lh_ | lhu_ | sb_ | sh_);
    assign DM_RW = sw_ | sb_ | sh_ ;
    assign DM_mode[0] = lhu_ | lh_ | sh_ ;//1
    assign DM_mode[1] = lw_ | sw_;//2
    assign DM_B1 = lb_;
    assign DM_H1 = lh_;
    
    //ALU
    assign ALUC[0] = sub_ | subu_ | or_ | nor_ | slt_ | srl_ | srlv_ | ori_ | beq_ | bne_ | slti_ | bgez_ | teq_ ;//1
    assign ALUC[1] = add_ | sub_ | xor_ | nor_ | slt_ | sltu_ | sll_ | sllv_ | addi_ | xori_ | lw_ | sw_ | slti_ | sltiu_ | lb_ | lbu_ | lh_ | lhu_ | sb_ | sh_ | bgez_;//2
    assign ALUC[2] = and_ | or_ | xor_ | nor_ | sll_ | srl_ | sra_ | sllv_ | srlv_ | srav_ | andi_ | ori_ | xori_;//4
    assign ALUC[3] = slt_ | sltu_ | sll_ | srl_ | sra_ | sllv_ | srlv_ | srav_ | slti_ | sltiu_ | lui_;//8
    
    //CP0
    assign cp0_mfc0 = mfc0_;
    assign cp0_mtc0 = mtc0_;
    assign cp0_eret = eret_;
    assign cp0_cause = syscall_ ? 5'b01000 : (break_ ? 5'b01001 : (teq_ ? 5'b01101 : 5'bz));

    //DIV
    assign div_start = ~div_busy;

    //DIVU
    assign divu_start = ~divu_busy;
    
    //HI
    assign hi_w = divu_ | div_ | mthi_ | mult_ | multu_;
    assign hi_r = mfhi_;
    
    //LO
    assign lo_w = divu_ | div_ | mtlo_ | mult_ | multu_;
    assign lo_r = mflo_;
    
    //Regfile
    assign RF_W = ~(jr_ | sw_ | beq_ | bne_| j_ | break_ | syscall_ | teq_ | eret_ | mtc0_ | divu_ | div_ | sb_ | sh_ | mthi_ | mtlo_ | mult_ | multu_ | bgez_);
    assign Rdc=	jal_ ? 5'd31: ( lb_ | lbu_ | lh_ | lhu_ | lw_ | addi_ | addiu_ | andi_ | ori_ | xori_ | lui_ | slti_ | sltiu_ | mfc0_ ) ? IM_inst[20:16] : IM_inst[15:11];
    assign Rsc = mfc0_ ? IM_inst[15:11] : IM_inst[25:21];
    assign Rtc = IM_inst[20:16];
    
    //extend
    assign C_EXT = ~(andi_ | ori_ | xori_);
    
    endmodule
