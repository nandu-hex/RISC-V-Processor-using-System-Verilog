`timescale 1ns/1ps
module id_ex_register (
    input logic clk, reset, flush,

    input logic [31:0] pc_in, rs1_data_in, rs2_data_in, immediate_in,
    input logic [4:0] rs1_in, rs2_in, rd_in,
    input logic [2:0] funct3_in,
    input logic [6:0] funct7_in,

    input logic reg_write_in, alu_src_imm_in, mem_read_in, mem_write_in,
    input logic mem_to_reg_in, branch_eq_in, jump_in,
    input logic [2:0] alu_control_in,

    output logic [31:0] pc_out, rs1_data_out, rs2_data_out, immediate_out,
    output logic [4:0] rs1_out, rs2_out, rd_out,
    output logic [2:0] funct3_out,
    output logic [6:0] funct7_out,

    output logic reg_write_out, alu_src_imm_out, mem_read_out, mem_write_out,
    output logic mem_to_reg_out, branch_eq_out, jump_out,
    output logic [2:0] alu_control_out
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset || flush) begin
            pc_out <= 0; rs1_data_out <= 0; rs2_data_out <= 0; immediate_out <= 0;
            rs1_out <= 0; rs2_out <= 0; rd_out <= 0; funct3_out <= 0; funct7_out <= 0;
            reg_write_out <= 0; alu_src_imm_out <= 0; mem_read_out <= 0; mem_write_out <= 0;
            mem_to_reg_out <= 0; branch_eq_out <= 0; jump_out <= 0; alu_control_out <= 0;
        end else begin
            pc_out <= pc_in; rs1_data_out <= rs1_data_in; rs2_data_out <= rs2_data_in;
            immediate_out <= immediate_in; rs1_out <= rs1_in; rs2_out <= rs2_in;
            rd_out <= rd_in; funct3_out <= funct3_in; funct7_out <= funct7_in;
            reg_write_out <= reg_write_in; alu_src_imm_out <= alu_src_imm_in;
            mem_read_out <= mem_read_in; mem_write_out <= mem_write_in;
            mem_to_reg_out <= mem_to_reg_in; branch_eq_out <= branch_eq_in;
            jump_out <= jump_in; alu_control_out <= alu_control_in;
        end
    end
endmodule
