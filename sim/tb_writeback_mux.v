`timescale 1ns / 1ps

module tb_writeback_mux;

    reg [31:0] alu_result;
    reg [31:0] mem_data;
    reg mem_to_reg;

    wire [31:0] writeback_data;

    writeback_mux uut(
        .alu_result(alu_result),
        .mem_data(mem_data),
        .mem_to_reg(mem_to_reg),
        .writeback_data(writeback_data)
    );

    initial begin

        alu_result = 10;
        mem_data   = 100;

        mem_to_reg = 0; #10; // expect 10
        mem_to_reg = 1; #10; // expect 100

        $finish;

    end

endmodule