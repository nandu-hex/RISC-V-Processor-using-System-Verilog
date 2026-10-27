`timescale 1ns/1ps
module ex_mem_register (
    input logic clk, reset, flush,

    input logic [31:0] pc_plus4_in, alu_result_in, store_data_in,
    input logic [4:0] rd_in,
    input logic reg_write_in, mem_read_in, mem_write_in, mem_to_reg_in,
    input logic [31:0] branch_target_in,
    input logic branch_taken_in,

    output logic [31:0] pc_plus4_out, alu_result_out, store_data_out,
    output logic [4:0] rd_out,
    output logic reg_write_out, mem_read_out, mem_write_out, mem_to_reg_out,
    output logic [31:0] branch_target_out,
    output logic branch_taken_out
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset || flush) begin
            pc_plus4_out <= 0; alu_result_out <= 0; store_data_out <= 0;
            rd_out <= 0; reg_write_out <= 0; mem_read_out <= 0;
            mem_write_out <= 0; mem_to_reg_out <= 0;
            branch_target_out <= 0; branch_taken_out <= 0;
        end else begin
            pc_plus4_out <= pc_plus4_in; alu_result_out <= alu_result_in;
            store_data_out <= store_data_in; rd_out <= rd_in;
            reg_write_out <= reg_write_in; mem_read_out <= mem_read_in;
            mem_write_out <= mem_write_in; mem_to_reg_out <= mem_to_reg_in;
            branch_target_out <= branch_target_in; branch_taken_out <= branch_taken_in;
        end
    end
endmodule
