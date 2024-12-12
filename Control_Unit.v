module Control_Unit(
    input wire [3:0] opcode, // input opcode
    output reg branch_en,    // Branch instruction
    output reg jump_en,      // Enables jump
    output reg immediate_en  // ALU source (register or immediate)
);

always @(*) begin  // Use (*) for combinational logic
    // Default values (optional, depending on your design)
    branch_en = 0;
    jump_en = 0;
    immediate_en = 0;
    
    // Decode the opcode and set control signals
    case (opcode)
        1, 2, 3, 4, 5: begin  // Opcodes 1-5 (decimal)
            branch_en = 1;
            jump_en = 0;
            immediate_en = 0;
        end
        
        6: begin  // Example for a specific opcode
            branch_en = 0;
            jump_en = 1;
            immediate_en = 0;
        end
        
        7: begin  // Another specific opcode
            branch_en = 0;
            jump_en = 0;
            immediate_en = 1;
        end
        
        default: begin
            branch_en = 0;
            jump_en = 0;
            immediate_en = 0;
        end
    endcase
end

endmodule
