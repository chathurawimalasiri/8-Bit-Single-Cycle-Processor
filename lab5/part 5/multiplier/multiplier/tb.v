`include "multiplier.v"

module testbench;
	
	reg [7:0] input1,input2;
	wire [7:0]result;
	
	multiplier m1(result,input1,input2);
	
	initial // instruction array
    begin
      // generate files needed to plot the waveform using GTKWave
      $dumpfile("multi_wave.vcd");
      $dumpvars(0, testbench);
      $monitor("input1 = %d, input = %d  , result = %d",input1,input2,result);
    end
	
	initial 
    begin
	
		input1 = 8'd50;
		input2 = 8'd2;
		
		#8
		input2 = 8'd3;
		
	  
        #20
        $finish;
    end

endmodule