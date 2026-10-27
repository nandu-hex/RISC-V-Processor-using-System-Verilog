`timescale 1ns/1ps
module tb_register_bank;
    logic clk, reset, write_enable;
    logic [4:0] read_addr1, read_addr2, write_addr;
    logic [31:0] write_data, read_data1, read_data2;

    register_bank dut (
        .clk(clk), .reset(reset), .write_enable(write_enable),
        .read_addr1(read_addr1), .read_addr2(read_addr2), .write_addr(write_addr),
        .write_data(write_data), .read_data1(read_data1), .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; write_enable = 0;
        read_addr1 = 0; read_addr2 = 0; write_addr = 0; write_data = 0;
        #12; reset = 0;

        write_enable = 1; write_addr = 5'd5; write_data = 32'd123;
        #10;
        write_enable = 0; read_addr1 = 5'd5; #1;
        if (read_data1 !== 32'd123) $fatal(1, "Register write/read failed");

        read_addr1 = 0; #1;
        if (read_data1 !== 32'd0) $fatal(1, "x0 must always be zero");

        $display("tb_register_bank: all tests passed");
        $finish;
    end
endmodule
