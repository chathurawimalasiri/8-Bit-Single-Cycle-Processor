`include "DADDA_Multiplier.v"

module multi (MUL_OUT, DATA1, DATA2);
input  [7:0] DATA1 ,DATA2; // input signed ?
output reg[7:0] MUL_OUT;
wire MSB;
wire[6:0] data1, data2, dada2comp, dada3comp;
wire[15:0] dada_out1, dada_out2, dada_out3,dada_out4;
wire[7:0] da1, da2;


myxor x1(MSB, DATA1[7], DATA2[7]);
twos_comp tc1(data1, DATA1[6:0]);
twos_comp tc2(data2, DATA2[6:0]);
DADDA_Multiplier d1({1'b0,DATA1[6:0]},{1'b0, DATA2[6:0]}, dada_out1);
DADDA_Multiplier d2(da1, DATA2, dada_out2);
DADDA_Multiplier d3(DATA1, da2, dada_out3);
DADDA_Multiplier d4(da1,da2, dada_out4);
concat c1(da1, data1);
concat c2(da2, data2);
twos_comp tc4(dada2comp, dada_out2[6:0]);
twos_comp tc3(dada3comp, dada_out3[6:0]);




initial begin
  #3
   if (!MSB) begin
     if (DATA1[7]) begin
        MUL_OUT = {1'b0, {dada_out4[6:0]}};
     end
     else begin 
        MUL_OUT = {1'b0, {dada_out1[6:0]}};
     end
        
       
   end
   else begin
       if (DATA1[7]) begin
         MUL_OUT = {MSB, {dada2comp}};


       end
       else begin
         MUL_OUT = {MSB, {dada3comp}};
       end
   end
   
end
//assign #1 d1[0] = DATA1[0];
    
endmodule


// 2s complement generator
module twos_comp (OUTPUT, INPUT);
    input[6:0] INPUT;
    output[6:0] OUTPUT;
    assign #1  OUTPUT = ~INPUT+1;
       
endmodule

module myxor (OUT, IN1, IN2);
  input IN1, IN2;
  output OUT;
  assign OUT = IN1 ^ IN2;
endmodule


module concat (OUT, IN);
input[6:0] IN;
output[7:0] OUT;
assign OUT =  {1'b0,IN};
endmodule