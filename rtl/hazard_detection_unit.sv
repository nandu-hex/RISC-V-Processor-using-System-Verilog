module hazard_detection_unit (
    input  logic       id_ex_mem_read,
    input  logic [4:0] id_ex_rd,
    input  logic [4:0] if_id_rs1,
    input  logic [4:0] if_id_rs2,
    input  logic       if_id_uses_rs2,
    output logic       pc_stall,
    output logic       if_id_stall,
    output logic       id_ex_flush
);
    // Detect the classic load-use hazard. The decode stage should assert
    // if_id_uses_rs2 for instructions whose operation reads rs2 (e.g. R-type,
    // SW, BEQ), and deassert it for immediate/load/jump instructions.
    logic uses_rs1;
    always_comb begin
        uses_rs1 = (if_id_rs1 != 5'd0);
        pc_stall = 1'b0;
        if_id_stall = 1'b0;
        id_ex_flush = 1'b0;

        if (id_ex_mem_read && (id_ex_rd != 5'd0) &&
            ((id_ex_rd == if_id_rs1) ||
             (if_id_uses_rs2 && (id_ex_rd == if_id_rs2)))) begin
            pc_stall = 1'b1;
            if_id_stall = 1'b1;
            id_ex_flush = 1'b1;
        end
    end
endmodule
