`timescale 1ps / 1ps

module Testbench;

  // Testbench signals
  reg clk, rst;
  
  // Instantiate the Processor
  Seventy_Two_Bit_Processor_Top uut (
    .clk(clk),
    .rst(rst)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;  // 10ns clock period
  end

  // Test scenario
  initial begin
    // Initialize signals
    clk = 1;
    rst = 0;

    // Reset sequence
    #10 rst = 0;  // Release reset
    #20 rst = 1;  // Assert reset again (for verification)
    #10 rst = 0;  // Release reset again

    // Wait for some time
    #100;
    
    // Stop simulation
    $stop;
  end

endmodule
