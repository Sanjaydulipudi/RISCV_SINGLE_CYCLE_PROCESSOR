`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: execute_alu_decoder
// Description:
// Decodes funct3 and funct7 to generate ALU operation control signal.
//
//////////////////////////////////////////////////////////////////////////////////

module execute_alu_decoder(
    input wire [31:0] instruction,
    output reg [3:0] alu_op
);

    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];

   always @(*) begin
    case (opcode)

        // ================= R-TYPE =================
        7'b0110011: begin
            case ({funct7, funct3})
                10'b0000000_000: alu_op = 4'd0; // ADD
                10'b0100000_000: alu_op = 4'd1; // SUB
                10'b0000000_111: alu_op = 4'd2; // AND
                10'b0000000_110: alu_op = 4'd3; // OR
                10'b0000000_100: alu_op = 4'd4; // XOR
                default:         alu_op = 4'd15; // INVALID
            endcase
        end

        // ================= I-TYPE =================
        7'b0010011: begin
            case (funct3)
                3'b000: alu_op = 4'd0; // ADDI
                3'b111: alu_op = 4'd2; // ANDI
                3'b110: alu_op = 4'd3; // ORI
                3'b100: alu_op = 4'd4; // XORI
                default: alu_op = 4'd15;
            endcase
        end

        // ================= LOAD / STORE =================
        7'b0000011,
        7'b0100011: begin
            alu_op = 4'd0; // address calc
        end

        // ================= BRANCH =================
        7'b1100011: begin
            alu_op = 4'd1; // use SUB for comparison
        end

        default: alu_op = 4'd15; // INVALID
    endcase
end
endmodule