`timescale 1ps / 1ps

module InstructionFetch_tb;

    // Inputs
    reg [71:0] address;

    // Outputs
    wire [71:0] instruction;

    // Instantiate the Unit Under Test (UUT)
    InstructionFetch uut (
        .address(address),
        .instruction(instruction)
    );

    // Testbench variables
    integer i;

    initial begin
        // Display header
        $display("Time\tAddress\t\tInstruction");

        // Initialize address to 0
        address = 72'b0;

        // Test fetching multiple instructions
        for (i = 0; i < 10; i = i + 1) begin
            #10; // Wait for 10 time units
            $display("%0t\t%h\t%h", $time, address, instruction);
            address = address + 9; // Increment PC by 9 bytes (72 bits)
        end

        // End simulation
        #10;
        $stop;
    end
endmodule
