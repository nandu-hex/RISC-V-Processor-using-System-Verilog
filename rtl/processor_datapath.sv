module processor_datapath (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] pc,
    input  logic [31:0] instruction,
    input  logic [31:0] memory_read_data,
    output logic [31:0] next_pc,
    output logic [31:0] memory_address,
    output logic [31:0] memory_write_data,
    output logic        memory_write_enable,
    output logic [31:0] debug_x3,
    output logic [31:0] debug_x4
);
    logic [6:0] opcode, funct7;
    logic [4:0] rd, rs1, rs2;
    logic [2:0] funct3, alu_control;
    logic [31:0] immediate, reg_data1, reg_data2;
    logic [31:0] alu_b, alu_result, writeback_data, pc_plus4, branch_target;
    logic alu_zero;
    logic reg_write, alu_src_imm, mem_write, mem_read, mem_to_reg, branch_eq, jump;
    logic take_branch;

    instruction_decoder decoder (
        .instruction(instruction), .opcode(opcode), .rd(rd), .funct3(funct3),
        .rs1(rs1), .rs2(rs2), .funct7(funct7)
    );

    immediate_generator imm_gen (
        .instruction(instruction), .immediate(immediate)
    );

    control_unit controller (
        .opcode(opcode), .funct3(funct3), .funct7(funct7),
        .reg_write(reg_write), .alu_src_imm(alu_src_imm),
        .mem_write(mem_write), .mem_read(mem_read), .mem_to_reg(mem_to_reg),
        .branch_eq(branch_eq), .jump(jump), .alu_control(alu_control)
    );

    register_bank regs (
        .clk(clk), .reset(reset), .write_enable(reg_write),
        .read_addr1(rs1), .read_addr2(rs2), .write_addr(rd),
        .write_data(writeback_data), .read_data1(reg_data1), .read_data2(reg_data2)
    );

    assign alu_b = alu_src_imm ? immediate : reg_data2;

    alu alu_unit (
        .a(reg_data1), .b(alu_b), .alu_control(alu_control),
        .result(alu_result), .zero(alu_zero)
    );

    assign memory_address     = alu_result;
    assign memory_write_data  = reg_data2;
    assign memory_write_enable = mem_write;
    assign writeback_data = jump ? pc_plus4 : (mem_to_reg ? memory_read_data : alu_result);

    assign pc_plus4    = pc + 32'd4;
    assign branch_target = pc + immediate;
    assign take_branch = branch_eq && (reg_data1 == reg_data2);

    always_comb begin
        if (jump)
            next_pc = branch_target;
        else if (take_branch)
            next_pc = branch_target;
        else
            next_pc = pc_plus4;
    end

    always_comb begin
        debug_x3 = regs.registers[3];
        debug_x4 = regs.registers[4];
    end
endmodule
