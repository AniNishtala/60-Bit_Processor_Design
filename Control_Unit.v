module Control_Unit(
input wire [3:0] opcode // input opcode 
output reg branch_en,// Branch instruction 
output reg  jump_en ,//enables jump
output reg immediate_en,// ALU source( register or immediate)
//output reg reg_write // Enables writing to the register file

);

always  @(posedge clk) begin  //might need to change to (*)

	case(op) begin
	0: 
	branch_en <= 0;
	jump_en <= 0;
	immediate_en <= 0;
	default: branch_en <= 0;
		 jump_en <= 0;
		 immediate_en <= 0;
		 
endcase


endmodule
