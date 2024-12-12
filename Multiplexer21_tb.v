`timescale 1ps / 1ps

module Multiplexer21_tb;

  // Inputs
  reg [71:0] A;
  reg [71:0] B;
  reg selectionLine;

  // Output
  wire [71:0] C;

  // Instantiate the Multiplexer21 module
  Multiplexer21 uut (
    .A(A),
    .B(B),
    .selectionLine(selectionLine),
    .C(C)
  );

  // Test stimulus
  initial begin
    // Display the header for the output
    $display("Time\tSelectionLine\tA\t\t\tB\t\t\tC");
    $monitor("%0t\t%b\t\t\t%h\t%h\t%h", $time, selectionLine, A, B, C);

    // Apply test vectors
    A = 72'h123456789ABCDEF123456789ABCDEF123456789ABCDEF123456789ABCDEF123; // Some 72-bit value for A
    B = 72'hABCDEFA9876543210FEDCBA9876543210FEDCBA9876543210FEDCBA9876543; // Some 72-bit value for B

    // Test Case 1: When selectionLine = 0, C should be equal to A
    selectionLine = 0;
    #100; // Wait for 100 time units

    // Test Case 2: When selectionLine = 1, C should be equal to B
    selectionLine = 1;
    #100; // Wait for 100 time units

    // Test Case 3: Change values of A and B and check again
    A = 72'h000000000000000000000000000000000000000000000000000000000000000;
    B = 72'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
    selectionLine = 0; // C should be A
    #100; // Wait for 100 time units

    selectionLine = 1; // C should be B
    #100; // Wait for 100 time units

    // Test Case 4: Random test case with different values for A and B
    A = 72'h111111111111111111111111111111111111111111111111111111111111111;
    B = 72'h222222222222222222222222222222222222222222222222222222222222222;
    selectionLine = 0; // C should be A
    #100;

    selectionLine = 1; // C should be B
    #100;

    // Finish the simulation
    $finish;
  end

endmodule
