module ALU(
  input clk,
  input [2:0] op,
  input [59:0] A, B,
  output [59:0] C
);

always@(posedge clk)begin
case(op)
  0: C = A + B;
  1: C = A - B;
  2: C = A * B;
  3: //Other operations!
  4:
  5:
  6:
  7:
endcase
end
endmodule
