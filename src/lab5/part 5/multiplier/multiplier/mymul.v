`include "multiplier.v"

// main mutiplication module
module multi (MUL_OUT, DATA1, DATA2);

// port declaration
input  [7:0] DATA1 ,DATA2; 
output reg[7:0] MUL_OUT;

// wires for the internal implementation
wire MSB;
wire[6:0] data1, data2, comp;
wire[7:0] val, NEWD1, NEWD2;

// module initiating
xor x1(MSB, DATA1[7], DATA2[7]);

// getting two s complement values of initial values
twos_comp tc1(data1, DATA1[6:0]);
twos_comp tc2(data2, DATA2[6:0]);

// cotroller for multiplier
ctrl ct(NEWD1, NEWD2, DATA1, DATA2, MSB, data1, data2);

multiplier m1(val, NEWD1, NEWD2);

// getting twos complement value of  final result
// in case of ehrn we have to represent minus value (positive numbet * negative number)
twos_comp tc4(comp, val[6:0]);




always @(*) begin
  #2
  // check weather the one of the 
  if (DATA1 == 0 || DATA2 == 0) begin
     MUL_OUT = 8'b0;
        
  end
  else begin
   if (!MSB) begin // positive output 
  // 1. positive val * positive val
  // 2. negative val * negative val
        MUL_OUT = {1'b0, {val[6:0]}};
   end
        
   else begin // negative output
  // 1. positive val * negative val
  // 2. negative val * positive val
        MUL_OUT = {1'b1, comp};
   end
   
end
end

    
endmodule


// 2s complement generator
module twos_comp (OUTPUT, INPUT);
  
  // port declaration
    input[6:0] INPUT;
    output[6:0] OUTPUT;

    // output
    assign   OUTPUT = ~INPUT+1;
       
endmodule



module ctrl (ND1, ND2, DATA1, DATA2, MSB, data1, data2);

// port declaration
input  [7:0] DATA1 ,DATA2;
input MSB; 
input [6:0] data1, data2;
output reg  [7:0] ND1, ND2;


// according to the sign of input making absolute valueas as inputs for the multiplier
always @(*) begin
  #1
  
   if (!MSB) begin // both inputs are negative or postive

     if (DATA1[7]) begin // both are negative
         ND1 = {1'b0,data1}; 
         ND2 = {1'b0, data2};
     end
     else begin // both are positive
          ND1 = {1'b0,DATA1[6:0]};
         ND2 = {1'b0, DATA2[6:0]};
     end
        
       
   end
   
   else begin //  when an input is negative

       if (DATA1[7]) begin // 1st input is negative
         ND1 = {1'b0,data1};
         ND2 = DATA2;

       end
       else begin // 2nd input is negative
         ND1 = DATA1;
         ND2 = {1'b0, data2};
       end
   end
  
end

endmodule
