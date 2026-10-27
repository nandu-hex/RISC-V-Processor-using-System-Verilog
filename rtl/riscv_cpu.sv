module riscv_cpu (
    input  logic        clk,
    input  logic        reset,
    output logic [31:0] pc,
    output logic [31:0] current_instruction,
    output logic [31:0] debug_x3,
    output logic [31:0] debug_x4,
    output logic [31:0] debug_mem0
);
    logic [31:0] next_pc, memory_address, memory_write_data, memory_read_data;
    logic memory_write_enable;

    program_counter pc_reg (
        .clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc)
    );

    instruction_memory imem (
        .address(pc), .instruction(current_instruction)
    );

    data_memory dmem (
        .clk(clk), .write_enable(memory_write_enable),
        .address(memory_address), .write_data(memory_write_data),
        .read_data(memory_read_data)
    );

    processor_datapath datapath (
        .clk(clk), .reset(reset), .pc(pc), .instruction(current_instruction),
        .memory_read_data(memory_read_data), .next_pc(next_pc),
        .memory_address(memory_address), .memory_write_data(memory_write_data),
        .memory_write_enable(memory_write_enable),
        .debug_x3(debug_x3), .debug_x4(debug_x4)
    );

    always_comb begin
        debug_mem0 = dmem.memory[0];
    end
endmodule
