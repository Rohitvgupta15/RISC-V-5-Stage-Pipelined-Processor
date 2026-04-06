# 🚀 RISC-V 5-Stage Pipelined Processor

This repository contains a **32-bit RISC-V 5-stage pipelined processor** implemented in Verilog HDL.
The design follows a modular approach with clearly separated pipeline stages and supporting units.

---

## 📌 Features

* 5-stage pipeline architecture

  * IF (Instruction Fetch)
  * ID (Instruction Decode)
  * EX (Execute)
  * MEM (Memory Access)
  * WB (Write Back)
* Modular and hierarchical design
* Hazard handling unit included
* Supports simulation in Vivado and EDA Playground

---

## 🧾 Supported Instructions

### 🔹 Arithmetic (R-Type)

```
add, sub, sll, slt, sltu, xor, srl, sra, or, and
```

### 🔹 Arithmetic (I-Type)

```
addi, slti, sltiu, xori, ori, andi, slli, srli, srai
```

### 🔹 Memory Access

```
lb, lh, lw, lbu, lhu
sb, sh, sw
```

### 🔹 Control Flow

```
beq, bne, blt, bge, bltu, bgeu
```

### 🔹 Jumps

```
jal, jalr
```

### 🔹 Upper Immediate

```
lui, auipc
```

---

## 🏗️ Design Hierarchy

```
TOP : TOP_Group_no_5 (TOP_pipeline.sv)

├── Program_Counter : PC_Module (PC.sv)
│   └── MUX_FETCH : Mux (Mux.sv)

├── Fetch : Fetch_Cycle (Fetch_Cycle.sv)
│   ├── PCAdder : PC_Adder (PC_Adder.sv)
│   └── I_MEM : Instruction_Memory (Instruction_Memory.sv)

├── Decode : Decode_Cycle (Decode_Cycle.v)
│   ├── ctrl_unit : Control_Unit_Top (Control_Unit_Top.sv)
│   │   ├── Main_Decoder (Main_Decoder.sv)
│   │   └── ALU_Decoder (ALU_Decoder.sv)
│   ├── RegFile : Register_File (Register_File.sv)
│   └── SignExtend : Sign_Extend (Sign_Extend.sv)

├── Execute : Execute_Cycle (Execute_Cycle.sv)
│   ├── ALU_E : ALU (ALU.sv)
│   ├── ADDER_E : PC_Adder (PC_Adder.sv)
│   ├── MUX3X1_3 : Mux_3_by_1 (Mux.sv)
│   ├── MUX3X1_1 : Mux_3_by_1 (Mux.sv)
│   └── MUX3X1_2 : Mux_3_by_1 (Mux.sv)
│   └── branch_unit : branching_unit branch.sv)

├── Memory : Memory_Cycle (Memory_Cycle.sv)
│   └── DataMem : Data_Memory (Data_Memory.sv)

├── WriteBack : Writeback_Cycle (Writeback_Cycle.sv)
│   └── result_mux : Mux_3_by_1 (Mux.sv)

├── HazardUnit : Hazard_Unit (Hazard_Unit.sv)

├── Instructions (instructions.hex)
└── Waveform (waveform)
```

---

## 🛠️ Tools Used

* Verilog / SystemVerilog
* Xilinx Vivado
* EDA Playground

---

## ▶️ Running in Vivado

Use the following Tcl command:

```tcl
set_property -name {xsim.simulate.xsim.more_options} -value {-testplusarg <textcase_name> } -objects [get_filesets sim_1]
close_sim
launch_simulation
eg. 
set_property -name {xsim.simulate.xsim.more_options} -value {-testplusarg bne_pass} -objects [get_filesets sim_1]
close_sim
launch_simulation
```

### Steps:

1. Open project in Vivado
2. Add all design and testbench files
3. Run simulation
4. Execute the Tcl command
5. Observe waveform/output

---

## 🌐 Run on EDA Playground

👉 https://edaplayground.com/x/Hk9n

### Steps:

1. Open the link
2. Click **Run**
3. View output and waveform

---

## 🎥 Demo

A demo video is included in this repository demonstrating:

