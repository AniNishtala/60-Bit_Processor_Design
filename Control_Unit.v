module Control_Unit(
    input wire clk,
    input wire [3:0] opcode, // input opcode
    output reg branch_en,    // Branch instruction
    output reg jump_en,      // Enables jump
    output reg immediate_en,  // ALU source (register or immediate)
    output reg write_en      //write_en is for the Data Memory to write if R or I Type
);



always @(posedge clk) begin 
  
    // Decode the opcode and set control signals
    case (opcode)
        0, 1, 2, 3, 4, 6, 7, 8: begin  // Opcodes 1-8 are R-Type instructions (decimal)
            branch_en <= 0;
            jump_en <= 0;
            immediate_en <= 0;
	    write_en <= 1;
	
        end
        5: begin		//Jump operation to enable the jump signal to PC
            branch_en <= 0;
            jump_en <= 1;
            immediate_en <= 0;
	    write_en <= 0;
	end
        9, 10, 11: begin  // Opcodes 9-11 are I-Type Instructions!
            branch_en <= 0;
            jump_en <= 0;
            immediate_en <= 1;
	    write_en <= 1;
        end
        
        12, 13, 14, 15: begin  // Opcodes 12 - 15 are Branch type operations
            branch_en = 1;
            jump_en = 0;
            immediate_en = 0;
	    write_en <=0;
        end
        
        default: begin
            branch_en <= 0;
            jump_en <= 0;
            immediate_en <= 0;
	    write_en <= 0;
        end
    endcase
end

endmodule
