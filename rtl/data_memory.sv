module data_memory #(
    parameter integer WORDS = 256
) (
    input  logic        clk,
    input  logic        write_enable,
    input  logic [31:0] address,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);
    logic [31:0] memory [0:WORDS-1];
    integer i;

    initial begin
        for (i = 0; i < WORDS; i = i + 1)
            memory[i] = 32'd0;
    end

    always_ff @(posedge clk) begin
        if (write_enable && (address[1:0] == 2'b00) && (address[31:2] < WORDS))
            memory[address[31:2]] <= write_data;
    end

    always_comb begin
        if ((address[1:0] != 2'b00) || (address[31:2] >= WORDS))
            read_data = 32'd0;
        else
            read_data = memory[address[31:2]];
    end
endmodule
