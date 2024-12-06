`timescale 1ps/1ps
module ALU_TB;
    // Declare registers for inputs and wires for output
    reg clk;
    reg [3:0] op;          // 4-bit operation input
    reg [71:0] A, B;       // 72-bit inputs
    wire [71:0] C;         // 72-bit output

    // Instantiate the Register module
    ALU uut (
        .clk(clk),
        .op(op),
        .A(A),
        .B(B),
        .C(C)
    );

    // Clock generation (period 10 time units)
    always begin
        #50 clk = ~clk;  // Toggle the clock every 5 time units 10Ghz processor speed if math is correct
    end

    // Apply test vectors
    initial begin
        // Initialize the clock
        clk = 0;

        // Test case 1: Addition (op = 0)
        A = 72'h000000000000000001;
        B = 72'h000000000000000001;
        op = 4'b000;   // A + B
        #100; // Wait for 1 clock cycle

        // Test case 2: Subtraction (op = 1)
        A = 72'h000000000000000010;
        B = 72'h000000000000000005;
        op = 3'b001;   // A - B
        #100; // Wait for 1 clock cycle

        // Test case 3: Multiplication (op = 2)
        A = 72'h000000000000000003;
        B = 72'h000000000000000002;
        op = 4'b010;   // A * B
        #100; // Wait for 1 clock cycle

        // Test case 4: Logical Shift Left (op = 3)
        A = 72'h000000000000000001;
        B = 72'h000000000000000000;
        op = 4'b011;   // A << 1
        #100; // Wait for 1 clock cycle

        // Test case 5: Logical Shift Right (op = 4)
        A = 72'h000000000000000010;
        B = 72'h000000000000000000;
        op = 4'b100;   // A >> 1
        #100; // Wait for 1 clock cycle

        // Test case 6: Equality Comparison (op = 5)
        A = 72'h000000000000000001;
        B = 72'h000000000000000001;
        op = 4'b101;   // A == B
        #100; // Wait for 1 clock cycle

        // Test case 7: Greater-than Comparison (op = 6)
        A = 72'h000000000000000010;
        B = 72'h000000000000000005;
        op = 4'b110;   // A > B
        #100; // Wait for 1 clock cycle

        // Test case 8: Less-than Comparison (op = 7)
        A = 72'h000000000000000005;
        B = 72'h000000000000000010;
        op = 4'b111;   // A < B
        #100; // Wait for 1 clock cycle

        // Test case 9: Default case (op = any invalid value, should output 0)
        A = 72'h000000000000000001;
        B = 72'h000000000000000001;
        op = 4'bxxx;   // Invalid operation
        #100; // Wait for 1 clock cycle

        // Finish the simulation
        $stop;
    end

    // Monitor the output
    initial begin
        $monitor("At time %t, A = %h, B = %h, op = %b, C = %h", $time, A, B, op, C);
    end

endmodule
