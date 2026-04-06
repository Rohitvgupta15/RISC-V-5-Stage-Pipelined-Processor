# 🚀 RISC-V 5-Stage Pipelined Processor

This repository contains the implementation of a **32-bit RISC-V 5-stage pipelined processor** using Verilog HDL.
The design follows the classical pipeline stages to improve instruction throughput and performance.

---

## 📌 Features

* 5-stage pipelined architecture

  * IF (Instruction Fetch)
  * ID (Instruction Decode)
  * EX (Execute)
  * MEM (Memory Access)
  * WB (Write Back)
* Modular Verilog design
* Simulation support in Vivado and EDA Playground
* Instruction memory and pipeline registers implemented

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

## 🛠️ Tools Used

* Verilog HDL
* Xilinx Vivado
* EDA Playground

---

## ▶️ Running in Vivado

Use the following command in the **Tcl console**:

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

1. Open the project in Vivado
2. Add all design and testbench files
3. Run simulation
4. Execute the above Tcl command
5. Observe waveform/output

---

## 🌐 Run on EDA Playground

👉 https://edaplayground.com/x/Hk9n

### Steps:

1. Open the link
2. Click **Run**
3. Observe output in console/waveform

---

## 🎥 Demo

A demo video is included in this repository showing:

* How to run the design
* Simulation results
* Pipeline execution

---

## 📂 Project Structure

```
TOP : TOP_Group_no_5 (TOP_pipeline.sv) ├── Program_Counter : PC_Module (PC.sv) │ └── MUX_FETCH : Mux (Mux.sv) ├── Fetch : Fetch_Cycle (Fetch_Cycle.sv) │ ├── PCAdder : PC_Adder (PC_Adder.sv) │ └── I_MEM : Instruction_Memory (Instruction_Memory.sv) ├── Decode : Decode_Cycle (Decode_Cycle.v) │ ├── ctrl_unit : Control_Unit_Top (Control_Unit_Top.sv) │ │ ├── Main_Decoder (Main_Decoder.sv) │ │ └── ALU_Decoder (ALU_Decoder.sv) │ ├── RegFile : Register_File (Register_File.sv) │ └── SignExtend : Sign_Extend (Sign_Extend.sv) ├── Execute : Execute_Cycle (Execute_Cycle.sv) │ ├── ALU_E : ALU (ALU.sv) │ ├── ADDER_E : PC_Adder (PC_Adder.sv) │ ├── MUX3X1_3 : Mux_3_by_1 (Mux.sv) │ ├── MUX3X1_1 : Mux_3_by_1 (Mux.sv) │ └── MUX3X1_2 : Mux_3_by_1 (Mux.sv) ├── Memory : Memory_Cycle (Memory_Cycle.sv) │ └── DataMem : Data_Memory (Data_Memory.sv) ├── WriteBack : Writeback_Cycle (Writeback_Cycle.sv) │ └── result_mux : Mux_3_by_1 (Mux.sv) ├── HazardUnit : Hazard_Unit (Hazard_Unit.sv) ├── Instructions (instructions.data) ├── Reg File (reg_file.data) └── Waveform (waveform)
```

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

This project is for academic and educational purposes.
