`timescale 1ns/1ps
module mem_wb_register (
    input logic clk, reset,

    input logic [31:0] memory_data_in, alu_result_in, pc_plus4_in,
    input logic [4:0] rd_in,
    input logic reg_write_in, mem_to_reg_in, jump_in,

    output logic [31:0] memory_data_out, alu_result_out, pc_plus4_out,
    output logic [4:0] rd_out,
    output logic reg_write_out, mem_to_reg_out, jump_out
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            memory_data_out <= 0; alu_result_out <= 0; pc_plus4_out <= 0;
            rd_out <= 0; reg_write_out <= 0; mem_to_reg_out <= 0; jump_out <= 0;
        end else begin
            memory_data_out <= memory_data_in; alu_result_out <= alu_result_in;
            pc_plus4_out <= pc_plus4_in; rd_out <= rd_in;
            reg_write_out <= reg_write_in; mem_to_reg_out <= mem_to_reg_in;
            jump_out <= jump_in;
        end
    end
endmodule
