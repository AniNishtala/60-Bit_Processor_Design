// optional file. Not needed as of 12/10/2024
module ALU_control ()

input wire [1:0] ALU_op ,// from the control unit 
input wire [5:0] functions, // the possible functions we want the ALU to do 
output reg [2:0] ALU_Control // the output that controls the ALU 

);
always@(*) 

case (ALU_op ) 

  2'b00 : begin 
  ALU_Control = 3'b000;//ADD
  end 
  2'b01:begin 
  ALU_Control = 3'b001;//SUB
  end 
  
  2'b10: begin               // R-Type (use funct field)
                case (functions)
                    6'b100000: ALUControl = 3'b000; // Addition
                    6'b100010: ALUControl = 3'b001; // Subtraction
                    6'b100100: ALUControl = 3'b010; // AND
                    6'b100101: ALUControl = 3'b011; // OR
                    6'b101010: ALUControl = 3'b100; // Set on Less Than
                    default:   ALUControl = 3'bxxx; // Undefined
                endcase
            end
            default: ALU_Control =3'bxxx; // Undefined
        endcase
    end
endmodule
