module Concatinator(
  input [49:0] A,
  output reg[71:0] B
);

  always@(*) begin
    B = {22'b0, A};
  end
endmodule
