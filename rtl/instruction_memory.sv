module instruction_memory #(
    parameter integer WORDS = 64
) (
    input  logic [31:0] address,
    output logic [31:0] instruction
);
    logic [31:0] memory [0:WORDS-1];
    integer i;

    initial begin
        for (i = 0; i < WORDS; i = i + 1)
            memory[i] = 32'h00000013; // NOP = ADDI x0,x0,0

        // Sample program:
        // addi x1,x0,5
        // addi x2,x0,7
        // add  x3,x1,x2
        // sw   x3,0(x0)
        // lw   x4,0(x0)
        // jal  x0,0  (halt by looping forever)
        memory[0] = 32'h00500093;
        memory[1] = 32'h00700113;
        memory[2] = 32'h002081B3;
        memory[3] = 32'h00302023;
        memory[4] = 32'h00002203;
        memory[5] = 32'h0000006F;
    end

    always_comb begin
        if ((address[1:0] != 2'b00) || (address[31:2] >= WORDS))
            instruction = 32'h00000013;
        else
            instruction = memory[address[31:2]];
    end
endmodule
