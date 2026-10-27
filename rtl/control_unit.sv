module control_unit (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic       reg_write,
    output logic       alu_src_imm,
    output logic       mem_write,
    output logic       mem_read,
    output logic       mem_to_reg,
    output logic       branch_eq,
    output logic       jump,
    output logic [2:0] alu_control
);
    always_comb begin
        reg_write   = 1'b0;
        alu_src_imm = 1'b0;
        mem_write   = 1'b0;
        mem_read    = 1'b0;
        mem_to_reg  = 1'b0;
        branch_eq   = 1'b0;
        jump        = 1'b0;
        alu_control = 3'b000;

        case (opcode)
            7'b0110011: begin // R-type
                reg_write = 1'b1;
                case (funct3)
                    3'b000: alu_control = (funct7 == 7'b0100000) ? 3'b001 : 3'b000;
                    3'b111: alu_control = 3'b010; // AND
                    3'b110: alu_control = 3'b011; // OR
                    3'b100: alu_control = 3'b100; // XOR
                    3'b010: alu_control = 3'b101; // SLT
                    default: begin reg_write = 1'b0; alu_control = 3'b000; end
                endcase
            end

            7'b0010011: begin // ADDI
                reg_write   = 1'b1;
                alu_src_imm = 1'b1;
                alu_control = 3'b000;
                if (funct3 != 3'b000) reg_write = 1'b0;
            end

            7'b0000011: begin // LW
                reg_write   = 1'b1;
                alu_src_imm = 1'b1;
                mem_read    = 1'b1;
                mem_to_reg  = 1'b1;
                alu_control = 3'b000;
                if (funct3 != 3'b010) reg_write = 1'b0;
            end

            7'b0100011: begin // SW
                alu_src_imm = 1'b1;
                mem_write   = 1'b1;
                alu_control = 3'b000;
                if (funct3 != 3'b010) mem_write = 1'b0;
            end

            7'b1100011: begin // BEQ
                branch_eq   = (funct3 == 3'b000);
                alu_control = 3'b001;
            end

            7'b1101111: begin // JAL
                reg_write = 1'b1;
                jump      = 1'b1;
            end

            default: begin end
        endcase
    end
endmodule
