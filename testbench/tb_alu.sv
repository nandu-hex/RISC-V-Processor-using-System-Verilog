`timescale 1ns/1ps
module tb_alu;
    logic [31:0] a, b, result;
    logic [2:0] alu_control;
    logic zero;

    alu dut (.a(a), .b(b), .alu_control(alu_control), .result(result), .zero(zero));

    initial begin
        a = 32'd10; b = 32'd3;
        alu_control = 3'b000; #10;
        if (result !== 32'd13) $fatal(1, "ADD failed");

        alu_control = 3'b001; #10;
        if (result !== 32'd7) $fatal(1, "SUB failed");

        alu_control = 3'b010; #10;
        if (result !== (a & b)) $fatal(1, "AND failed");

        alu_control = 3'b011; #10;
        if (result !== (a | b)) $fatal(1, "OR failed");

        alu_control = 3'b100; #10;
        if (result !== (a ^ b)) $fatal(1, "XOR failed");

        a = 32'd2; b = 32'd9; alu_control = 3'b101; #10;
        if (result !== 32'd1) $fatal(1, "SLT failed");

        $display("tb_alu: all tests passed");
        $finish;
    end
endmodule
