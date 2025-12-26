# ELC3030 – 8-bit Pipelined Processor

This repository contains the design and implementation of a **simple 8-bit pipelined RISC-like processor** developed as a course project for **ELC3030 – Advanced Processor Architecture** at the Faculty of Engineering, Cairo University.

---

## 🧠 Project Overview
The goal of this project is to design and implement a functional processor that demonstrates core computer architecture concepts, including:
- Instruction Set Architecture (ISA) design
- Pipelining
- FSM-based control unit
- Resource sharing using a single memory
- Stack-based interrupt handling

The processor follows a simplified RISC philosophy and supports arithmetic, logical, control-flow, memory, and I/O instructions.

---

## ⚙️ Processor Specifications
- **Data Width:** 8-bit  
- **Registers:**  
  - 4 General Purpose Registers (R0–R3)  
  - R3 also acts as the Stack Pointer (SP)  
- **Program Counter:** 8-bit  
- **Memory:**  
  - 256 bytes, byte-addressable  
- **Architecture:** Von Neumann  
- **Instruction Length:** 1 byte or 2 bytes  
- **Interrupt:** Single non-maskable interrupt with context saving  

---

## 🧩 Main Components
- Program Counter (PC)
- Register File
- Arithmetic Logic Unit (ALU)
- Condition Code Register (Z, N, C, V)
- FSM-based Control Unit
- Unified Instruction/Data Memory
- Stack and Interrupt Logic
- Pipeline Registers

---

## 🧾 Instruction Set Architecture (ISA)

### 🔹 A-Format Instructions
| Mnemonic | Opcode | Bytes | Description |
|--------|--------|-------|------------|
| NOP | 0 | 1 | No operation |
| MOV | 1 | 1 | R[ra] ← R[rb] |
| ADD | 2 | 1 | R[ra] ← R[ra] + R[rb] (Updates Z, N, C, V) |
| SUB | 3 | 1 | R[ra] ← R[ra] − R[rb] (Updates Z, N, C, V) |
| AND | 4 | 1 | Bitwise AND |
| OR  | 5 | 1 | Bitwise OR |
| RLC | 6 | 1 | Rotate left through carry |
| RRC | 6 | 1 | Rotate right through carry |
| SETC | 6 | 1 | Set carry flag |
| CLRC | 6 | 1 | Clear carry flag |
| PUSH | 7 | 1 | Push R[rb] to stack |
| POP | 7 | 1 | Pop stack to R[rb] |
| OUT | 7 | 1 | Output R[rb] to OUT.PORT |
| IN | 7 | 1 | Read IN.PORT to R[rb] |
| NOT | 8 | 1 | One’s complement |
| NEG | 8 | 1 | Two’s complement |
| INC | 8 | 1 | Increment register |
| DEC | 8 | 1 | Decrement register |

---

### 🔹 B-Format Instructions (Control Flow)
| Mnemonic | Opcode | Bytes | Description |
|--------|--------|-------|------------|
| JZ | 9 | 1 | Jump if Z flag = 1 |
| JN | 9 | 1 | Jump if N flag = 1 |
| JC | 9 | 1 | Jump if C flag = 1 |
| JV | 9 | 1 | Jump if V flag = 1 |
| LOOP | 10 | 1 | Decrement R[ra], jump if not zero |
| JMP | 11 | 1 | Unconditional jump |
| CALL | 11 | 1 | Subroutine call (push PC) |
| RET | 11 | 1 | Return from subroutine |
| RTI | 11 | 1 | Return from interrupt (restore flags) |

---

### 🔹 L-Format Instructions (Memory Operations)
| Mnemonic | Opcode | Bytes | Description |
|--------|--------|-------|------------|
| LDM | 12 | 2 | Load immediate value |
| LDD | 12 | 2 | Load from memory (direct) |
| STD | 12 | 2 | Store to memory (direct) |
| LDI | 13 | 1 | Load from memory (indirect) |
| STI | 14 | 1 | Store to memory (indirect) |

---

### 🔹 Condition Code Register (CCR)
| Flag | Description |
|----|------------|
| Z | Zero flag |
| N | Negative flag |
| C | Carry flag |
| V | Overflow flag |

---

### 🔹 Special Signals
| Signal | Function |
|------|----------|
| RESET | PC ← M[0] |
| INTERRUPT | X[SP--] ← PC, PC ← M[1], flags preserved |

---

## 🛠️ Tools & Simulation
- **HDL:** Verilog  
- **Simulation:** ModelSim / EDA Playground  
- **Waveform Analysis:** VCD dump enabled  

---

## ▶️ How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ELC3030-8bit-Pipelined-Processor.git
