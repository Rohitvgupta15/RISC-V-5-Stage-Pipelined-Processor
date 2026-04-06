module Hazard_Unit(
    input  [4:0] Rs1D,
    input  [4:0] Rs2D,
    input  [4:0] Rs1E,
    input  [4:0] Rs2E,
    input  [4:0] RdE,
    input  [4:0] RdM,
    input  [4:0] RdW,

    input  RegWriteM,
    input  RegWriteW,
    input  ResultSrcE0,
    input  PCSrcE,
    input  rst,

    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE,
    output StallD,
    output StallF,
    output FlushD,
    output FlushE
);

wire lwStall;

always @(*) begin
    ForwardAE = 2'b00;
    ForwardBE = 2'b00;

    if ((Rs1E == RdM) & (RegWriteM) & (Rs1E != 0))
        ForwardAE = 2'b10; // Forward from Memory stage
    else if ((Rs1E == RdW) & (RegWriteW) & (Rs1E != 0))
        ForwardAE = 2'b01; // Forward from Writeback stage

    if ((Rs2E == RdM) & (RegWriteM) & (Rs2E != 0))
        ForwardBE = 2'b10;
    else if ((Rs2E == RdW) & (RegWriteW) & (Rs2E != 0))
        ForwardBE = 2'b01;
end

assign lwStall = (ResultSrcE0 == 1) & ((RdE == Rs1D) | (RdE == Rs2D));

assign StallF = lwStall & rst;
assign StallD = lwStall & rst;

assign FlushE = (lwStall | PCSrcE) & rst;
assign FlushD = PCSrcE & rst;

endmodule