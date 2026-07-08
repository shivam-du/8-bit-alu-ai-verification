`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 12:22:12
// Design Name: 
// Module Name: 8_bit_ALU_tb
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


`timescale 1ns/1ps

module ALU_tb;

reg [7:0] InputA;
reg [7:0] InputB;
reg [2:0] OpCode;

wire [15:0] OutALU;
wire COut;

ALU uut (
    .InputA(InputA),
    .InputB(InputB),
    .OpCode(OpCode),
    .OutALU(OutALU),
    .COut(COut)
);

initial begin

    $display("Time\tA\tB\tOpcode\tOutALU\tCOut");
    $monitor("%0t\t%d\t%d\t%b\t%d\t%b",
             $time,
             InputA,
             InputB,
             OpCode,
             OutALU,
             COut);

    //-------------------------------------
    // Case 1
    //-------------------------------------

    InputA = 45;
    InputB = 38;

    OpCode = 3'b000; #10;   // Addition

    OpCode = 3'b001; #10;   // Subtraction

    OpCode = 3'b110; #10;   // OR

    OpCode = 3'b111; #10;   // XOR

    //-------------------------------------
    // Case 2
    //-------------------------------------

    InputA = 49;
    InputB = 10;

    OpCode = 3'b010; #10;   // Multiplication

    OpCode = 3'b011; #10;   // Left Shift

    OpCode = 3'b100; #10;   // Right Shift

    OpCode = 3'b101; #10;   // AND

    $finish;

end

endmodule
