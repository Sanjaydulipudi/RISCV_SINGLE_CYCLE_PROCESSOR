`timescale 1ns / 1ps

module tb_fetch_next_pc;
    reg [31:0] current_pc;
    wire [31:0] incremented_pc;

    fetch_next_pc uut(
        .current_pc(current_pc),
        .incremented_pc(incremented_pc)
    );

    initial begin
        current_pc = 32'd0;
        #10;
        current_pc = 32'd4;
        #10;
        current_pc = 32'd8;
        #10;
        current_pc = 32'd12;
        #10;
        $finish;
    end
endmodule