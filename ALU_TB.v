`timescale 1ps/1ps
module ALU_TB;
    reg clk;
    reg [3:0] op;
    reg [71:0] A, B;
    wire [71:0] C;
    wire done;

    // Instantiate the ALU module
    ALU uut (
        .clk(clk),
        .op(op),
        .A(A),
        .B(B),
        .C(C),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk; 
    end

    // Test sequence
    initial begin
        // Initialize inputs
        A = 72'd0;
        B = 72'd0;
        op = 4'd0;

        // Wait for the clock to stabilize
        #10;

        // Test each operation
        // Add operation
        A = 72'd10; B = 72'd15; op = 4'd0; #10;
        $display("ADD: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Subtract operation
        A = 72'd50; B = 72'd20; op = 4'd1; #10;
        $display("SUB: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Multiply operation
        A = 72'd6; B = 72'd7; op = 4'd2; #10;
        $display("MUL: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Divide operation
        A = 72'd100; B = 72'd5; op = 4'd3; #10;
        $display("DIV: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Logical shift left
        A = 72'd1; B = 72'd2; op = 4'd4; #10;
        $display("LSL: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Logical shift right
        A = 72'd16; B = 72'd1; op = 4'd5; #10;
        $display("LSR: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Add immediate
        A = 72'd100; B = 72'd5; op = 4'd6; #10;
        $display("ADDI: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Subtract immediate
        A = 72'd100; B = 72'd20; op = 4'd7; #10;
        $display("SUBI: A=%d B=%d C=%d done=%b", A, B, C, done);

        // And immediate
        A = 72'd15; B = 72'd10; op = 4'd8; #10;
        $display("ANDI: A=%d B=%d C=%d done=%b", A, B, C, done);

        // And logical
        A = 72'd1; B = 72'd0; op = 4'd9; #10;
        $display("AND Logical: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Or logical
        A = 72'd0; B = 72'd1; op = 4'd10; #10;
        $display("OR Logical: A=%d B=%d C=%d done=%b", A, B, C, done);

        // XOR operation
        A = 72'd3; B = 72'd1; op = 4'd11; #10;
        $display("XOR: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Equal comparison
        A = 72'd50; B = 72'd50; op = 4'd12; #10;
        $display("BEQ: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Not equal comparison
        A = 72'd50; B = 72'd40; op = 4'd13; #10;
        $display("BNE: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Less than comparison
        A = 72'd30; B = 72'd40; op = 4'd14; #10;
        $display("BLT: A=%d B=%d C=%d done=%b", A, B, C, done);

        // Greater than comparison
        A = 72'd70; B = 72'd60; op = 4'd15; #10;
        $display("BGT: A=%d B=%d C=%d done=%b", A, B, C, done);

        $stop; // End the simulation
    end
endmodule
