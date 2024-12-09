module control_unit(
input wire [3:0] opcode // input opcode 
output reg  ALU_op,  // ALU operation
output reg branch_en,// Branch instruction 
output reg  jump_en ,//enables jump
output reg immediate_en,// ALU source( register or immediate)
output reg  reg_write // Enables writing to the register file 

);

always  @(*) begin 

// To start off all the outputs is going to be set by default 0 (Off)
ALU_op = 0;
branch_en = 0;
jump_en = 0;
immediate_en = 0;
reg_write = 0

case (opcode) 

/*The opcode is going to receive it and then going to decide which type of intstruction
just a test op code and we just need to change it when we finalize the opcode

*/
4'b0001: begin  //R-Type
alu_op = 1; //perfrom addition
reg_write = 1; // write to register
end 

// Skipped the I-Type as no memory was added to diagram 


4'b0010 begin // Branch
alu_op = 1; // Subtraction 
branch_en1; // Branch 

end

4'b1111:begin // J-Type
jump_en = 1;// Enable 
end 
endcase 
end 
endmodule



















