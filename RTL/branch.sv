   module branching_unit (
    input  [2:0] funct3,
    input        Zero,
    input        ALUR31,
    input        Overflow,
    input        large_s,
    input        large_u,
    output reg   Branch
);

    initial begin
        Branch = 1'b0;
    end
                
    always @(*) begin
        case (funct3)
            3'b000: Branch = Zero;                  // beq
            3'b001: Branch = !Zero;                 // bne
            3'b100: Branch = !large_s;   // blt (signed)
            3'b101: Branch = large_s;  // bge (signed)
            3'b110: Branch = !large_u;              // bltu (unsigned)
            3'b111: Branch = large_u;             // bgeu (unsigned)
            default: Branch = 1'b0;
        endcase
    end

endmodule