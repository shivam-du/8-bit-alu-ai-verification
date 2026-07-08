`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 13:34:14
// Design Name: 
// Module Name: 8_bit_ALU_improved_tb
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


`timescale 1ns / 1ps

module ALU_improved_tb;

    // Inputs
    reg [7:0] InputA;
    reg [7:0] InputB;
    reg [2:0] OpCode;

    // Outputs
    wire [15:0] OutALU;
    wire COut;

    // Instantiate the ALU
    ALU uut (
        .InputA(InputA),
        .InputB(InputB),
        .OpCode(OpCode),
        .OutALU(OutALU),
        .COut(COut)
    );

    // Monitor all signals
    initial begin
        $display("---------------------------------------------------------------");
        $display(" Time\tInputA\tInputB\tOpcode\tOutALU\t\tCOut");
        $display("---------------------------------------------------------------");

        $monitor("%4t\t%3d\t%3d\t%b\t%5d (0x%h)\t%b",
                 $time, InputA, InputB, OpCode, OutALU, OutALU, COut);
    end

    // Apply test vectors
    initial begin

        //---------------------------------------------------------
        // Required Test Case 1
        //---------------------------------------------------------
        InputA = 8'd45;
        InputB = 8'd38;

        OpCode = 3'b000; #10;   // Addition
        OpCode = 3'b001; #10;   // Subtraction
        OpCode = 3'b110; #10;   // OR
        OpCode = 3'b111; #10;   // XOR

        //---------------------------------------------------------
        // Required Test Case 2
        //---------------------------------------------------------
        InputA = 8'd49;
        InputB = 8'd10;

        OpCode = 3'b010; #10;   // Multiplication
        OpCode = 3'b011; #10;   // Left Shift
        OpCode = 3'b100; #10;   // Right Shift
        OpCode = 3'b101; #10;   // AND

        //---------------------------------------------------------
        // Edge Case 1 : Zero Inputs
        //---------------------------------------------------------
        InputA = 8'd0;
        InputB = 8'd0;

        OpCode = 3'b000; #10;
        OpCode = 3'b101; #10;

        //---------------------------------------------------------
        // Edge Case 2 : Addition Overflow
        //---------------------------------------------------------
        InputA = 8'hFF;     //255
        InputB = 8'h01;     //1
        OpCode = 3'b000;
        #10;

        //---------------------------------------------------------
        // Edge Case 3 : Subtraction Result = Zero
        //---------------------------------------------------------
        InputA = 8'd100;
        InputB = 8'd100;
        OpCode = 3'b001;
        #10;

        //---------------------------------------------------------
        // Edge Case 4 : Multiplication Maximum
        //---------------------------------------------------------
        InputA = 8'hFF;
        InputB = 8'hFF;
        OpCode = 3'b010;
        #10;

        //---------------------------------------------------------
        // Edge Case 5 : Left Shift Boundary
        //---------------------------------------------------------
        InputA = 8'b10000000;
        InputB = 8'd0;
        OpCode = 3'b011;
        #10;

        //---------------------------------------------------------
        // Edge Case 6 : Right Shift Boundary
        //---------------------------------------------------------
        InputA = 8'b00000001;
        InputB = 8'd0;
        OpCode = 3'b100;
        #10;

        //---------------------------------------------------------
        // Edge Case 7 : Logical Operations with Max Values
        //---------------------------------------------------------
        InputA = 8'hFF;
        InputB = 8'h0F;

        OpCode = 3'b101; #10;   // AND
        OpCode = 3'b110; #10;   // OR
        OpCode = 3'b111; #10;   // XOR

        //---------------------------------------------------------
        // Random Test Vectors
        //---------------------------------------------------------
        repeat (10)
        begin
            InputA = $random;
            InputB = $random;
            OpCode = $random % 8;
            #10;
        end

        //---------------------------------------------------------
        // End Simulation
        //---------------------------------------------------------
        $display("\nSimulation Completed Successfully.");
        $finish;

    end

endmodule