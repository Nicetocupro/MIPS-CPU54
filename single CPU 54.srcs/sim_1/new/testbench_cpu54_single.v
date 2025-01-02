`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/16 17:20:03
// Design Name: 
// Module Name: testbench_cpu54_single
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


module _246tb_ex10_tb;

	// Inputs
	reg clk_in;
	reg reset;

	// Outputs
	wire [31:0] inst;
	wire [31:0] pc;
	// Instantiate the Unit Under Test (UUT)
	sccomp_dataflow uut (
		.clk_in(clk_in), 
		.reset(reset), 
		.inst(inst),
		.pc(pc)
	);

	integer file_output , i;
	
	
initial begin
		//$dumpfile("mydump.txt");	
		//$dumpvars(0,cpu_tb.uut.pcreg.data_out);
		file_output = $fopen("_246tb_ex10_result.txt");	
		// Initialize Inputs
		clk_in = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#0.5;
      reset = 0;		
		// Add stimulus here
		
		//#100;
		//$fclose(file_output);
	end
   
	always begin		
	#0.5;	
	clk_in = ~clk_in;
	if(clk_in == 1'b1) begin	
			$fdisplay(file_output, "pc: %h", pc);	
			$fdisplay(file_output, "instr: %h", inst);
			$fdisplay(file_output, "regfile0: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[0]);
			$fdisplay(file_output, "regfile1: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[1]);
			$fdisplay(file_output, "regfile2: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[2]);
			$fdisplay(file_output, "regfile3: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[3]);
			$fdisplay(file_output, "regfile4: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[4]);
			$fdisplay(file_output, "regfile5: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[5]);
			$fdisplay(file_output, "regfile6: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[6]);
			$fdisplay(file_output, "regfile7: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[7]);
			$fdisplay(file_output, "regfile8: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[8]);
			$fdisplay(file_output, "regfile9: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[9]);
			$fdisplay(file_output, "regfile10: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[10]);
			$fdisplay(file_output, "regfile11: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[11]);
			$fdisplay(file_output, "regfile12: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[12]);
			$fdisplay(file_output, "regfile13: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[13]);
			$fdisplay(file_output, "regfile14: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[14]);
			$fdisplay(file_output, "regfile15: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[15]);
			$fdisplay(file_output, "regfile16: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[16]);
			$fdisplay(file_output, "regfile17: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[17]);
			$fdisplay(file_output, "regfile18: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[18]);
			$fdisplay(file_output, "regfile19: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[19]);
			$fdisplay(file_output, "regfile20: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[20]);
			$fdisplay(file_output, "regfile21: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[21]);
			$fdisplay(file_output, "regfile22: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[22]);
			$fdisplay(file_output, "regfile23: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[23]);
			$fdisplay(file_output, "regfile24: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[24]);
			$fdisplay(file_output, "regfile25: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[25]);
			$fdisplay(file_output, "regfile26: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[26]);
			$fdisplay(file_output, "regfile27: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[27]);
			$fdisplay(file_output, "regfile28: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[28]);
			$fdisplay(file_output, "regfile29: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[29]);
			$fdisplay(file_output, "regfile30: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[30]);
			$fdisplay(file_output, "regfile31: %h", _246tb_ex10_tb.uut.sccpu.cpu_ref.array_reg[31]);
/*
			$fdisplay(file_output, "M1 = %h", uut.sccpu.M1);
            $fdisplay(file_output, "M2 = %h", uut.sccpu.M2);
            $fdisplay(file_output, "M3 = %h", uut.sccpu.M3);
            $fdisplay(file_output, "M4 = %h", uut.sccpu.M4);
            $fdisplay(file_output, "M5 = %h", uut.sccpu.M5);
            $fdisplay(file_output, "M6 = %h", uut.sccpu.M6);
            $fdisplay(file_output, "M7 = %h", uut.sccpu.M7);
            $fdisplay(file_output, "M8 = %h", uut.sccpu.M8);
            $fdisplay(file_output, "aluc = %b", uut.sccpu.ALUC);
            $fdisplay(file_output, "D_ALU = %h", uut.sccpu.D_ALU);
            $fdisplay(file_output, "zero = %h", uut.sccpu.zero);
            $fdisplay(file_output, "negative = %h", uut.sccpu.negative);
            $fdisplay(file_output, "carry = %h", uut.sccpu.carry);
            $fdisplay(file_output, "overflow = %h", uut.sccpu.overflow);
            $fdisplay(file_output, "RF_W = %h", uut.sccpu.RF_W);
            $fdisplay(file_output, "Rdc = %d", uut.sccpu.Rdc);
            $fdisplay(file_output, "Rsc = %d", uut.sccpu.Rsc);
            $fdisplay(file_output, "Rs = %h", uut.sccpu.Rs);
            $fdisplay(file_output, "Rtc = %d", uut.sccpu.Rtc);
            $fdisplay(file_output, "Rt = %h", uut.sccpu.Rt);
            $fdisplay(file_output, "D_MUX1 = %h", uut.sccpu.D_MUX1);
            $fdisplay(file_output, "D_MUX2 = %h", uut.sccpu.D_MUX2);
            $fdisplay(file_output, "D_MUX3 = %h", uut.sccpu.D_MUX3);
            $fdisplay(file_output, "D_MUX4 = %h", uut.sccpu.D_MUX4);
            $fdisplay(file_output, "D_MUX5 = %h", uut.sccpu.D_MUX5);
            $fdisplay(file_output, "D_MUX6 = %h", uut.sccpu.D_MUX6);
            $fdisplay(file_output, "D_MUX7 = %h", uut.sccpu.D_MUX7);
            $fdisplay(file_output, "D_MUX8 = %h", uut.sccpu.D_MUX8);
            $fdisplay(file_output, "DM_addr = %d", uut.DM_addr);
            $fdisplay(file_output, "DM_wdata = %h", uut.DM_wdata);
            $fdisplay(file_output, "DM_rdata = %h", uut.DM_rdata);
            $fdisplay(file_output, "DM_cs = %h", uut.DM_cs);
            $fdisplay(file_output, "DM_rw = %h", uut.DM_rw);
            $fdisplay(file_output, "IM_addr = %b", uut.IM_addr);
            $fdisplay(file_output, "HI_dataout = %b", uut.sccpu.hi_data);
            $fdisplay(file_output, "HI_r = %b", uut.sccpu.hi_r);
            $fdisplay(file_output, "HI_w = %b", uut.sccpu.hi_w);
            $fdisplay(file_output, "HI_data = %b", uut.sccpu.hi.save);
            $fdisplay(file_output, "LO_dataout = %b", uut.sccpu.lo_data);
            $fdisplay(file_output, "LO_r = %b", uut.sccpu.lo_r);
            $fdisplay(file_output, "LO_w = %b", uut.sccpu.lo_w);
            $fdisplay(file_output, "LO_data = %b", uut.sccpu.lo.save);
            $fdisplay(file_output, "D_mul = %h", uut.sccpu.D_mul);
            $fdisplay(file_output, "CP0.cause = %b", uut.sccpu.cp0_cause);
            $fdisplay(file_output, "CP0.cp0_out = %h", uut.sccpu.cp0_out);
            $fdisplay(file_output, "CP0.cp0_epcout = %h", uut.sccpu.epc_out);
            $fdisplay(file_output, "CP0.cp0[cause] = %h", uut.sccpu.cp0.cp0_reg[13]);
            $fwrite(file_output, "\n");
*/
/*
            for (i = 0; i < 150; i = i + 1) begin
                $fdisplay(file_output, "D_mem[%0d] = %h", i, uut.dmemory.D_mem[i]);  // ´òÓ¡ÄÚ´æÄÚÈÝ
            end
            $fwrite(file_output, "\n");
*/
		end
	end
endmodule
