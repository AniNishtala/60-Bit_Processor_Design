module ALU(
	input clk,
	input [3:0] op,
	input [71:0] A, B, 
	output reg [71:0] C
);
	always@(posedge clk) begin
	case(op)
	0: C = A + B; // add
	1: C = A - B; // sub
	2: C = A * B; // mul
	3: C = A / B; // div
	4: C = A << B; // LSL by B
	4: C = A >> B; // LSR by B
	5: C = A + B[54:0]; // addi
	6: C = A - B[54:0]; // subi
	7: C = A & B[54:0]; // andi
	8: C = A && B; // and logical operation
	9: C = A || B; // or logical operation
	10: C = A ^ B; // xor operation
	11: C = (A == B) ? 72'b1 : 72'b0; // beq
	12: C = (A != B) ? 72'b1: 72'b0; // bne 
	13: C = (A < B) ? 72'b1: 72'b0; // blt 
	14: C = (A > B) ? 72'b1: 72'b0; // bgt
	15: C = B[67:0]; // j (Dont need this!)
	default: C = 72'b0; //default case
	endcase	
	end
endmodule 
