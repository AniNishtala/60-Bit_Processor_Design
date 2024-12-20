//we need a txt file to read data memory from and instructions.
module InstructionFetch(
    input wire clk, reset,
	input	wire[71:0]	address,  // instruction address
	output 	reg [71:0]	instruction   // instruction
	
);

	reg[71:0]  instruction_memory[0:1023];

	initial $readmemb ("machinecode.txt", instruction_memory);	// read test assembly code file

always @ (posedge clk) begin
		instruction <= instruction_memory[address[71:0]];
end

endmodule
