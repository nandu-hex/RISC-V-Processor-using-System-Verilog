module immediate_generator (
    input  logic [31:0] instruction,
    output logic [31:0] immediate
);
    logic [6:0] opcode;

    always_comb begin
        opcode = instruction[6:0];
        case (opcode)
            7'b0010011, // OP-IMM (ADDI)
            7'b0000011: // LOAD (LW)
                immediate = {{20{instruction[31]}}, instruction[31:20]};

            7'b0100011: // STORE
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            7'b1100011: // BRANCH
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7],
                             instruction[30:25], instruction[11:8], 1'b0};

            7'b1101111: // JAL
                immediate = {{11{instruction[31]}}, instruction[31],
                             instruction[19:12], instruction[20],
                             instruction[30:21], 1'b0};

            default:
                immediate = 32'd0;
        endcase
    end
endmodule
