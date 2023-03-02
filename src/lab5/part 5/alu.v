`include "mymul.v"

module Alu (ZERO, RESULT, DATA1, DATA2, SELECT, SLL);

// port declaration
input [7:0] DATA1, DATA2;
input [2:0] SELECT;
output reg [7:0] RESULT;
output  ZERO;
input SLL;



wire [7:0] ADD_OUT, FORWARD_OUT, AND_OUT, OR_OUT, SLL_OUT, SRL_OUT, SRA_OUT, ROR_OUT, MUL_OUT;


// module initialize
Forward fwd1(FORWARD_OUT, DATA2 );
Add add1(ADD_OUT, DATA1, DATA2 );
And and1(AND_OUT, DATA1, DATA2 );
Or or1(OR_OUT, DATA1, DATA2 );
sll slll1(SLL_OUT, DATA1, DATA2);
srl srl1(SRL_OUT, DATA1, DATA2);
sra sra1(SRA_OUT, DATA1, DATA2);
ror ror1(ROR_OUT, DATA1, DATA2);
multi mul1(MUL_OUT, DATA1, DATA2);



assign ZERO = ~(RESULT[0]|RESULT[1]|RESULT[2]|RESULT[3]|RESULT[4]|RESULT[5]|RESULT[6]|RESULT[7]);


always @(*) begin //always @(*) begin
    
    
    
      
    case (SELECT)
        'b000:
            RESULT = FORWARD_OUT;
        'b001:
            RESULT = ADD_OUT; 
        'b010:
            RESULT = AND_OUT; 
        'b011:
            RESULT = OR_OUT; 
        'b100:
            RESULT = MUL_OUT; 
        'b101:
            begin
                if(SLL) RESULT = SLL_OUT;
                else RESULT = SRL_OUT;
            end
        'b110:
            RESULT = SRA_OUT; 
        'b111:
            RESULT = ROR_OUT; 
        default:
            RESULT = 'b00000000;

    endcase

end


endmodule

// arithmatic modules

module Forward (FORWARD_OUT, DATA2);
    input [7:0]  DATA2;
    output [7:0] FORWARD_OUT;
    assign #1 FORWARD_OUT =  DATA2; 
    
endmodule

module Add (ADD_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] ADD_OUT;
    assign #2  ADD_OUT =  DATA1+DATA2; 
    
endmodule

module And (AND_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] AND_OUT;
    assign #1 AND_OUT =  DATA1 & DATA2; 
    
endmodule

module Or (OR_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] OR_OUT;
    assign  #1 OR_OUT =  DATA1 | DATA2; 
    
endmodule

module sra ( SRA_OUT, DATA1, DATA2 ); // arithmatic right shift
    input [7:0] DATA1, DATA2;
    output [7:0] SRA_OUT;
    reg [7:0] shifted;
    integer i,j;
    
    initial begin
        #1
        shifted = DATA1;  //copy data1
        
        for(i=0;i<DATA2;i=i+1)begin
            
            for(j=0;j<7;j=j+1)begin
                
                shifted[j]=shifted[j+1]; //one right arithmatic shift bit
            end
            shifted[7]=shifted[6];
        end
            
    end
    assign #1 SRA_OUT = shifted;
    
endmodule

module ror (ROR_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] ROR_OUT;
    reg [7:0] shifted;
    integer i,j;
    reg temp; 
    initial begin
        #1
        shifted = DATA1;  //copy data1
        for(i=0;i<DATA2;i=i+1)begin
            temp = shifted[0];  //memorize last bit
            for(j=0;j<7;j=j+1)begin
                shifted[j]=shifted[j+1]; //one right rotate shift bit
            end
            shifted[7]=temp;
        end
    end
    assign #1 ROR_OUT = shifted;
endmodule

module sll (SLL_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] SLL_OUT;
    reg [7:0] shifted;
    integer i,j;

    initial begin
        #1
        shifted = DATA1; //copy data1
        for(i=0;i<DATA2;i=i+1)begin
            for(j=7;j>0;j=j-1)begin
                shifted[j]=shifted[j-1]; // one left shift bit
            end
            shifted[0]=1'b0;
        end
    end
    assign #1 SLL_OUT = shifted;
endmodule

module srl (SRL_OUT, DATA1, DATA2);
    input [7:0] DATA1, DATA2;
    output [7:0] SRL_OUT;
    reg [7:0] shifted;
    integer i,j;

    initial begin
        #1
        shifted = DATA1;  //copy data1
        for(i=0;i<DATA2;i=i+1)begin
            for(j=0;j<7;j=j+1)begin
                shifted[j]=shifted[j+1];   //one right shift bit
            end
            shifted[7]=1'b0;
        end
    end
    assign #1  SRL_OUT = shifted;
    
endmodule

// module mult (MUL_OUT, DATA1, DATA2);
//     input [7:0] DATA1, DATA2;
//     output [7:0] MUL_OUT;
//     assign #1  MUL_OUT = DATA1 * DATA2; 
// endmodule