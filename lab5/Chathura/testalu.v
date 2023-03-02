`include "alu.v"


//testbench
module testbench;

        reg [7:0] DATA1, DATA2;
        reg [2:0] SELECT;
        wire [7:0] RESULT;

        alu myALU(RESULT,DATA1,DATA2,SELECT);

        initial
        begin


        $dumpfile("testALU.vcd"); // dumping the variables
        $dumpvars(0, testbench);



        DATA1 = 'b00101100;
        DATA2 = 'b01011011;

        SELECT = 'b000;
        #5 $display("DATA1 = %d, DATA2 = %d, SELECT = %d ---->  RESULT = %d \n",DATA1, DATA2, SELECT, RESULT);


        SELECT = 'b001;
        #5 $display("DATA1 = %d, DATA2 = %d, SELECT = %d ---->  RESULT = %d \n",DATA1, DATA2, SELECT, RESULT);


        SELECT = 'b010;
        #5 $display("DATA1 = %d, DATA2 = %d, SELECT = %d ---->  RESULT = %d \n",DATA1, DATA2, SELECT, RESULT);

        SELECT = 'b011;
        #5 $display("DATA1 = %d, DATA2 = %d, SELECT = %d ---->  RESULT = %d \n",DATA1, DATA2, SELECT, RESULT);

        $finish;
        end
endmodule
