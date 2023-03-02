module Alu (ZERO, RESULT, DATA1, DATA2, SELECT);

// port declaration
input [7:0] DATA1, DATA2;
input [2:0] SELECT;
output reg [7:0] RESULT;
output reg ZERO;

wire [7:0] ADD_OUT, FORWARD_OUT, AND_OUT, OR_OUT;


// module initializw
Forward fwd1(FORWARD_OUT, DATA2 );
Add add1(ADD_OUT, DATA1, DATA2 );
And and1(AND_OUT, DATA1, DATA2 );
Or or1(OR_OUT, DATA1, DATA2 );


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