module ALU(
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALUControl,
    output large_u,
    output large_s,
    output reg [31:0] Result,
    output Zero,
    output Negative,
    output reg OverFlow,
    output Carry
);

// Add these internal wires
wire [32:0] sum_extended;  // 33-bit for carry detection
wire [31:0] Sum;

// Compute sum with carry
assign sum_extended = {1'b0, A} + (ALUControl[0] ? ~{1'b0, B} : {1'b0, B}) + ALUControl[0];

// Extract result and flags
assign Sum = sum_extended[31:0];
assign Carry = sum_extended[32];
assign Zero = (Result == 32'b0);
assign Negative = Result[31];
  assign large_u = A >= B;
  assign large_s = $signed(A) >= $signed(B);

always @(*) begin
    OverFlow = ~(ALUControl[0] ^ B[31] ^ A[31]) & (A[31] ^ Sum[31]) & (~ALUControl[1]);

    casex (ALUControl)
        4'b0000: Result = Sum;                       // add
        4'b0001: Result = Sum;                       // sub
        4'b0010: Result = A & B;                     // and
        4'b0011: Result = A | B;                     // or
        4'b0100: Result = A << B[4:0];               // sll
        4'b0101: Result = {{30{1'b0}}, OverFlow ^ Sum[31]}; // slt
        4'b0110: Result = A ^ B;                     // xor
        4'b0111: Result = A >> B[4:0];               // srl
        4'b1000: Result = ($unsigned(A) < $unsigned(B)); // sltu
        4'b1111: Result = $signed(A) >>> B[4:0];              // sra
        default: Result = 32'd0;
    endcase
end

endmodule