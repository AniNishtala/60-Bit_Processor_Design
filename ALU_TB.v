`timescale 1ps/1ps
module ALU_tb;

  // Declare inputs as reg type
  reg clk;
  reg [3:0] op;
  reg [71:0] A, B;
  
  // Declare outputs as wire type
  wire [71:0] C;
  // Instantiate the ALU module
  ALU uut (
    .clk(clk),
    .op(op),
    .A(A),
    .B(B),
    .C(C)
  );
  
  // Clock generation
  always begin
    #50 clk = ~clk; // 10ns period clock
  end
  
  // Test case sequence
  initial begin
    // Initialize inputs
    clk = 0;
    op = 4'b0;
    A = 72'b0;
    B = 72'b0;
    
    // Test Add operation (op = 0)
    #10 op = 4'b0000; A = 72'd10; B = 72'd20; // A = 10, B = 20 (A + B)
    #10;
    
    // Test Subtract operation (op = 1)
    #10 op = 4'b0001; A = 72'd50; B = 72'd30; // A = 50, B = 30 (A - B)
    #10;
    
    // Test Multiply operation (op = 2)
    #10 op = 4'b0010; A = 72'd15; B = 72'd2;  // A = 15, B = 2 (A * B)
    #10;
    
    // Test Divide operation (op = 3)
    #10 op = 4'b0011; A = 72'd100; B = 72'd10; // A = 100, B = 10 (A / B)
    #10;
    
    // Test Left Shift operation (op = 4)
    #10 op = 4'b0100; A = 72'd5; B = 72'd1;   // A = 5, B = 1 (Shift left by 1)
    #10;
    
    // Test Right Shift operation (op = 5)
    #10 op = 4'b0101; A = 72'd16; B = 72'd1;  // A = 16, B = 1 (Shift right by 1)
    #10;
    
    // Test Add Immediate operation (op = 6)
    #10 op = 4'b0110; A = 72'd25; B = 72'd100; // A = 25, B = 100 (lower 55 bits used)
    #10;
    
    // Test Subtract Immediate operation (op = 7)
    #10 op = 4'b0111; A = 72'd50; B = 72'd10;  // A = 50, B = 10 (lower 55 bits used)
    #10;
    
    // Test And Immediate operation (op = 8)
    #10 op = 4'b1000; A = 72'd60; B = 72'd15;  // A = 60, B = 15 (lower 55 bits used)
    #10;
    
    // Test Logical And operation (op = 9)
    #10 op = 4'b1001; A = 72'd1; B = 72'd1;    // A = 1, B = 1 (Logical AND)
    #10;
    
    // Test Logical Or operation (op = 10)
    #10 op = 4'b1010; A = 72'd1; B = 72'd0;    // A = 1, B = 0 (Logical OR)
    #10;
    
    // Test XOR operation (op = 11)
    #10 op = 4'b1011; A = 72'd1; B = 72'd2;    // A = 1, B = 2 (XOR operation)
    #10;
    
    // Test BEQ operation (op = 12) - A == B
    #10 op = 4'b1100; A = 72'd100; B = 72'd100; // A = 100, B = 100 (A == B)
    #10;
    
    // Test BNE operation (op = 13) - A != B
    #10 op = 4'b1101; A = 72'd100; B = 72'd50;  // A = 100, B = 50 (A != B)
    #10;
    
    // Test BLT operation (op = 14) - A < B
    #10 op = 4'b1110; A = 72'd10; B = 72'd20;   // A = 10, B = 20 (A < B)
    #10;
    
    // Test BGT operation (op = 15) - A > B
    #10 op = 4'b1111; A = 72'd30; B = 72'd20;   // A = 30, B = 20 (A > B)
    #10;
    
    // Test Divide by zero (DivZeroError) for remainder operation (op = 12)
    #10 op = 4'b1100; A = 72'd20; B = 72'd0;   // A = 20, B = 0 (divide by zero)
    #10;
    
    // End simulation
    $finish;
  end
  
  // Monitor the outputs
  initial begin
    $monitor("Time = %0d, op = %b, A = %d, B = %d, C = %d, DivZeroError = %b", 
             $time, op, A, B, C, DivZeroError);
  end
  
endmodule
