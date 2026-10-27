`timescale 1ns/1ps
module tb_riscv_cpu;
    logic clk, reset;
    logic [31:0] pc, current_instruction, debug_x3, debug_x4, debug_mem0;

    riscv_cpu dut (
        .clk(clk), .reset(reset), .pc(pc),
        .current_instruction(current_instruction),
        .debug_x3(debug_x3), .debug_x4(debug_x4), .debug_mem0(debug_mem0)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #17;
        reset = 0;

        // The program takes several cycles; then JAL x0,0 loops at its own PC.
        repeat (12) @(posedge clk);
        #1;
        $display("PC=%08h x3=%0d x4=%0d DMEM[0]=%0d",
                 pc, debug_x3, debug_x4, debug_mem0);

        if (debug_x3 !== 32'd12) $fatal(1, "Expected x3 = 12");
        if (debug_x4 !== 32'd12) $fatal(1, "Expected x4 = 12");
        if (debug_mem0 !== 32'd12) $fatal(1, "Expected DMEM[0] = 12");

        $display("tb_riscv_cpu: all tests passed");
        $finish;
    end
endmodule
