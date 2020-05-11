# SimDisasm_16
8086 Diassembler written in 16-bit assembly.

This project was written using YASM compiler and compiled under DOSBOX environment.

It disassembles most of assembly instructions except for those used in FPU.

# Compilation

Compile with YASM using DOS command line.

Example: yasm -fbin dissim.asm -o dissim.com

# Usage

dissim.com <16-bit .com file>
