module Writeback_Cycle(
    input clk, 
    input rst,
    input [1:0] ResultSrcW,
    input [31:0] PCPlus4W, 
    input [31:0] ALUResultW, 
    input [31:0] ReadDataW,
  
    output [31:0] ResultW
);
  
    Mux_3_by_1 result_mux(    
    .a(ALUResultW),
    .b(ReadDataW),
    .c(PCPlus4W),
    .s(ResultSrcW),
    .d(ResultW)
    );

endmodule
