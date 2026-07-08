`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 12:14:13
// Design Name: 
// Module Name: 8_bit_ALU
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


module ALU(
    input  [7:0] InputA,
    input  [7:0] InputB,
    input  [2:0] OpCode,

    output reg [15:0] OutALU,
    output reg COut
);

always @(*) begin

    // Default values
    OutALU = 16'd0;
    COut   = 1'b0;

    case(OpCode)

        // Addition
        3'b000:
        begin
            {COut, OutALU[7:0]} = InputA + InputB;
            OutALU[15:8] = 8'd0;
        end

        // Subtraction
        3'b001:
        begin
            {COut, OutALU[7:0]} = InputA - InputB;
            OutALU[15:8] = 8'd0;
        end

        // Multiplication
        3'b010:
        begin
            OutALU = InputA * InputB;
            COut = 1'b0;
        end

        // Left Shift
        3'b011:
        begin
            OutALU = InputA << 1;
            COut = InputA[7];
        end

        // Right Shift
        3'b100:
        begin
            OutALU = InputA >> 1;
            COut = InputA[0];
        end

        // AND
        3'b101:
        begin
            OutALU = InputA & InputB;
        end

        // OR
        3'b110:
        begin
            OutALU = InputA | InputB;
        end

        // XOR
        3'b111:
        begin
            OutALU = InputA ^ InputB;
        end

        default:
        begin
            OutALU = 16'd0;
            COut = 1'b0;
        end

    endcase

end

endmodule