* Simulation flow
* Execution of instructions
* Pipeline behavior
  [![Watch Demo](https://github.com/Rohitvgupta15/RISC-V-5-Stage-Pipelined-Processor/blob/main/VIDEO/step_to_run_testcases.mp4)
---
# Q1. Maximum of 5 Numbers (Pipelined Processor)

## 📌 Description

This program is written for a **5-stage pipelined RISC-V processor**.
It initializes 5 numbers, compares them sequentially, finds the **maximum value**, and stores the result in memory.

---

## 🧠 Instruction Memory (with Assembly)

```verilog
mem[0]  = 32'h00f00513;   // addi x10, x0, 15     -> x10 = 15
mem[1]  = 32'h02a00593;   // addi x11, x0, 42     -> x11 = 42
mem[2]  = 32'h00700613;   // addi x12, x0, 7      -> x12 = 7
mem[3]  = 32'h05900693;   // addi x13, x0, 89     -> x13 = 89
mem[4]  = 32'h01700713;   // addi x14, x0, 23     -> x14 = 23

mem[5]  = 32'h000502b3;   // add  x5, x10, x0     -> x5 = x10
mem[6]  = 32'h00b2d463;   // bge  x5, x11, +8     -> if x5 >= x11 skip next
mem[7]  = 32'h000582b3;   // add  x5, x11, x0     -> update max

mem[8]  = 32'h00c2d463;   // bge  x5, x12, +8
mem[9]  = 32'h000602b3;   // add  x5, x12, x0

mem[10] = 32'h00d2d463;   // bge  x5, x13, +8
mem[11] = 32'h000682b3;   // add  x5, x13, x0

mem[12] = 32'h00e2d463;   // bge  x5, x14, +8
mem[13] = 32'h000702b3;   // add  x5, x14, x0

mem[14] = 32'h00502023;   // sw   x5, 0(x0)       -> store max value
mem[15] = 32'h00000063;   // beq  x0, x0, 0       -> infinite loop (halt)
```

---

## ⚙️ Functionality

* Initializes values: **15, 42, 7, 89, 23**
* Compares values sequentially
* Stores the **maximum value (89)** in memory
* Ends with an infinite loop

---

## ⏱️ Clock Cycle Calculation

For a **5-stage pipeline**:

```
Total cycles = Number of instructions + (Pipeline stages - 1)
             = 16 + (5 - 1)
             = 20 cycles
```

---

## 📷 Simulation Waveform

![Simulation Waveform](https://github.com/Rohitvgupta15/RISC-V-5-Stage-Pipelined-Processor/blob/main/VIDEO/max_cycle_decimal.png)

You can see the start and stop clock difference is **200 ns**, and one clock cycle is **10 ns**, so total **20 clock cycles** this code takes.
This matches with the **calculated result**.
Also when MemwriteE is one at that time we are writing the data mem[0] location.
![Simulation Waveform](https://github.com/Rohitvgupta15/RISC-V-5-Stage-Pipelined-Processor/blob/main/VIDEO/max_mem_data.png)

---

## ✅ Conclusion

* The pipeline executes the program in **20 clock cycles (ideal case)**
* Simulation result matches theoretical calculation
* Confirms correct pipeline behavior

---
# Q2. Bubble Sort of 5 Numbers (Pipelined Processor with Initialization)

## 📌 Description

This program is written for a **5-stage pipelined RISC-V processor**.
It initializes 5 numbers, performs **bubble sort using multiple passes**, and stores the **sorted values in memory**.

---

## 🧠 Instruction Memory (with Assembly)

```verilog
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
mem[21] = 32'h00115863;
mem[22] = 32'h00008333;
mem[23] = 32'h000100b3;
mem[24] = 32'h00030133;

mem[25] = 32'h0021d863;
mem[26] = 32'h00010333;
mem[27] = 32'h00018133;
mem[28] = 32'h000301b3;

mem[29] = 32'h00325863;
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
mem[55] = 32'h00000013; // NOP
```

---

## ⚙️ Functionality

* Initializes values: **5, 3, 8, 4, 2**
* Performs **bubble sort** using multiple passes
* Uses **compare and swap operations**
* Stores sorted values in memory locations starting from address 1

👉 Final sorted output: **2, 3, 4, 5, 8**

---

## ⏱️ Clock Cycle Analysis

```text
Total instructions = 56
```

### 🔹 Theoretical Calculation (with pipeline fill)

```
Total cycles = N + (pipeline stages - 1)
             = 56 + (5 - 1)
             = 60 cycles
```

---

### 🔹 Simulation Result

However, in simulation:

👉 **Observed cycles = 56 cycles**

### ✅ Reason:

* Pipeline **fill cycles are not counted** in waveform
* No **stalling or branch penalty** is implemented
* Processor achieves **ideal throughput (1 instruction per cycle)**

---

## 📷 Simulation Waveform

![Simulation Waveform](https://github.com/Rohitvgupta15/RISC-V-5-Stage-Pipelined-Processor/blob/main/VIDEO/sort_cycle.png)

You can see the start and stop clock difference is **560 ns**, and one clock cycle is **10 ns**, so total **56 clock cycles** this code takes.
This matches with the **observed execution**.

Also when **MemWriteE is high**, sorted values are written sequentially into memory.

![Simulation Waveform](https://github.com/Rohitvgupta15/RISC-V-5-Stage-Pipelined-Processor/blob/main/VIDEO/sort_mem.png)

---

## ✅ Conclusion

* The program ideally requires **60 cycles** including pipeline latency
* Simulation shows **56 cycles** due to steady-state execution
* Confirms **1 instruction per cycle (CPI = 1)**
* Demonstrates efficient pipeline utilization without stalls

---


## 📈 Applications

* Computer architecture learning
* FPGA-based processor design
* Academic and research projects

---

## 👨‍💻 Author

**Rohit Gupta**
M.Tech, IIT Gandhinagar
Integrated Circuit Design and Technology

---

## ⭐ License

This project is intended for academic and educational use.
