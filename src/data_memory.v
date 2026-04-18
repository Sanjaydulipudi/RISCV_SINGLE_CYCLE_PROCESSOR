`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: data_memory
// Description:
// Simple data memory for load and store operations.
//
//////////////////////////////////////////////////////////////////////////////////

module data_memory(

    input wire clk,
    input wire mem_read,
    input wire mem_write,

    input wire [31:0] address,
    input wire [31:0] write_data,

    output wire [31:0] read_data

    );

    reg [31:0] mem_array [0:31];

    integer i;

    // Initialize memory
    initial begin
        for(i = 0; i < 32; i = i + 1)
            mem_array[i] = 0;
    end

    // WRITE (clocked)
    always @(posedge clk) begin
        if (mem_write)
            mem_array[address[31:2]] <= write_data;
    end

    // READ (combinational)
    assign read_data = (mem_read) ? mem_array[address[31:2]] : 32'd0;

endmodule