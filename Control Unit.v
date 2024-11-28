module control_unit(
input clk, 
input [59:54] op, // 6 bit opcode 
output reg branch,
output reg ALUop,
output reg Memory_write,
output reg Memory_read,
output reg Memory_to_reg,
output reg ALU_src,
output reg Register_destination,
output reg Register_write
output reg jump
);
 
always @(posedge clk) begin 
 // default to keep all the outputs 0 which are not used in the different instructions

    branch <= 0;
    ALUop <= 0;
    Memory_write <= 0;
    Memory_read <= 0;
    Memory_to_reg <= 0;
    ALU_src <= 0;
    Register_destination <=0;
    Register_write <= 0;
    jump <= 0;


  case(op) 
   
    // Add Instruction 
    6'b000001: begin 
    ALUop <= 1;
    Register_destination <= 1;
    Register_write <= 1;
    end 

      // Sub Instruction 
    6'b000010: begin 
    ALUop <= 1;
    Register_destination <= 1;
    Register_write <= 1;
    end 

  // Load Instruction 
    6'b000011: begin 
    Memory_read <= 1;
    Memory_to_reg <= 1;
    ALU_src <= 1;
    Register_write <= 1;
    end 

  // Store Instruction 
    6'b000100: begin 
    Memory_write <= 1;
    ALU_src <= 1;
    end 

  //Branch Instruction 
  6'b000101: begin 
  branch <=1 ; 
  end

  // Jump 
  6'b000110: begin 
  jump <=1;
   end 
endcase 

end 
endmodule 
    
    

