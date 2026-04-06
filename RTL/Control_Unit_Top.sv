module Control_Unit_Top(
    input  [6:0] Op,
    input  [6:0] funct7,
    input  [2:0] funct3,
  
    output RegWrite,
    output ALUSrcA,
    output MemWrite,
    output Branch,
    output Jump,
    output [2:0] ImmSrc,
    output [3:0] ALUControl,
    output [1:0] ResultSrc,
    output [1:0] ALUSrcB
);

    wire [1:0] ALUOp;

    Main_Decoder Main_Decoder(
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUSrcA(ALUSrcA),
        .ALUOp(ALUOp),
        .Jump(Jump),
        .ALUSrcB(ALUSrcB)
    );

    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );

endmodule