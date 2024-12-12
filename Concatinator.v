module Concatinator(
  input [47:0] A,
  output reg[71:0] B
);

  always@(*) begin
    B = {24'b0, A};
  end
endmodule
