module ALU(
	input clk,
	input [2:0] op,
	input [59:0] A, B, 
	output reg [59:0] C
);
	always@(posedge clk) begin
	case(op)
	0: C = A + B;
	1: C = A - B;
	2: C = A * B;
	3: C = A << 1;
	4: C = A >> 1;
	5: C =(A == B) ? 60'b1 : 60'b0;
	6: C = (A > B) ? 60'b1 : 60'b0;
	7: C = (A < B) ? 60'b1: 60'b0;
	default: C = 60'b0;
	endcase	
	end
endmodule 
