module ProgramCounter(
    input wire        clk,
    input wire        rst,
    input wire        Branch, jump,  // If branch or not, coming from outside AND gate of branch_en and ALU_Out[0]
    input wire [71:0] Addr,    // Target address
    input wire [67:0] jump_addr, //jump address if jump operation
    input wire [54:0] branch_addr, //branch address if branch operation
    output reg [71:0] PC
);

/*
 * This always block controls the signal PC.
 */
always @ (posedge clk) begin
    if (rst)
        PC <= 72'b0;            // Reset PC to 0
    else if (Branch)
        PC <= {17'b0, branch_addr};             // Update PC to branch address
    else if (jump)
        PC <= {4'b0, jump_addr};  //If jump address, update PC to jump address
    else 
        PC <= Addr + 1'b1;    // Else increment to the next instruction, might need to pause this when simulating the final result!
end
endmodule
