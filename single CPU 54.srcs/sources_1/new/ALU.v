`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/18 16:34:12
// Design Name: 
// Module Name: ALU
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
module ALU(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
);
always @(*) begin
carry = 0;
    overflow = 0;
    case(aluc)
        4'd0://addu
            begin
                {carry , r} = a + b;
                if(r[31] == 1)
                    begin
                        negative = 1;
                    end
                else
                    begin
                        negative = 0;
                    end
                zero=(r==0)?1:0;
            end
        4'd2://add
            begin
                r = a + b;
                overflow = ((a[31]==b[31])&&(~r[31]==a[31])) ? 1 : 0;
                if(($signed(a) + $signed(b)) >= 0)
                    begin
                        negative = 0;
                    end
                else
                    begin
                        negative = 1;
                    end
                zero=(r==0)?1:0;
            end
        4'd1://subu
            begin
                {carry , r} = a - b;
                zero=(r==0)?1:0;
                overflow=0;
                if(r[31] == 1)
                    begin
                        negative = 1;
                    end
                else
                    begin
                        negative = 0;
                    end
            end
        4'd3://sub
            begin
                r = a - b;
                overflow=((a[31]==0&&b[31]==1&&r[31]==1)||(a[31]==1&&b[31]==0&&r[31]==0))?1:0;
                zero=(a==b)?1:0;
                negative = ($signed(a) - $signed(b)) >= 0 ? 0 : 1;
            end
        4'd4://and
            begin
                r = a & b;
                zero=(r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0; 
            end
        4'd5://or
            begin
                r = a | b;
                zero=(r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0; 
            end
        4'd6://xor
            begin
                r = a ^ b;
                zero=(r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0; 
            end
        4'd7://nor
            begin
                r = ~ (a | b);
                zero=(r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0;
            end
        4'd8://Lui
            begin
                r = {b[15:0] , 16'b0};
                //r = 31'b0;
                //r[31:16] = b[15:0];
                zero=(r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0; 
            end
        4'd9://Lui
                begin
                    r = {b[15:0] , 16'b0};
                    //r = 31'b0;
                    //r[31:16] = b[15:0];
                    zero=(r == 0) ? 1 : 0;
                    negative = r[31] ? 1 : 0; 
                end
        4'd11://SLT
            begin
                if( a[31] == 1 && b[31] == 0)
                    begin
                        r = 1;
                    end
                else if(a[31] == 0 && b[31] == 1)
                    begin
                        r = 0;
                    end
                else
                    begin
                        r = (a < b) ? 1 : 0;                            
                    end
                overflow = r; 
                zero = ($signed(a) - $signed(b) == 0) ? 1 : 0;
                negative = ($signed(a - b) < 0) ? 1 : 0; 
            end
        4'd10://SLTU
            begin
                r = (a < b ) ? 1 : 0;
                carry = r;
                zero = (a - b) == 0 ? 1 : 0;
                negative = r[31] ? 1 : 0;
            end
        4'd12://SRA
            begin
                r =($signed( b )) >>> a;
                if(a == 0)
                    begin
                        carry = 0;
                    end
                else
                    begin
                        carry = b[a - 1];            
                    end
                zero = (r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0;
            end
        4'd14://sll
            begin
                {carry , r} = b << a;
                zero = (r == 0) ? 1 : 0;                   
                negative = r[31] ? 1 : 0;
            end
        4'd15://sll
                begin
                    {carry , r} = b << a;
                    zero = (r == 0) ? 1 : 0;                   
                    negative = r[31] ? 1 : 0;
                end
        4'd13:
            begin
                r = b >> a;
                if(a == 0)
                    begin
                        carry = 0;
                    end
                else
                    begin
                        carry = b[a - 1];            
                    end
                zero = (r == 0) ? 1 : 0;
                negative = r[31] ? 1 : 0;
            end
    endcase
end
endmodule
