module ALU_TB;
    // Declare registers for inputs and wires for output
    reg clk;
    reg [2:0] op;          // 3-bit operation input
    reg [59:0] A, B;       // 60-bit inputs
    wire [59:0] C;         // 60-bit output

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
        #5 clk = ~clk;  // Toggle the clock every 5 time units
    end

    // Apply test vectors
    initial begin
        // Initialize the clock
        clk = 0;

        // Test case 1: Addition (op = 0)
        A = 60'h000000000000000001;
        B = 60'h000000000000000001;
        op = 3'b000;   // A + B
        #10; // Wait for 1 clock cycle

        // Test case 2: Subtraction (op = 1)
        A = 60'h000000000000000010;
        B = 60'h000000000000000005;
        op = 3'b001;   // A - B
        #10; // Wait for 1 clock cycle

        // Test case 3: Multiplication (op = 2)
        A = 60'h000000000000000003;
        B = 60'h000000000000000002;
        op = 3'b010;   // A * B
        #10; // Wait for 1 clock cycle

        // Test case 4: Logical Shift Left (op = 3)
        A = 60'h000000000000000001;
        B = 60'h000000000000000000;
        op = 3'b011;   // A << 1
        #10; // Wait for 1 clock cycle

        // Test case 5: Logical Shift Right (op = 4)
        A = 60'h000000000000000010;
        B = 60'h000000000000000000;
        op = 3'b100;   // A >> 1
        #10; // Wait for 1 clock cycle

        // Test case 6: Equality Comparison (op = 5)
        A = 60'h000000000000000001;
        B = 60'h000000000000000001;
        op = 3'b101;   // A == B
        #10; // Wait for 1 clock cycle

        // Test case 7: Greater-than Comparison (op = 6)
        A = 60'h000000000000000010;
        B = 60'h000000000000000005;
        op = 3'b110;   // A > B
        #10; // Wait for 1 clock cycle

        // Test case 8: Less-than Comparison (op = 7)
        A = 60'h000000000000000005;
        B = 60'h000000000000000010;
        op = 3'b111;   // A < B
        #10; // Wait for 1 clock cycle

        // Test case 9: Default case (op = any invalid value, should output 0)
        A = 60'h000000000000000001;
        B = 60'h000000000000000001;
        op = 3'bxxx;   // Invalid operation
        #10; // Wait for 1 clock cycle

        // Finish the simulation
        $finish;
    end

    // Monitor the output
    initial begin
        $monitor("At time %t, A = %h, B = %h, op = %b, C = %h", $time, A, B, op, C);
    end

endmodule
