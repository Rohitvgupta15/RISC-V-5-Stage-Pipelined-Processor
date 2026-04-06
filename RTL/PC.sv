module PC_Module(
    input clk,
    input rst,
    input en,
    input PCSrcE,
    input [31:0] PCPlus4F,
    input [31:0] PCTargetE,
  
    output reg [31:0] PC
);

    wire [31:0] PC_Next;

    always @(posedge clk or negedge rst)
    begin
        if(rst == 1'b0)
            PC <= 32'd0;
        else if(!en)
            PC <= PC_Next;
        else
            PC <= 32'd0;
    end

    Mux MUX_FETCH(
        .a(PCPlus4F),
        .b(PCTargetE),
        .s(PCSrcE),
        .c(PC_Next)
    );

endmodule