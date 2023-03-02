`include "alu.v"

module testbench ;
    reg [7:0] DATA1, DATA2 ;
    reg [2:0] SELECT;
    wire [7:0] RESULT;
    wire zero;
    wire SLL;


Alu alu(zero, RESULT, DATA1, DATA2, SELECT, SLL);
initial begin 
    $dumpfile("wavedata.vcd");
    $dumpvars(0, testbench);

    DATA1=  5;
    DATA2 = 3;


SELECT = 4;
#5       $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", $signed(DATA1), $signed(DATA2), SELECT, $signed(RESULT));


// SELECT = 5;
// #5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", $signed(DATA1), $signed(DATA2), SELECT, $signed(RESULT));

// SELECT = 2;
// #5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", $signed(DATA1), $signed(DATA2), SELECT, $signed(RESULT));

// SELECT = 6;
// #5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", $signed(DATA1), $signed(DATA2), SELECT, $signed(RESULT));
// SELECT = 7;
// #5      $display("DATA1= %d, DATA2= %d, SELECT= %d, RESULT =%d", $signed(DATA1), $signed(DATA2), SELECT, $signed(RESULT));


$finish;
end
   
endmodule