`timescale 1ns / 1ps

module tb_data_memory;

    reg clk;
    reg mem_read, mem_write;

    reg [31:0] address;
    reg [31:0] write_data;

    wire [31:0] read_data;

    data_memory uut(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        mem_write = 1;
        mem_read = 0;

        // Write 100 to address 4
        address = 4;
        write_data = 100;
        #10;

        // Read from address 4
        mem_write = 0;
        mem_read = 1;
        #10;

        $finish;

    end

endmodule