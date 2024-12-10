module ProgramCounter(
	input clk,
	input reset,
	input [54:0] jump_address,
	input [67:0] branch_address,
	input Jump_en, Branch_en
	output reg [71:0] pc
);

always @(posedge clk or posedge reset) begin

	if(reset == 1)
		pc <= 0;
	else if(Jump_en == 1)
		pc <= jump_address;
	else if(Branch_en == 1)
		pc <= branch_address
	else
		pc <= pc + 72; // increment by 72 to fetch the next instruction address
	end
endmodule
