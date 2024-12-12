`timescale 1ps / 1ps

module Control_Unit_tb;

  // Inputs
  reg clk;
  reg [3:0] opcode;

  // Outputs
  wire branch_en;
  wire jump_en;
  wire immediate_en;
  wire write_en;

  // Instantiate the Control Unit
  Control_Unit uut (
    .clk(clk),
    .opcode(opcode),
    .branch_en(branch_en),
    .jump_en(jump_en),
    .immediate_en(immediate_en),
    .write_en(write_en)
  );

  // Clock generation (alternates every 50 time units)
  initial begin
    clk = 0;
    forever #50 clk = ~clk;  // Clock alternates every 50 time units
  end

  // Test stimulus
  initial begin
    // Initialize signals
    opcode = 4'b0000;

    // Display header
    $display("Time\tOpcode\tBranch_en\tJump_en\tImmediate_en\tWrite_en");
    $monitor("%0t\t%h\t%h\t%h\t%h\t%h", $time, opcode, branch_en, jump_en, immediate_en, write_en);

    // Test all opcodes and their corresponding control signal behavior
    // R-Type Instructions (Opcodes 1-8)
    #100 opcode = 4'b0001; // Opcode 1
    #100 opcode = 4'b0010; // Opcode 2
    #100 opcode = 4'b0011; // Opcode 3
    #100 opcode = 4'b0100; // Opcode 4
    #100 opcode = 4'b0101; // Opcode 5
    #100 opcode = 4'b0110; // Opcode 6
    #100 opcode = 4'b0111; // Opcode 7
    #100 opcode = 4'b1000; // Opcode 8

    // I-Type Instructions (Opcodes 9-11)
    #100 opcode = 4'b1001; // Opcode 9
    #100 opcode = 4'b1010; // Opcode 10
    #100 opcode = 4'b1011; // Opcode 11

    // Branch Type Instructions (Opcodes 12-15)
    #100 opcode = 4'b1100; // Opcode 12
    #100 opcode = 4'b1101; // Opcode 13
    #100 opcode = 4'b1110; // Opcode 14
    #100 opcode = 4'b1111; // Opcode 15

    // Default case (Test the default behavior)
    #100 opcode = 4'b0000; // Default case (out of range)

    // Finish the simulation after all test cases
    #100 $finish;
  end

endmodule
