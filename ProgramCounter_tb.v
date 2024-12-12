`timescale 1ps/ 1ps

module ProgramCounter_tb;

  // Inputs
  reg clk;
  reg rst;
  reg Branch;
  reg jump;
  reg [71:0] Addr;
  reg [67:0] jump_addr;
  reg [54:0] branch_addr;

  // Outputs
  wire [71:0] PC;

  // Instantiate the ProgramCounter module
  ProgramCounter uut (
    .clk(clk),
    .rst(rst),
    .Branch(Branch),
    .jump(jump),
    .Addr(Addr),
    .jump_addr(jump_addr),
    .branch_addr(branch_addr),
    .PC(PC)
  );

  // Clock generation (alternates every 50 time units)
  initial begin
    clk = 0;
    forever #50 clk = ~clk;  // Clock alternates every 50 time units
  end

  // Test stimulus
  initial begin
    // Initialize signals
    rst = 1;  // Assert reset initially
    Branch = 0;  // No branch initially
    jump = 0;    // No jump initially
    Addr = 72'h000000000000000000000000000000000000000000000000000000000000000; // Initial address
    jump_addr = 68'h0000000000000000000000000000000000000000; // Some random jump address
    branch_addr = 55'h00000000000000000000000000000000000;  // Some random branch address

    // Display header for output monitoring
    $display("Time\tclk\trst\tBranch\tjump\tAddr\t\t\t\tjump_addr\t\t\tbranch_addr\t\tPC");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%h\t%h\t%h\t%h", $time, clk, rst, Branch, jump, Addr, jump_addr, branch_addr, PC);

    // Test Case 1: Assert reset (PC should reset to 0)
    #100 rst = 1;  // Reset the PC
    #100 rst = 0;  // Deassert reset

    // Test Case 2: No branch, no jump (PC should increment by 1)
    Addr = 72'h0000000000000000000000000000000000000000000000000000000000000010;  // Starting value of PC = 16
    #100; // Wait for a clock cycle (PC should increment to 17)

    // Test Case 3: Apply branch operation (PC should take branch_addr)
    Branch = 1; // Assert branch signal
    branch_addr = 55'h00000000000000000000000000000000011; // Set some random branch address (PC should become this address)
    #100; // Wait for a clock cycle

    // Test Case 4: Apply jump operation (PC should take jump_addr)
    Branch = 0; // Deassert branch signal
    jump = 1;   // Assert jump signal
    jump_addr = 68'h0000000000000000000000000000000000000001; // Set some random jump address (PC should become this address)
    #100; // Wait for a clock cycle

    // Test Case 5: After jump, no branch or jump (PC should increment again)
    jump = 0;   // Deassert jump signal
    Addr = 72'h0000000000000000000000000000000000000000000000000000000000000100;  // New address for increment (PC should increment from previous jump address)
    #100; // Wait for a clock cycle

    // Test Case 6: Apply reset again (PC should reset to 0)
    rst = 1;  // Assert reset signal
    #100;  // Wait for a clock cycle (PC should reset to 0)

    // Finish the simulation
    $finish;
  end

endmodule
