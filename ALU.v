module ALU(
    input clk,
    input [3:0] op,
    input [71:0] A, B, 
    output reg [71:0] C
);

    always @(posedge clk) begin

        case(op)
            0: C = A + B; // add
            1: C = A - B; // sub
            2: C = A * B; // mul
            3: C = A / B; // div
            4: C = A << B; // LSL by B
            5: C = 72'b1;  //Random output signal for jump operation, need an ALU_Op for the control unit for the jump
	    6: C = A && B; // and logical operation
            7: C = A || B; // or logical operation
	    8: C = A ^ B; // xor operation
            9: C = A + B[54:0]; // addi
            10: C = A - B[54:0]; // subi
            11: C = A & B[54:0]; // andi
            12: C = (A == B) ? 72'b1 : 72'b0; // beq , makes only right most bit 1 in C if true
            13: C = (A != B) ? 72'b1: 72'b0; // bne , makes only right most bit 1 in C if true
            14: C = (A < B) ? 72'b1: 72'b0; // blt , makes only right most bit 1 in C if true
            15: C = (A > B) ? 72'b1: 72'b0; // bgt, makes only right most bit 1 in C if true
            default: C = 72'b0; //default case
        endcase
    end
endmodule
