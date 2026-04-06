`include "ALU.sv"
`include "Control_Unit_Top.sv"
`include "Data_Memory.sv"
`include "Decode_Cycle.sv"
`include "Execute_Cycle.sv"
`include "Fetch_Cycle.sv"
`include "Instruction_Memory.sv"
`include "Memory_Cycle.sv"
`include "Mux.sv"
`include "PC_Adder.sv"
`include "PC.sv"
`include "Register_File.sv"
`include "Sign_Extend.sv"
`include "Writeback_Cycle.sv"
`include "Hazard_Unit.sv"
`include "branch.sv"
`include "ALU_Decoder.sv"
`include "Main_Decoder.sv"

module Pipeline_top (
    input clk,
    input rst
);

    // Declaration of Interim Wires
    wire PCSrcE, RegWriteW, RegWriteE, ALUSrcAE, MemWriteE, BranchE, RegWriteM, MemWriteM;
    wire [1:0] ResultSrcM, ResultSrcW, ResultSrcE, ALUSrcBE;
    wire JumpE;
    wire [3:0] ALUControlE;
    wire [4:0] RDE, RDM, RDW;
    wire [31:0] PCTargetE, PCPlus4F_Fed, InstrD, InstrE, PCD, PCPlus4D;
    wire [31:0] ResultW, RD1E, RD2E, ImmExtE, PCE, PCPlus4E;
    wire [31:0] PCPlus4M, WriteDataM, ALUResultM;
    wire [31:0] PCPlus4W, ALUResultW, ReadDataW;
    wire [4:0] RS1_E, RS2_E;
    wire [1:0] ForwardBE, ForwardAE;
    wire [31:0] PC;

    wire [4:0] Rs1D, Rs2D;
    wire [2:0] funct3E,funct3M;
    wire StallD, StallF, FlushD, FlushE;

    // ================= FETCH STAGE =================
    PC_Module Program_Counter (
        .clk(clk),
        .rst(rst),
        .PC(PC),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .PCPlus4F(PCPlus4F_Fed),
        .en(StallF)
    );

    Fetch_Cycle Fetch (
        .clk(clk),
        .rst(rst),
        .PCF(PC),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .PCPlus4F_Fed(PCPlus4F_Fed),
        .en(StallD),
        .clr(FlushD)
    );

    // ================= DECODE STAGE =================
    Decode_Cycle Decode (
        .clk(clk),
        .rst(rst),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcAE(ALUSrcAE),
        .ALUSrcBE(ALUSrcBE),
        .JumpE(JumpE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ImmExtE(ImmExtE),
        .RDE(RDE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .RS1E(RS1_E),
        .RS2E(RS2_E),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .clr(FlushE),
        .funct3E(funct3E)
     );

    // ================= EXECUTE STAGE =================
    Execute_Cycle Execute (
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .ALUSrcAE(ALUSrcAE),
        .ALUSrcBE(ALUSrcBE),
        .JumpE(JumpE),
        .MemWriteE(MemWriteE),
        .funct3E(funct3E),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ImmExtE(ImmExtE),
        .RdE(RDE),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RdM(RDM),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALUResultM(ALUResultM),
        .ResultW(ResultW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .funct3M(funct3M)
    );

    // ================= MEMORY STAGE =================
    Memory_Cycle Memory (
        .clk(clk),
        .rst(rst),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .funct3M(funct3M),
        .ResultSrcM(ResultSrcM),
        .RdM(RDM),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALUResultM(ALUResultM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RdW(RDW),
        .PCPlus4W(PCPlus4W),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW)
    );

    // ================= WRITEBACK STAGE =================
    Writeback_Cycle WriteBack (
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW),
        .PCPlus4W(PCPlus4W),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .ResultW(ResultW)
    );

    // ================= HAZARD UNIT =================
    Hazard_Unit HazardUnit (
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .ResultSrcE0(ResultSrcE[0]),
        .PCSrcE(PCSrcE),
        .RdM(RDM),
        .RdW(RDW),
        .RdE(RDE),
        .Rs1E(RS1_E),
        .Rs2E(RS2_E),
        .Rs1D(Rs1D),
        .Rs2D(Rs2D),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .StallD(StallD),
        .StallF(StallF),
        .FlushD(FlushD),
        .FlushE(FlushE),
        .rst(rst)
    );

endmodule