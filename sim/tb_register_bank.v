`timescale 1ns / 1ps

module tb_register_bank;

    reg clk;
    reg reg_write;

    reg [4:0] rs1, rs2, rd;
    reg [31:0] write_data;

    wire [31:0] read_data1, read_data2;

    register_bank uut (

        .clk(clk),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reg_write = 0;

        // Write to register x1
        rd = 5'd1;
        write_data = 32'd10;
        reg_write = 1;
        #10;

        // Read from x1
        reg_write = 0;
        rs1 = 5'd1;
        rs2 = 5'd0;
        #10;

        // Write to x2
        rd = 5'd2;
        write_data = 32'd20;
        reg_write = 1;
        #10;

        // Read x1 and x2
        reg_write = 0;
        rs1 = 5'd1;
        rs2 = 5'd2;
        #10;

        // Try writing to x0 (should not change)
        rd = 5'd0;
        write_data = 32'd100;
        reg_write = 1;
        #10;

        rs1 = 5'd0;
        #10;

        $finish;

    end

endmodule