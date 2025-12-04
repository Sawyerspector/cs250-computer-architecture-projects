# cs250-computer-architecture-projects
Projects from Duke CS250: MIPS, C, and Logisim Evolution 16-bit adder + CPU design

This repository contains a structured portfolio of major projects completed for **Duke University’s CS250: Computer Architecture**.  
Across four progressively complex modules, these projects move from **C systems programming**, to **MIPS assembly**, to **digital logic design**, and culminate in a fully functional **16-bit single-cycle CPU built in Logisim Evolution**.

Each sub-project demonstrates core competencies used in embedded systems, firmware engineering, and performance-critical software development.

---

## HW3 — Systems Programming in C  
**Folder:** `draft-project/`

A series of C programs focused on low-level computation, dynamic memory management, data parsing, and algorithmic correctness.

### Highlights
- **Non-recursive and recursive computation:**  
  Implementations of integer sequences and recurrence relations with explicit control over stack behavior.
- **Dynamic memory & linked list construction:**  
  `draft.c` reads structured text input, allocates nodes dynamically, builds a linked list, and performs custom sorting without standard libraries.
- **Memory-safe design:**  
  All code validated on Duke Linux and tested using the course’s autograder.

**Demonstrated Skills:** C, pointers, heap allocation, linked lists, sorting algorithms, file I/O, valgrind debugging.

---

## HW4 — MIPS Assembly Programming  
**Folder:** `mips/`

The same algorithms from HW3 re-implemented **entirely in MIPS assembly** using QtSpim, emphasizing register discipline, stack frames, and manual control flow.

### Highlights
- **Recursive assembly function design:**  
  `recurse.s` manually implements recursive calls, stack frames, and saved registers according to calling conventions.
- **Input parsing through syscalls:**  
  Explicit buffer and integer handling through register-level system calls.
- **Linked list creation in assembly:**  
  `draft.s` dynamically allocates memory via `sbrk`, constructs a linked list, and sorts nodes using pointer arithmetic.

**Demonstrated Skills:** Assembly, stack management, calling conventions, pointer arithmetic, manual memory allocation, debugging at the register level.

---

## HW5 — Digital Logic Design (Logisim Evolution)  
**Folder:** `LogisimAdder/`

Digital circuits built using only primitive logic elements — no prebuilt arithmetic or high-level components.

### Highlights
- **Boolean logic implementations:**  
  Circuits derived from hand-simplified Boolean expressions using AND/OR/XOR/NOT gates.
- **Custom 1-bit → 16-bit adder/subtractor:**  
  `my_adder.circ` cascades custom 1-bit full adders into a 16-bit ALU supporting addition, subtraction, and overflow detection.
- **Synchronous finite-state machine (FSM):**  
  `scorer.circ` implements timeout and possession logic using D flip-flops in a Moore-machine architecture.

**Demonstrated Skills:** Logic design, Boolean algebra, modular circuit construction, synchronous state machines.

---

## HW6 — Complete 16-bit Single-Cycle CPU (Duke 250/16)  
**Folder:** `logisim-cpu/`

A ground-up implementation of a **MIPS-like, word-addressed 16-bit CPU** supporting arithmetic, logical operations, memory access, branching, jumping, and basic I/O.

### Highlights
- **Custom ALU, register file, decoder, and control unit**  
  All datapath components constructed manually from primitive logic elements.
- **Harvard architecture:**  
  Separate instruction ROM and data memory fully compatible with the provided assembler/simulator.
- **Support for 14+ instructions:**  
  Including add/sub, logical ops, shifts, lw/sw, beq, bgez, j, jal, jr, input, and output.
- **Memory-latch integration:**  
  Falling-edge and rising-edge timing for realistic RAM behavior.
- **Executable multi-instruction programs:**  
  Verified against ISA-level tests and sample workloads.

**Demonstrated Skills:** CPU design, datapath engineering, control logic, memory systems, clock timing, assembly-level debugging.

---

