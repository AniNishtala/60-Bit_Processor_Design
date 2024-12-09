module Register(
    input write, clk, reset,
    input [9:0] reg1_address, reg2_address, reg_r_address,   // 10-bit address (to access 1024 registers)
    input [71:0] result_in,
    output reg [71:0] data_out1, data_out2
);

    parameter n = 72;  // Data width (72 bits)
    parameter d = 1024;  // Number of registers (1024 registers)
    integer i;

    // Register memory array to hold 1024 registers, each 72 bits
    reg [n-1:0] datamemory [0:d-1];

    // Initial block to read memory contents from a file (data_mem.txt)
    initial begin
        $readmemh("data_mem.txt", datamemory);  // Read 1024 entries from the file in hexadecimal format
    end

    // Write or read from registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Optionally clear the registers on reset
            
            for (i = 0; i < d; i = i + 1) begin
                datamemory[i] <= 72'b0;
            end
        end else if (write) begin
            // Write the result_in value to the specified register
            datamemory[reg_r_address] <= result_in;
        end else begin
            // Read the data from the specified registers
            data_out1 <= datamemory[reg1_address];
            data_out2 <= datamemory[reg2_address];
        end
    end

endmodule
