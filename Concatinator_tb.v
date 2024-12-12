`timescale 1ps / 1ps
module Concatinator_tb;
    // Input and Output
    wire[71:0] concatinator_out;
	reg [49:0] concatinator_in;
    // Instantiate the Unit Under Test (UUT)
	Concatinator concat(
		.A(concatinator_in),
		.B(concatinator_out)
	);

    initial begin
        // Initialize clock, reset, and signals
        #50;
	concatinator_in = 49'd70;

	#50;
	concatinator_in = 49'd48;

        // Check read value from register 1
        $display(concatinator_out);

    end
endmodule
