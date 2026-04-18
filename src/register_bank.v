`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: register_bank
// Description:
// 32x32 Register File with 2 read ports and 1 write port.
// x0 register is always zero.
//
//////////////////////////////////////////////////////////////////////////////////


module register_bank(
    input wire clk,
    input wire rst,
    input wire reg_write,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,
    input wire [31:0] write_data,
    output wire [31:0] read_data1,
    output wire [31:0] read_data2
);
    reg [31:0] reg_array [0:31];
    integer i;

    // Writing on NEGEDGE to ensure data stability in Single Cycle
    always @(negedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                reg_array[i] <= 32'd0;
        end else begin
            if (reg_write && (rd != 5'd0))
                reg_array[rd] <= write_data;
        end
    end

    assign read_data1 = (rs1 == 5'd0) ? 32'd0 : reg_array[rs1];
    assign read_data2 = (rs2 == 5'd0) ? 32'd0 : reg_array[rs2];
endmodule