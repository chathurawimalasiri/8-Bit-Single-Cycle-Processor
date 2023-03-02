`include "alu.v"

module testbench ;
    reg [7:0] DATA1, DATA2 ;
    reg [2:0] SELECT;
    wire [7:0] RESULT;


Alu alu(RESULT, DATA1, DATA2, SELECT);
initial begin 
    $dumpfile("wavedata.vcd");
    $dumpvars(0, testbench);

    DATA1=  17;
    DATA2 = 5;


SELECT = 0;
#5       $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);

SELECT = 1;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);

SELECT = 2;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);

SELECT = 3;
#5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", DATA1, DATA2, SELECT, RESULT);


$finish;
end
   
endmodule