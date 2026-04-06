module Data_Memory(
    input clk,
    input rst,
    input WE, 
    input [2:0] funct3,
    input [31:0] A,
    input [31:0] WD,
  
    output reg [31:0] RD
);

    reg [31:0] mem [0:1023];
  
    reg [31:0] read_data;
    always @(posedge clk)
    begin
        if (WE) begin 
          case(funct3)
            3'b000: mem[A] <= {{24{WD[7]}},WD[7:0]};  // sb- store byte
            3'b001: mem[A] <= {{16{WD[15]}},WD[15:0]};// sh- store half word
            3'b010: mem[A] <= WD[31:0];               // sw- store word
          endcase
        end 
     end
  
  always @(*)
    begin
      if (!rst) 
         RD = 0;
      else 
         begin 
           read_data = mem[A];
          case(funct3)
            3'b000: RD = {{24{read_data[7]}},read_data[7:0]}; // lb- load byte
            3'b001: RD = {{16{read_data[15]}},read_data[15:0]};// lh- load half word
            3'b010: RD = read_data[31:0];                      // lw- load word
            3'b100: RD = {{24{1'b0}},read_data[7:0]};      // lbu- load byte unsigned
            3'b101: RD = {{16{1'b0}},read_data[15:0]};       // lhu- load half unsigned
          endcase
        end
     end
//  for testcase purpose
   initial begin
     mem[0] = 32'hffff_ff0d;
   end
endmodule

