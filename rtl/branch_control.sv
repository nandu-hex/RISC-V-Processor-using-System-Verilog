module branch_control (
    input  logic [31:0] pc_value,
    input  logic [31:0] immediate,
    input  logic [31:0] rs1_value,
    input  logic [31:0] rs2_value,
    input  logic        is_beq,
    input  logic        is_bne,
    input  logic        is_jal,
    input  logic        is_jalr,
    output logic        take_branch,
    output logic [31:0] branch_target
);
    always_comb begin
        take_branch = 1'b0;
        if (is_beq && (rs1_value == rs2_value))
            take_branch = 1'b1;
        if (is_bne && (rs1_value != rs2_value))
            take_branch = 1'b1;
        if (is_jal || is_jalr)
            take_branch = 1'b1;

        if (is_jalr)
            branch_target = (rs1_value + immediate) & 32'hFFFF_FFFE;
        else
            branch_target = pc_value + immediate;
    end
endmodule
