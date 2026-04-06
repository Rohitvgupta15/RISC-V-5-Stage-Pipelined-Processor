module Fetch_Cycle(
    input clk,
    input rst,
    input [31:0] PCF,
    input en,
    input clr,

    output [31:0] PCPlus4F_Fed,
    output [31:0] PCPlus4D,
    output [31:0] PCD,
    output [31:0] InstrD
);

wire [31:0] InstrF;
wire [31:0] PCPlus4F;

//REGs
reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;

assign PCPlus4F_Fed = PCPlus4F;

PC_Adder PCAdder(
    .a(PCF),
    .b(32'd4),
    .c(PCPlus4F)
);

Instruction_Memory I_MEM(
    .rst(rst),
    .A(PCF),
    .RD(InstrF)
);

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
        InstrF_reg <= 32'd0;
        PCF_reg <= 32'd0;
        PCPlus4F_reg <= 32'd0;
    end
    else if (clr) begin
        InstrF_reg <= 32'd0;
        PCF_reg <= 32'd0;
        PCPlus4F_reg <= 32'd0;
    end
    else if (!en) begin
        // Normal update
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
    // else: stall → hold previous values (no assignment needed)
end

assign InstrD = InstrF_reg;
assign PCD = PCF_reg;
assign PCPlus4D = PCPlus4F_reg;

endmodule