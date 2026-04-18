`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2026 09:47:06
// Design Name: 
// Module Name: tb_fetch_pc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_fetch_pc;

    reg clk;
    reg rst;
    reg [31:0] next_pc;

    wire [31:0] current_pc;

    // DUT Instantiation
    fetch_pc uut (

        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .current_pc(current_pc)

    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;
        next_pc = 0;

        #10;
        rst = 0;

        next_pc = 32'd4;
        #10;

        next_pc = 32'd8;
        #10;

        next_pc = 32'd12;
        #10;

        $finish;

    end

endmodule
