module Instruction_Memory (
    input        rst,
    input  [31:0] A,
  
    output [31:0] RD
);

  reg [31:0] mem [0:127];
  integer i;


  // Read logic
  assign RD = (rst == 1'b0) ? 32'b0 : mem[A[31:2]] ;

  // Instruction initialization all test cases (total 37 instruction)
 initial begin
      
   if ($test$plusargs("hex")) begin
    $display({60{"="}});
    $display("CUSTOM HEX FILE INSTRUCTION");
    $display({60{"="}});
    $readmemh("instruction.hex",mem);
end
// ============================================================
// R-TYPE INSTRUCTION TESTS (rd=x4, rs1=x3, rs2=x2)
// ============================================================
  
if ($test$plusargs("ADD")) begin
    $display({60{"="}});
    $display("ADD TEST");
    $display({60{"="}});
    mem[0] = 32'h00218233;   // add x4, x3, x2
end

if ($test$plusargs("SUB")) begin
    $display({60{"="}});
    $display("SUB TEST");
    $display({60{"="}});
    mem[0] = 32'h40218233;   // sub x4, x3, x2
end

if ($test$plusargs("SLL")) begin // SET LOGICAL LEFT  (SIGNED)
    $display({60{"="}});
    $display("SLL TEST");
    $display({60{"="}});
    mem[0] = 32'h00400113;   // addi x2,x0,4
    mem[1] = 32'h00219233;   // sll x4, x3, x2
end

if ($test$plusargs("SLT")) begin // SET LESS THAN  (SIGNED)
    $display({60{"="}});
    $display("SLT TEST");
    $display({60{"="}});
    mem[0] = 32'h00400113;   // addi x2,x0,4
    mem[1] = 32'h0021A233;   // slt x4, x3, x2 ; x3 = ffff_ffff = -1 ;  x4 = (x3 < x2) ? 1 : 0
end

if ($test$plusargs("SLTU")) begin // SET LESS THAN  (UNSIGNED)
    $display({60{"="}});
    $display("SLTU TEST");
    $display({60{"="}});
    mem[0] = 32'h00400113;   // addi x2,x0,4
    mem[1] = 32'h0021B233;   // sltu x4, x3, x2
end

if ($test$plusargs("XOR")) begin
    $display({60{"="}});
    $display("XOR TEST");
    $display({60{"="}});
    mem[0] = 32'h0ff00113;   // addi x2,x0,255 :- x2 = 0000_00FF
    mem[1] = 32'h0021C233;   // xor x4, x3, x2
end

if ($test$plusargs("SRL")) begin //SHIFT RIGHT LOGICAL
    $display({60{"="}});
    $display("SRL TEST");
    $display({60{"="}});
    mem[0] = 32'h00400113;   // addi x2,x0,4
    mem[1] = 32'h0021D233;   // srl x4, x3, x2
end

if ($test$plusargs("SRA")) begin //SHIFT RIGHT ARTHIMETIC(SIGNED EXTENTED)
    $display({60{"="}});
    $display("SRA TEST");
    $display({60{"="}});
    mem[0] = 32'h4021D233;   // sra x4, x3, x2
end

if ($test$plusargs("OR")) begin
    $display({60{"="}});
    $display("OR TEST");
    $display({60{"="}});
    mem[0] = 32'h0f000113;   // addi x2,x0,240  :- x2 = 0000_00F0
    mem[1] = 32'h0021E233;   // or x4, x3, x2
end

if ($test$plusargs("AND")) begin
    $display({60{"="}});
    $display("AND TEST");
    $display({60{"="}});
    mem[0] = 32'h0f000113;   // addi x2,x0,240  :- x2 = 0000_00F0
    mem[1] = 32'h0021F233;   // and x4, x3, x2
end

// ============================================================
// I-TYPE ARITHMETIC INSTRUCTION TESTS (rd=x4, rs1=x3)
// ============================================================

if ($test$plusargs("addi")) begin
    $display({60{"="}});
    $display("ADDI TEST");
    $display({60{"="}});
    mem[0] = 32'h00518213;   // addi x4, x3, 5
end

if ($test$plusargs("slti")) begin  // SET LESS THAN IMMEDIATE (SIGNED) 
    $display({60{"="}});
    $display("SLTI TEST");
    $display({60{"="}});
    mem[0] = 32'h0051a213;   // slti x4, x3, 5 : X3 = ffff_ffff = -1
end

if ($test$plusargs("sltiu")) begin  // SET LESS THAN IMMEDIATE (unSIGNED) 
    $display({60{"="}});
    $display("SLTIU TEST");
    $display({60{"="}});
    mem[0] = 32'h0051B213;   // sltiu x4, x3, 5
end

if ($test$plusargs("xori")) begin
    $display({60{"="}});
    $display("XORI TEST");
    $display({60{"="}});
    mem[0] = 32'h0051C213;   // xori x4, x3, 5
end

if ($test$plusargs("ori")) begin
    $display({60{"="}});
    $display("ORI TEST");
    $display({60{"="}});
    mem[0] = 32'h0051E213;   // ori x4, x3, 5
end

if ($test$plusargs("andi")) begin
    $display({60{"="}});
    $display("ANDI TEST");
    $display({60{"="}});
    mem[0] = 32'h0051F213;   // andi x4, x3, 5
end

if ($test$plusargs("slli")) begin
    $display({60{"="}});
    $display("SLLI TEST");
    $display({60{"="}});
    mem[0] = 32'h00419213;   // slli x4, x3, 4
end

if ($test$plusargs("srli")) begin
    $display({60{"="}});
    $display("SRLI TEST");
    $display({60{"="}});
    mem[0] = 32'h0041D213;   // srli x4, x3, 4
end

if ($test$plusargs("srai")) begin
    $display({60{"="}});
    $display("SRAI TEST");
    $display({60{"="}});
    mem[0] = 32'h4021D213;   // srai x4, x3, 2
end

// ============================================================
// MEMORY ACCESS INSTRUCTION TESTS
// Base = x0 → address = 0(x0)
// Store src = x4, Load dest = x5
//    mem[0] = 32'hffff_ff0d;
// ============================================================

// ===================== LOADS =====================

if ($test$plusargs("LB")) begin
    $display({60{"="}});
    $display("LB TEST");
    $display({60{"="}});
    mem[0] = 32'h00000283;   // lb x5, 0(x0)
end

if ($test$plusargs("LH")) begin
    $display({60{"="}});
    $display("LH TEST");
    $display({60{"="}});
    mem[0] = 32'h00001283;   // lh x5, 0(x0)
end

if ($test$plusargs("LW")) begin
    $display({60{"="}});
    $display("LW TEST");
    $display({60{"="}});
    mem[0] = 32'h00002283;   // lw x5, 0(x0)
end

if ($test$plusargs("LBU")) begin
    $display({60{"="}});
    $display("LBU TEST");
    $display({60{"="}});
    mem[0] = 32'h00004283;   // lbu x5, 0(x0)
end

if ($test$plusargs("LHU")) begin
    $display({60{"="}});
    $display("LHU TEST");
    $display({60{"="}});
    mem[0] = 32'h00005283;   // lhu x5, 0(x0)
end


// ===================== STORES =====================

if ($test$plusargs("SB")) begin
    $display({60{"="}});
    $display("SB TEST");
    $display({60{"="}});     // Register[4] = 32'hffff_ff0f;
    mem[0] = 32'h00400023;   // sb x4, 0(x0)
end

if ($test$plusargs("SH")) begin
    $display({60{"="}});
    $display("SH TEST");
    $display({60{"="}});     // Register[4] = 32'hffff_7f0f;
    mem[0] = 32'h00401023;   // sh x4, 0(x0)
end

if ($test$plusargs("SW")) begin
    $display({60{"="}});
    $display("SW TEST");
    $display({60{"="}});     // Register[4] = 32'hffff_7f0f;
    mem[0] = 32'h00402023;   // sw x4, 0(x0)
end
   

// ============================================================
// BRANCH INSTRUCTION TESTS
// Covers: BEQ, BNE, BLT, BGE, BLTU, BGEU
// Result: mem[0] = 1 (PASS), 0 (FAIL)
// ============================================================


// ---------------- BEQ (Branch if Equal) ----------------
   if ($test$plusargs("beq_pass")) begin 
    $display({60{"="}});
     $display("BEQ PASS TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00300293;   // addi x5, x0, 3
    mem[1] = 32'h00300313;   // addi x6, x0, 3
    mem[2] = 32'h00628863;   // beq x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BNE (Branch if Not Equal) ----------------
   if ($test$plusargs("bne_pass")) begin 
    $display({60{"="}});
     $display("BNE PASS TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00300293;   // addi x5, x0, 3
    mem[1] = 32'h00500313;   // addi x6, x0, 5
    mem[2] = 32'h00629863;   // bne x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BLT (Signed Less Than) ----------------
   if ($test$plusargs("blt_pass")) begin 
    $display({60{"="}});
     $display("BLT PASS TEST"); 
    $display({60{"="}});

    mem[0] = 32'hfff00293;   // addi x5, x0, -1
    mem[1] = 32'h00100313;   // addi x6, x0, 1
    mem[2] = 32'h0062c863;   // blt x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BGE (Signed Greater or Equal) ----------------
   if ($test$plusargs("bge_pass")) begin 
    $display({60{"="}});
  $display("BGE TEST...."); 
    $display({60{"="}});

    mem[0] = 32'h00100293;   // addi x5, x0,  1
    mem[1] = 32'hfff00313;   // addi x6, x0, -1
    mem[2] = 32'h0062d863;   // bge x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BLTU (Unsigned Less Than) ----------------
   if ($test$plusargs("bltu_pass")) begin 
    $display({60{"="}});
    $display("BLTU TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00300293;   // addi x5, x0,  3
    mem[1] = 32'h00500313;   // addi x6, x0, 5
    mem[2] = 32'h0062e863;   // bltu x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BGEU (Unsigned Greater or Equal) ----------------
   if ($test$plusargs("bgeu_pass")) begin 
    $display({60{"="}});
    $display("BGEU TEST"); 
    $display({60{"="}});
   
    mem[0] = 32'h00500293;   // addi x5, x0,  5
    mem[1] = 32'h00300313;   // addi x6, x0, 3
    mem[2] = 32'h0062f863;   // bgeu x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ============================================================
// END OF BRANCH TESTS
// ============================================================
   
// ============================================================
// BRANCH FAIL TESTS
// Covers: beq_fail, bne_fail, blt_fail, bge_fail, bltu_fail, bgeu_fail
// Result: mem[0] = 0 (PASS for FAIL case), 1 (WRONG)
// ============================================================


// ---------------- BEQ FAIL (Branch NOT taken) ----------------
if ($test$plusargs("beq_fail")) begin 
    $display({60{"="}});
    $display("BEQ FAIL TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00500293;   // addi x5, x0, 5
    mem[1] = 32'h00300313;   // addi x6, x0, 3
    mem[2] = 32'h00628863;   // beq x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BNE FAIL (Branch NOT taken) ----------------
if ($test$plusargs("bne_fail")) begin 
    $display({60{"="}});
    $display("BNE FAIL TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00300293;   // addi x5, x0, 3
    mem[1] = 32'h00300313;   // addi x6, x0, 3
    mem[2] = 32'h00629863;   // bne x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BLT FAIL (Signed) ----------------
if ($test$plusargs("blt_fail")) begin 
    $display({60{"="}});
    $display("BLT FAIL TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00100293;   // addi x5, x0,  1
    mem[1] = 32'hfff00313;   // addi x6, x0, -1
    mem[2] = 32'h0062c863;   // blt x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BGE FAIL (Signed) ----------------
if ($test$plusargs("bge_fail")) begin 
    $display({60{"="}});
  $display("BGE FAIL TESTff"); 
    $display({60{"="}});

    mem[0] = 32'hfff00293;   // addi x5, x0, -1
    mem[1] = 32'h00100313;   // addi x6, x0, 1
    mem[2] = 32'h0062d863;   // bge x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BLTU FAIL (Unsigned) ----------------
if ($test$plusargs("bltu_fail")) begin 
    $display({60{"="}});
    $display("BLTU FAIL TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00500293;   // addi x5, x0,  5
    mem[1] = 32'h00300313;   // addi x6, x0, 3
    mem[2] = 32'h0062e863;   // bltu x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ---------------- BGEU FAIL (Unsigned) ----------------
if ($test$plusargs("bgeu_fail")) begin 
    $display({60{"="}});
    $display("BGEU FAIL TEST"); 
    $display({60{"="}});

    mem[0] = 32'h00300293;   // addi x5, x0,  3
    mem[1] = 32'h00500313;   // addi x6, x0, 5
    mem[2] = 32'h0062f863;   // bgeu x5, x6, equal (offset=16)
    mem[3] = 32'h00000393;   // addi x7, x0, 0
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00c0006f;   // jal x0, done (offset=12)
    mem[6] = 32'h00100393;   // addi x7, x0, 1
    mem[7] = 32'h00702023;   // sw x7, 0(x0)
    mem[8] = 32'h00000013;   // nop (addi x0, x0, 0)
end


// ============================================================
// END OF FAIL TESTS
// ============================================================
 
// ===================xxxxxx===================================

// ---------------- JAL PASS ----------------
   
   
if ($test$plusargs("jal_pass")) begin
    $display({60{"="}});
    $display("JAL PASS TEST");
    $display({60{"="}});

    mem[0] = 32'h008000ef;   // jal x1, 8   (jump to mem[2])
    mem[1] = 32'h00000393;   // addi x7, x0, 0  (should skip)
    mem[2] = 32'h00100393;   // addi x7, x0, 1
    mem[3] = 32'h00702023;   // sw x7, 0(x0)
    mem[4] = 32'h00000013;   // nop
end


// ---------------- JALR PASS ----------------
if ($test$plusargs("jalr_pass")) begin
    $display({60{"="}});
    $display("JALR PASS TEST");
    $display({60{"="}});

    mem[0] = 32'h00800093;   // addi x1, x0, 8   (target addr)
    mem[1] = 32'h00000393;   // addi x7, x0, 0   (should skip)
    mem[2] = 32'h00008167;   // jalr x2, 0(x1)   (jump to mem[2] → infinite safe loop avoided) store next pc(return address)
    mem[3] = 32'h00100393;   // addi x7, x0, 1
    mem[4] = 32'h00702023;   // sw x7, 0(x0)
    mem[5] = 32'h00000013;   // nop
end

   
// ---------------- LUI PASS ----------------
if ($test$plusargs("lui_pass")) begin
    $display({60{"="}});
    $display("LUI PASS TEST");
    $display({60{"="}});

    mem[0] = 32'h000012b7;   // lui x5, 0x1       → x5 = 0x00001000
    mem[1] = 32'h00011337;   // lui x6, 0x11       → x6 = 0x00011000
end


// ---------------- AUIPC PASS ----------------
if ($test$plusargs("auipc_pass")) begin
    $display({60{"="}});
    $display("AUIPC PASS TEST");
    $display({60{"="}});
    //rd = PC + (imm << 12)
    mem[0] = 32'h00000297;   // auipc x5, 0x0     → x5 = PC (0)
    mem[1] = 32'h00000317;   // auipc x6, 0x0     → x6 = PC (4)
   mem[2] = 32'h00001397;   // auipc x7, 0x1     → x6 = PC (4) rd = PC + (imm << 12)
    mem[3] = 32'h00000417;   // auipc x8, 0x0     → x6 = PC (4)
end
      // ---------------- BACK-TO-BACK ADD ----------------
   if ($test$plusargs("back_to_back_add")) begin
          $display({60{"="}});
          $display("BACK TO BACK ADD TEST");
          $display({60{"="}});

          mem[0]  = 32'h00a00293;   // addi x5, x0, 10
          mem[1]  = 32'h01400313;   // addi x6, x0, 20
          mem[2]  = 32'h01e00393;   // addi x7, x0, 30
          mem[3]  = 32'h02800413;   // addi x8, x0, 40
          mem[4]  = 32'h03200493;   // addi x9, x0, 50
          mem[5]  = 32'h00628533;   // add x10, x5, x6
          mem[6]  = 32'h00750533;   // add x10, x10, x7
          mem[7]  = 32'h00850533;   // add x10, x10, x8
          mem[8]  = 32'h00950533;   // add x10, x10, x9
          mem[9]  = 32'h00a02023;   // sw x10, 0(x0)
          mem[10] = 32'h00000013;   // nop
      end
   
     // ---------------- Hazard Unit  ----------------
   	  if ($test$plusargs("data_hazard")) begin
          $display({60{"="}});
          $display("DATA HAZARD TEST (RAW)");
          $display({60{"="}});

          mem[0] = 32'h00a00293;   // addi x5, x0, 10
          mem[1] = 32'h01400313;   // addi x6, x0, 20

          mem[2] = 32'h006283b3;   // add x7, x5, x6
          mem[3] = 32'h00730333;   // add x6, x6, x7  (RAW hazard on x7)

          mem[4] = 32'h00602023;   // sw x6, 0(x0)
          mem[5] = 32'h00000013;   // nop
      end
   
     if ($test$plusargs("load_hazard")) begin
         $display({60{"="}});
         $display("LOAD-USE HAZARD TEST");
         $display({60{"="}});

          mem[0] = 32'h00A00193;   // addi x3, x0, 10
          mem[1] = 32'h00002283;   // lw x5, 0(x0)
          mem[2] = 32'h00328333;   // add x6, x5, x3 (LOAD hazard)
          mem[3] = 32'h00602023;   // sw x6, 0(x0)
          mem[4] = 32'h00000013;   // nop
    end
   
    if ($test$plusargs("control_hazard")) begin
        $display({60{"="}});
        $display("CONTROL HAZARD TEST");
        $display({60{"="}});

        mem[0] = 32'h00a00293;   // addi x5, x0, 10
        mem[1] = 32'h00a00313;   // addi x6, x0, 10
        mem[2] = 32'h00628863;   // beq x5, x6, 16  (offset = 16)
        mem[3] = 32'h00100393;   // addi x7, x0, 1  (should be flushed ❌)
        mem[4] = 32'h00200393;   // addi x7, x0, 2  (branch target ✅)
        mem[5] = 32'h00702023;   // sw x7, 0(x0)
    end
   
   if ($test$plusargs("sum_n_natural")) begin
        $display({60{"="}});
        $display("SUM OF NATURAL NUMBER");
        $display({60{"="}});
        mem[0] = 32'h03200093;   // addi x1, x0, 100     -> x1 = 100
        mem[1] = 32'h00000113;   // addi x2, x0, 0       -> x2 = 0
        mem[2] = 32'h00100193;   // addi x3, x0, 1       -> x3 = 1
        mem[3] = 32'h00308863;   // beq  x1, x3, +12     -> branch if x1 == x3
        mem[4] = 32'h00310133;   // add  x2, x2, x3      -> x2 += x3
        mem[5] = 32'h00118193;   // addi x3, x3, 1       -> x3++
        mem[6] = 32'hff5ff06f;   // jal  x0, -12         -> jump back to mem[4]
        mem[7] = 32'h00202023;   // sw   x2, 0(x0)       -> store sum at address 0
        mem[8] = 32'h00000013;   // nop                  -> addi x0, x0, 0
    end
   
   if ($test$plusargs("fibonacci")) begin
        $display({60{"="}});
     $display("FIBONACCI TEST");
        $display({60{"="}});
        mem[0] = 32'h01400093;   // addi x1, x0, 20       -> x1 = 20
        mem[1] = 32'h00000113;   // addi x2, x0, 0        -> x2 = 0
        mem[2] = 32'h00100193;   // addi x3, x0, 1        -> x3 = 1
        mem[3] = 32'h00200293;   // addi x5, x0, 2        -> x5 = 2
        mem[4] = 32'h00100313;   // addi x6, x0, 1        -> x6 = 1
        mem[5] = 32'h00232023;   // sw   x2, 0(x6)        -> store x2 at [x6+0]
        mem[6] = 32'h00130313;   // addi x6, x6, 1        -> x6++
        mem[7] = 32'h00332023;   // sw   x3, 0(x6)        -> store x3 at [x6+0]
        mem[8] = 32'h00130313;   // addi x6, x6, 1        -> x6++
        mem[9] = 32'h02128063;   // beq  x5, x1, +32      -> branch if x5 == x1
        mem[10] = 32'h00310233;  // add  x4, x2, x3       -> x4 = x2 + x3
        mem[11] = 32'h00432023;  // sw   x4, 0(x6)        -> store x4 at [x6+0]
        mem[12] = 32'h00018133;  // add  x2, x3, x0       -> x2 = x3
        mem[13] = 32'h000201b3;  // add  x3, x4, x0       -> x3 = x4
        mem[14] = 32'h00130313;  // addi x6, x6, 1        -> x6++
        mem[15] = 32'h00128293;  // addi x5, x5, 1        -> x5++
        mem[16] = 32'hfe5ff06f;  // jal  x0, -28          -> jump back (loop)
        mem[17] = 32'h00102023;  // sw   x1, 0(x0)        -> store x1 at address 0end
  end
   if ($test$plusargs("bubble_sort")) begin
    $display({60{"="}});
     $display("BUBBLE SORT TEST");
    $display({60{"="}});
   		mem[0]  = 32'h00500093; // addi x1, x0, 5   → x1 = 5
        mem[1]  = 32'h00300113; // addi x2, x0, 3   → x2 = 3
        mem[2]  = 32'h00800193; // addi x3, x0, 8   → x3 = 8
        mem[3]  = 32'h00400213; // addi x4, x0, 4   → x4 = 4
        mem[4]  = 32'h00200293; // addi x5, x0, 2   → x5 = 2

        // -------- PASS 1 --------
        mem[5]  = 32'h00115863; // bge x2, x1 → if x2>=x1 skip swap
        mem[6]  = 32'h00008333; // add x6, x1, x0 → temp = x1
        mem[7]  = 32'h000100b3; // add x1, x2, x0 → x1 = x2
        mem[8]  = 32'h00030133; // add x2, x6, x0 → x2 = temp

        mem[9]  = 32'h0021d863; // bge x3, x2 → compare
        mem[10] = 32'h00010333; // temp = x2
        mem[11] = 32'h00018133; // x2 = x3
        mem[12] = 32'h000301b3; // x3 = temp

        mem[13] = 32'h00325863; // bge x4, x3
        mem[14] = 32'h00018333; // temp = x3
        mem[15] = 32'h000201b3; // x3 = x4
        mem[16] = 32'h00030233; // x4 = temp

        mem[17] = 32'h0042d863; // bge x5, x4
        mem[18] = 32'h00020333; // temp = x4
        mem[19] = 32'h00028233; // x4 = x5
        mem[20] = 32'h000302b3; // x5 = temp

        // -------- PASS 2 --------
        mem[21] = 32'h00115863; // compare x2,x1
        mem[22] = 32'h00008333; // swap
        mem[23] = 32'h000100b3;
        mem[24] = 32'h00030133;

        mem[25] = 32'h0021d863; // compare x3,x2
        mem[26] = 32'h00010333;
        mem[27] = 32'h00018133;
        mem[28] = 32'h000301b3;

        mem[29] = 32'h00325863; // compare x4,x3
        mem[30] = 32'h00018333;
        mem[31] = 32'h000201b3;
        mem[32] = 32'h00030233;

        // -------- PASS 3 --------
        mem[33] = 32'h00115863;
        mem[34] = 32'h00008333;
        mem[35] = 32'h000100b3;
        mem[36] = 32'h00030133;

        mem[37] = 32'h0021d863;
        mem[38] = 32'h00010333;
        mem[39] = 32'h00018133;
        mem[40] = 32'h000301b3;

        // -------- PASS 4 --------
        mem[41] = 32'h00115863;
        mem[42] = 32'h00008333;
        mem[43] = 32'h000100b3;
        mem[44] = 32'h00030133;

        // -------- STORE SORTED VALUES --------
        mem[45] = 32'h00100393; // addi x7, x0, 1 → base addr = 1

        mem[46] = 32'h0013a023; // sw x1, 0(x7)
        mem[47] = 32'h00138393; // x7++
        mem[48] = 32'h0023a023; // sw x2

        mem[49] = 32'h00138393; // x7++
        mem[50] = 32'h0033a023; // sw x3

        mem[51] = 32'h00138393; // x7++
        mem[52] = 32'h0043a023; // sw x4

        mem[53] = 32'h00138393; // x7++
        mem[54] = 32'h0053a023; // sw x5

        // -------- END --------
        mem[55] = 32'h00000063; // beq x0,x0,0 → infinite loop
        end
     if ($test$plusargs("max_number")) begin
          $display({60{"="}});
          $display("MAX NUMBER OUT OF 5 NO. TEST");
          $display({60{"="}});

          mem[0]  = 32'h00f00513;   // addi x10, x0, 15     -> x10 = 15
          mem[1]  = 32'h02a00593;   // addi x11, x0, 42     -> x11 = 42
          mem[2]  = 32'h00700613;   // addi x12, x0, 7      -> x12 = 7
          mem[3]  = 32'h05900693;   // addi x13, x0, 89     -> x13 = 89
          mem[4]  = 32'h01700713;   // addi x14, x0, 23     -> x14 = 23

          mem[5]  = 32'h000502b3;   // add  x5, x10, x0     -> x5 = x10 (15)
          mem[6]  = 32'h00b2d463;   // bge  x5, x11, +8     -> if x5 >= x11 skip next
          mem[7]  = 32'h000582b3;   // add  x5, x11, x0     -> x5 = x11 (max so far)

          mem[8]  = 32'h00c2d463;   // bge  x5, x12, +8     -> compare with x12
          mem[9]  = 32'h000602b3;   // add  x5, x12, x0     -> update max

          mem[10] = 32'h00d2d463;   // bge  x5, x13, +8     -> compare with x13
          mem[11] = 32'h000682b3;   // add  x5, x13, x0     -> update max

          mem[12] = 32'h00e2d463;   // bge  x5, x14, +8     -> compare with x14
          mem[13] = 32'h000702b3;   // add  x5, x14, x0     -> update max

          mem[14] = 32'h00502023;   // sw   x5, 0(x0)       -> store max value to mem[0]
          mem[15] = 32'h00000013;   // NOP
       end

 end  
endmodule
