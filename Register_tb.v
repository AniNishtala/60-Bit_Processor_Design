// testing Register.v file
`timescale 1ps / 1ps

module Register_tb;

    // Inputs
    reg write;              // Write enable signal
    reg clk;                // Clock signal
    reg reset;              // Reset signal
    reg [9:0] reg1_address; // Address for first register to read (updated for 1024 registers)
    reg [9:0] reg2_address; // Address for second register to read (updated for 1024 registers)
    reg [9:0] reg_r_address; // Address for register to write to (updated for 1024 registers)
    reg [71:0] result_in;    // Data to write into the register

    // Outputs
    wire [71:0] data_out1;   // Data output from first register
    wire [71:0] data_out2;   // Data output from second register

    // Instantiate the Unit Under Test (UUT)
    Register uut (
        .write(write),
        .clk(clk),
        .reset(reset),
        .reg1_address(reg1_address),
        .reg2_address(reg2_address),
        .reg_r_address(reg_r_address),
        .result_in(result_in),
        .data_out1(data_out1),
        .data_out2(data_out2)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Testbench variables
    integer i;

    initial begin
        // Initialize clock, reset, and signals
        clk = 0;
        reset = 1;
        write = 0;
        reg1_address = 10'b0;  // Updated for 1024 registers
        reg2_address = 10'b0;  // Updated for 1024 registers
        reg_r_address = 10'b0; // Updated for 1024 registers
        result_in = 0;

        // Reset the system
        #10;
        reset = 0;  // Release reset

        // Write random data to register 0
        #10;
        write = 1;
        reg_r_address = 10'b0000000000;  // Register 0
        result_in = { $random, $random };  // Generate a random 72-bit value (2 random 32-bit values)
        #10;
        write = 0;  // Disable write

        // Read data from register 0
        #10;
        reg1_address = 10'b0000000000;  // Address of register 0
        #10;

        // Check read value from register 0
        $display("Cycle %0t: Read data from reg1_address: %h", $time, data_out1);

        // Write random data to register 1
        #10;
        write = 1;
        reg_r_address = 10'b0000000001;  // Register 1
        result_in = { $random, $random };  // Generate a random 72-bit value (2 random 32-bit values)
        #10;
        write = 0;  // Disable write

        // Read data from register 1
        #10;
        reg2_address = 10'b0000000001;  // Address of register 1
        #10;

        // Check read value from register 1
        $display("Cycle %0t: Read data from reg2_address: %h", $time, data_out2);

        // End simulation
        #10;
        $stop;
    end
endmodule
