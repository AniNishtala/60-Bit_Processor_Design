`timescale 1ps/ 1ps

module Register_tb;

  // Inputs
  reg clk;
  reg reset;
  reg [5:0] reg1_address;
  reg [5:0] reg2_address;

  // Outputs
  wire [71:0] data_out1;
  wire [71:0] data_out2;

  // Instantiate the Register module
  Register uut (
    .clk(clk),
    .reset(reset),
    .reg1_address(reg1_address),
    .reg2_address(reg2_address),
    .data_out1(data_out1),
    .data_out2(data_out2)
  );

  // Clock generation (alternates every 50 time units)
  initial begin
    clk = 0;
    forever #50 clk = ~clk;  // Clock alternates every 50 time units
  end

  // Test stimulus
  initial begin
    // Initialize signals
    reset = 1;  // Assert reset initially
    reg1_address = 6'b000000; // Start reading from address 0
    reg2_address = 6'b000001; // Start reading from address 1

    // Display header
    $display("Time\tReg1_Address\tReg2_Address\tData_Out1\tData_Out2");
    $monitor("%0t\t%h\t%h\t%h\t%h", $time, reg1_address, reg2_address, data_out1, data_out2);

    // Apply reset
    #100 reset = 0;  // Deassert reset after 100 time units
    #50  reg1_address = 6'b000000; reg2_address = 6'b000001;  // Read from address 0 and 1
    #100 reg1_address = 6'b000010; reg2_address = 6'b000011;  // Read from address 2 and 3
    #100 reg1_address = 6'b000100; reg2_address = 6'b000101;  // Read from address 4 and 5
    #100 reg1_address = 6'b000110; reg2_address = 6'b000111;  // Read from address 6 and 7
    #100 reg1_address = 6'b001000; reg2_address = 6'b001001;  // Read from address 8 and 9

    // Finish the simulation after some time
    #100 $finish;
  end

endmodule
