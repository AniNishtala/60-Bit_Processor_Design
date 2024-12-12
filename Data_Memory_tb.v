`timescale 1ps/1ps
module Data_Memory_tb;

    reg clk;
    reg reset;
    reg write_enable;
    reg [54:48] register_destination_address;
    reg [71:0] ALU_Result;
    integer i;

    // Instantiate the Data_Memory module
    Data_Memory uut(
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .register_destination_address(register_destination_address),
        .ALU_Result(ALU_Result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 ps
    end

    // Test logic
    initial begin
        // Initialize inputs
        reset = 1;
        write_enable = 0;
        register_destination_address = 7'b0; // Initialize to 0
        ALU_Result = 72'h0;

        // Release reset after 10 ps
        #10 reset = 0;

        // Write data to memory for the first 10 addresses
        for (i = 0; i < 10; i = i + 1) begin
            #10 write_enable = 1;
            register_destination_address = i[6:0]; // Assign 7-bit address
            ALU_Result = 72'hA * i; // Example data
            #10 write_enable = 0; // Deassert write_enable
        end
	#50
        // Access line 6
        #10 $display("Reading back line 6:");
        #10 $display("Line 6 Data: %h", uut.datamemory[6]);

        // Finish simulation
        #100 $stop;
    end
endmodule
