
module top_tb;

reg rst;
reg clk=0;
integer i;

Pipeline_top TEST(clk,rst);

initial begin
    rst=0;
    #20;
    rst=1;
  #5000 $finish;
end


initial begin
    forever #5 clk=~clk;
end



initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_tb);   // dump testbench
    $dumpvars(0, TEST);     // dump DUT
end
integer j;

initial begin
    #5000;   // just before $finish
    $display("\n========== DATA MEMORY DUMP ==========");
  for (j = 0; j < 22; j = j + 1) begin
    $display("MEM[%0d] = %h    |  %0d", j, TEST.Memory.DataMem.mem[j],TEST.Memory.DataMem.mem[j]);
    end
    $display("======================================\n");
  
  $display("\n========== Register data DUMP ==========");
  for (j = 0; j < 10; j = j + 1) begin
    $display("REG[%0d] = %h", j, TEST.Decode.RegFile.Register[j]);
    end
    $display("======================================\n");
end
endmodule