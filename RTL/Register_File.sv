module Register_File(
    input clk,
    input rst,
    input WE3,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
  
    output [31:0] RD1,
    output [31:0] RD2
);

    reg [31:0] Register [0:31];
    integer i;
  // initialize the registers
  always @(negedge rst)
    begin
      if(!rst) begin
      Register[0] = 32'h00000000;
        for ( i = 1; i < 32; i = i + 1) begin
          Register[i] <= 32'hffff_ffff;
        end
      end
    end
  
  always @(*)
    begin
      if(WE3 & (A3 != 5'h00)) begin
        	Register[A3] = WD3;
      end
      
      // for testing purpose
       if ($test$plusargs("SB")) begin
        Register[4] = 32'hffff_ff0f;
      end
      if ($test$plusargs("SH")) begin
        Register[4] = 32'hffff_7f0f;
      end
      if ($test$plusargs("SW")) begin
        Register[4] = 32'hffff_7f0f;
      end
    end

    assign RD1 = (rst == 1'b0) ? 32'd0 : Register[A1];
    assign RD2 = (rst == 1'b0) ? 32'd0 : Register[A2];

   

endmodule