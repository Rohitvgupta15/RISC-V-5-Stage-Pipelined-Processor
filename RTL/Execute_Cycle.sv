module Execute_Cycle(

    input clk,
    input rst,
    input RegWriteE,
    input MemWriteE,
    input BranchE,
    input [2:0]funct3E,
    input [3:0] ALUControlE,
    input ALUSrcAE,
    input JumpE,
    input [1:0] ALUSrcBE,
    input [1:0] ResultSrcE,
    input [4:0] RdE,

    input [31:0] RD1E,
    input [31:0] RD2E,
    input [31:0] PCE,
    input [31:0] ImmExtE,
    input [31:0] PCPlus4E,
    input [31:0] ResultW,

    input [1:0] ForwardAE,
    input [1:0] ForwardBE,

    output PCSrcE,
    output RegWriteM,
    output MemWriteM,
    output [2:0]  funct3M,
    output [31:0] ALUResultM,
    output [31:0] WriteDataM,
    output [31:0] PCPlus4M,
    output [31:0] PCTargetE,
    output [4:0] RdM,
    output [1:0] ResultSrcM
);

//Internal wires
wire [31:0] SrcAE;
wire [31:0] SrcBE;
wire [31:0] ALUResultE;
wire ZeroE, NegativeE, OverFlowE, Branchtaken;
wire [31:0] RD2E_Mux;
wire [31:0] SrcAE_Inter;
wire CarryE,large_uE,large_sE;

//Regs
reg RegWriteM_reg, MemWriteM_reg;
reg [2:0] funct3M_reg;
reg [31:0] ALUResultM_reg, WriteDataM_reg, PCPlus4M_reg;
reg [4:0] RdM_reg;
reg [1:0] ResultSrcM_reg;

ALU ALU_E (
    .A(SrcAE),
    .B(SrcBE),
    .Result(ALUResultE),
    .ALUControl(ALUControlE),
    .OverFlow(OverFlowE),
    .Zero(ZeroE),
    .Negative(NegativeE),
    .Carry(CarryE),
    .large_u(large_uE),
    .large_s(large_sE)
);

PC_Adder ADDER_E(
    .a(PCE),
    .b(ImmExtE),
    .c(PCTargetE)
);

Mux_3_by_1 MUX3X1_3(
    .a(RD2E_Mux),
    .b(ImmExtE),
    .s(ALUSrcBE),
    .c(PCTargetE),
    .d(SrcBE)
);

Mux_3_by_1 MUX3X1_1(
    .a(RD1E),
    .b(ResultW),
    .c(ALUResultM),
    .s(ForwardAE),
    .d(SrcAE_Inter)
);

assign SrcAE = (ALUSrcAE) ? 32'b0 : SrcAE_Inter;

Mux_3_by_1 MUX3X1_2(
    .a(RD2E),
    .b(ResultW),
    .c(ALUResultM),
    .s(ForwardBE),
    .d(RD2E_Mux)
);

branching_unit branch_unit(
    .funct3(funct3E),
    .Zero(ZeroE),
    .ALUR31(NegativeE),
    .Overflow(OverFlowE),
    .large_u(large_uE),
    .large_s(large_sE),
    .Branch(Branchtaken)
);

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        RegWriteM_reg <= 1'b0;
        ResultSrcM_reg <= 2'd0;
        MemWriteM_reg <= 1'd0;
        ALUResultM_reg <= 32'd0;
        WriteDataM_reg <= 32'd0;
        RdM_reg <= 5'd0;
        PCPlus4M_reg <= 32'd0;
        funct3M_reg <= 3'd0;
    end
    else begin
        RegWriteM_reg <= RegWriteE;
        ResultSrcM_reg <= ResultSrcE;
        MemWriteM_reg <= MemWriteE;
        ALUResultM_reg <= ALUResultE;
        WriteDataM_reg <= RD2E_Mux;
        RdM_reg <= RdE;
        PCPlus4M_reg <= PCPlus4E;
        funct3M_reg <= funct3E;
    end
end

//Output Assignment
assign RegWriteM = RegWriteM_reg;
assign ResultSrcM = ResultSrcM_reg;
assign MemWriteM = MemWriteM_reg;
assign ALUResultM = ALUResultM_reg;
assign WriteDataM = WriteDataM_reg;
assign RdM = RdM_reg;
assign PCPlus4M = PCPlus4M_reg;
assign funct3M = funct3M_reg;
// Branch logic
assign PCSrcE = (JumpE | (BranchE & Branchtaken));

endmodule