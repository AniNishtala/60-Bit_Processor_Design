module PC(
    input wire        clk,
    input wire        rst,
    input wire        Branch,  // If branch or not
    input wire [71:0] Addr,    // Target address
    output reg        ce,
    output reg [71:0] PC
);

/*
 * This always block controls the signal ce.
 */
always @ (posedge clk or posedge rst) begin
    if (rst)
        ce <= 1'b0;
    else
        ce <= 1'b1;
end

/*
 * This always block controls the signal PC.
 */
always @ (posedge clk or posedge rst) begin
    if (rst)
        PC <= 72'b0;            // Reset PC to 0
    else if (!ce)
        PC <= 72'b0;            // Maintain PC as 0 until ce is enabled
    else if (Branch)
        PC <= Addr;             // Update PC to branch address
    else
        PC <= Addr + 4'b1001;    // Increment PC by 9
end

endmodule
