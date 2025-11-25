# Logisim CPU Project

Single-cycle implementation of a 16-bit MIPS-like CPU (word-addressed). Supports arithmetic, logical, memory, branching, jumps, jal, jr, and basic I/O operations.

Key design components:
- ALU
- Tri-state register file (8 registers)
- Instruction decode
- Next-PC logic
- Sign-extension and control unit
- Harvard instruction/data memory
- Memory-latch interface for RAM

Fully compatible with the provided assembler/simulator and passes automated test programs.

