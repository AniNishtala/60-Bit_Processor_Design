module Data_Memory(
    input wire clk,
    input wire reset,
    input wire write_enable,
    input wire [54:48] register_destination_address,
    input wire [71:0] ALU_Result
);

    reg [71:0] datamemory [0:127]; 

    // Load initial memory contents
    initial begin
        $readmemh("data_mem.txt", datamemory);
    end

    always @(posedge clk) begin
        if (reset) begin
            // No specific reset behavior needed for now
        end else if (write_enable) begin
            datamemory[register_destination_address] <= ALU_Result; // Write data to memory
        end
    end

    // Write memory contents back to file (if needed, usually not in hardware simulation)
    always @(posedge clk) begin
        if (write_enable) begin
            $writememh("data_mem.txt", datamemory); // Write the entire memory to file
        end
    end
endmodule
