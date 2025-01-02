`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/16 15:29:34
// Design Name: 
// Module Name: CPU54
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


module CPU54(
    input clk,
    input ena,
    input rst,
    input [31:0] IM_inst,
    input [31:0] DM_rdata,
    output DM_cs,
    output DM_rw,
    output [1:0] DM_mode,
    output DM_B1,
    output DM_H1,
    output [31:0] DM_wdata,
    output IM_R,
    output [31:0] PC_out,
    output [31:0] address
    );
    
    // 多路选择器
    wire [2:0] M1;
    wire       M2;
    wire       M3;
    wire [1:0] M4;
    wire [2:0] M5;
    wire       M6;
    wire [2:0] M7;
    wire [2:0] M8;
    wire [31:0] D_MUX1;
    wire [31:0] D_MUX2;
    wire [4:0] D_MUX3;
    wire [31:0] D_MUX4;
    wire [31:0] D_MUX5;
    wire [31:0] D_MUX6;
    wire [31:0] D_MUX7;
    wire [31:0] D_MUX8;
    
    // PC寄存器相关内容
    wire PC_CLK; // PC信号
    wire PC_ENA;//PC使能信号
    wire [31:0] D_PC; //PC输出信号
    assign PC_ENA = 1;
    assign PC_out = D_PC;
    
    // ALU信号
    wire [3:0] ALUC;//ALU控制信号
    wire [31:0] D_ALU;//ALU输出信号
    wire zero , carry , negative , overflow;//ALU其他信号
    
    // RegFile 信号
    wire RF_W;//寄存器堆读写信号
    wire [4:0] Rdc;
    wire [4:0] Rsc;
    wire [4:0] Rtc;
    wire [31:0] Rs;
    wire [31:0] Rt;
    
    //扩展位输出信号
    wire [31:0] D_EXT5;
    wire [31:0] D_EXT16;
    wire [31:0] D_EXT18;
    wire C_EXT; //控制是否进行符号扩展
    wire [17:0] shifted_input = {IM_inst[15:0], 2'b00};// inst[15:0] 左移两位，低位补0
    
    //ADD
    wire [31:0] D_ADD;
    wire add_overflow;
    
    //NPC
    wire [31:0] D_NPC;
    
    //II
    wire [31:0] D_II;
    
    //CLZ
    wire [31:0] D_CLZ;

    //CP0
    wire cp0_mfc0;
    wire cp0_mtc0;
    wire cp0_eret;
    wire [4:0] cp0_cause;
    wire [31:0] cp0_out;
    wire [31:0] epc_out;
    
    //DIV
    wire div_busy;
    wire div_start;
    wire [31:0] D_div_q;
    wire [31:0] D_div_r;
    
    //DIVU
    wire divu_busy;
    wire divu_start;
    wire [31:0] D_divu_q;
    wire [31:0] D_divu_r;
    
    //HI
    wire hi_w;
    wire hi_r;
    wire [31:0] hi_data;
    
    //LO
    wire lo_w;
    wire lo_r;
    wire [31:0] lo_data;
    
    //MUL
    wire [63:0] D_mul;
    //mulu
    wire [63:0] D_mulu;
    
    //DMEM 和IMEM
    assign address = D_ALU;
    assign DM_wdata = Rt;
    
    //指令译码器 + 控制器
    Control Ctrl(clk, IM_inst, zero, negative, div_busy, divu_busy, M1, M2, M3, M4, M5, M6, M7, M8, read_enable, DM_cs, DM_rw, DM_mode, DM_B1, DM_H1, ALUC, cp0_mfc0, cp0_mtc0, cp0_eret, cp0_cause, div_start, divu_start, hi_w, hi_r, lo_w, lo_r, RF_W, C_EXT, Rdc, Rsc, Rtc);

    //mux多路选择器
    mux8 mux1(D_NPC , Rs , D_ADD , D_II , epc_out , 32'h00400004 , 32'bx , 32'bx , M1 , D_MUX1);
    mux mux2(Rs , D_EXT5 , M2 , D_MUX2);
    mux5 mux3(Rs[4:0] , IM_inst[10:6] , M3 , D_MUX3);
    mux4 mux4(Rt , D_EXT16 , 32'd0 , 32'bx , M4 , D_MUX4);
    mux8 mux5(D_ALU , D_CLZ , cp0_out , DM_rdata , lo_data , hi_data , D_ADD , 32'bx , M5 , D_MUX5);
    mux mux6(D_EXT18 , 32'd0 , M6 , D_MUX6);
    mux8 mux7(D_divu_q , D_div_q , D_mulu[31:0] , D_mul[31:0] , Rs , 32'bx , 32'bx , 32'bx , M7 , D_MUX7);
    mux8 mux8(D_divu_r , D_div_r , D_mulu[63:32] , D_mul[63:32] , Rs , 32'bx , 32'bx , 32'bx , M8 , D_MUX8);
    
    //PC寄存器
    PcReg pc(clk , rst , PC_ENA , D_MUX1 , D_PC);
    
    //alu
    ALU alu(D_MUX2 , D_MUX4 , ALUC , D_ALU , zero , carry , negative , overflow);
    
    //RegFile
    RegFile cpu_ref(ena , rst , ~clk , Rdc , Rsc , Rtc , D_MUX5 , Rs , Rt , RF_W);
    
    //数据扩展
    extend #(.WIDTH(5)) extend5(D_MUX3 ,1'd0 , D_EXT5);
    extend #(.WIDTH(16)) extend16(IM_inst[15:0] , C_EXT , D_EXT16);
    extend #(.WIDTH(18)) extend18(shifted_input , 1'd1 , D_EXT18);
    
    //add
    add add(D_NPC , D_MUX6 , D_ADD , add_overflow);
    
    //npc
    npc npc(D_PC , rst , D_NPC);
    
    //II
    II II(D_PC[31:28] , IM_inst[25:0] , D_II);
    
    //CLZ
    CLZ CLZ(Rs , D_CLZ);
    
    //CP0
    CP0 cp0(clk , rst , ena , cp0_mfc0 , cp0_mtc0 , cp0_eret , D_NPC , Rs , cp0_cause , Rt , cp0_out , epc_out);
    
    //DIV
    DIV div(Rs , Rt , div_start , clk , rst , D_div_q , D_div_r , div_busy);
    
    //DIVU
    DIVU divu(Rs , Rt , divu_start , clk , rst , D_divu_q , D_divu_r , divu_busy);
    
    //HI
    HI hi(clk , rst , D_MUX8 , hi_w , hi_r , hi_data);
    
    //LO
    LO lo(clk , rst , D_MUX7 , lo_w , lo_r , lo_data);
    
    //MUL
    MUL mul(Rs , Rt , D_mul);
    
    //MULU
    MULU mulu(Rs , Rt , D_mulu);
endmodule
