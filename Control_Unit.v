module Control_Unit(
    input wire [3:0] opcode, // input opcode
    output reg branch_en,    // Branch instruction
    output reg jump_en,      // Enables jump
    output reg immediate_en  // ALU source (register or immediate)
    // output reg reg_write    // Enables writing to the register file (if needed)
);

always @(*) begin  // Use (*) for combinational logic
    // Default values (optional, depending on your design)
    branch_en = 0;
    jump_en = 0;
    immediate_en = 0;
    
    // Decode the opcode and set control signals
    case (opcode)
        4'b0000: begin  // Example opcode for a branch instruction
            branch_en = 1;
            jump_en = 0;
            immediate_en = 0;
        end
        
        4'b0001: begin  // Example opcode for a jump instruction
            branch_en = 0;
            jump_en = 1;
            immediate_en = 0;
        end
        
        4'b0010: begin  // Example opcode for an immediate operation (ALU source = immediate)
            branch_en = 0;
            jump_en = 0;
            immediate_en = 1;
        end
        
        4'b0011: begin  // Example opcode for a regular operation (register-based)
            branch_en = 0;
            jump_en = 0;
            immediate_en = 0;
        end
        
        // Add other opcodes as needed
        
        default: begin
            branch_en = 0;
            jump_en = 0;
            immediate_en = 0;
        end
    endcase
end

endmodule
