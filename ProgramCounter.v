module ProgramCounter(
input clk,
input reset,
input [59:0] jump_address,
input jump_enable,
output reg [59:0] pc
);

always @(posedge clk or posedge reset) begin

	if(reset == 1)
		pc <= 0;
	else if(jump_enable == 1)
		pc <= jump_address;
	else
		pc <= pc + 120; // increment by 120 bits to fetch two instructions at a time
	end
endmodule
