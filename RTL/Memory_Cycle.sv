module Memory_Cycle(
    input clk,
    input rst,
    input RegWriteM,
    input MemWriteM,
    input [31:0] ALUResultM,
    input [31:0] WriteDataM,
    input [31:0] PCPlus4M,
    input [4:0] RdM,
    input [2:0] funct3M,
    input [1:0] ResultSrcM,

    output [31:0] ReadDataW,
    output [31:0] PCPlus4W,
    output [31:0] ALUResultW,
    output RegWriteW,
    output [1:0] ResultSrcW,
    output [4:0] RdW
);

wire [31:0] ReadDataM;

Data_Memory DataMem(
    .clk(clk),
    .rst(rst),
    .WE(MemWriteM),
    .funct3(funct3M),
    .WD(WriteDataM),
    .A(ALUResultM),
    .RD(ReadDataM)
);

reg [31:0] ReadDataW_reg, PCPlus4W_reg, ALUResultW_reg;
reg [4:0] RdW_reg;
reg RegWriteW_reg;
reg [1:0] ResultSrcW_reg;

always @(posedge clk or negedge rst) begin
   if (!rst) begin
        ReadDataW_reg <= 32'd0;
        RdW_reg <= 5'd0;
        PCPlus4W_reg <= 32'd0;
        ALUResultW_reg <= 32'd0;
        RegWriteW_reg <= 1'd0;
        ResultSrcW_reg <= 2'd0;    
    end
    else begin
        ReadDataW_reg <= ReadDataM;
        RdW_reg <= RdM;
        PCPlus4W_reg <= PCPlus4M;
        ALUResultW_reg <= ALUResultM;
        RegWriteW_reg <= RegWriteM;
        ResultSrcW_reg <= ResultSrcM;
    end
end

assign ReadDataW = ReadDataW_reg;
assign RdW = RdW_reg;
assign PCPlus4W = PCPlus4W_reg;
assign ALUResultW = ALUResultW_reg;
assign RegWriteW = RegWriteW_reg;
assign ResultSrcW = ResultSrcW_reg;

endmodule