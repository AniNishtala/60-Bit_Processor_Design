module Multiplexer21(

	input wire [71:0] A,
	input wire [71:0] B,
	input wire selectionLine,
	output reg [71:0] C
);

//when selectionLine is 1, output wire B

	always @(*) 
	     begin
	     C = (selectionLine) ? B : A; 
end
endmodule
