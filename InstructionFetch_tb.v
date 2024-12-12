`timescale 1ps / 1ps

module InstructionFetch_tb;

    // Inputs
	reg clk, rst;
    reg [71:0] address;

    // Outputs
    wire [71:0] instruction;

    // Instantiate the Unit Under Test (UUT)
    InstructionFetch uut (
        .clk(clk),
		.reset(rst),
		.address(address),
        .instruction(instruction)
    );

    // Clock generation (toggle every 50 time units)
    initial begin
        clk = 0;
		forever #50 clk = ~clk;  // Toggle clock every 50 time units (50ps)
    end
	
    // Testbench variables
    integer i;

    initial begin
		// Display header
        $display("Time\tAddress\t\tInstruction");

        // Initialize address to 0
        address = 72'b0;

        // Test fetching multiple instructions
        for (i = 0; i < 10; i = i + 1) begin
            #100; // Wait for 50 time units
            $display("%0t\t%b\t%b", $time, address, instruction);
            address = address + 1; // Increment PC by 9 bytes (72 bits)
        end

        // End simulation
        #50;
        $stop;
    end
endmodule
