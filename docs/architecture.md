# Architecture Notes

The CPU is a simple single-cycle datapath. The program counter addresses instruction memory. The instruction decoder splits fields from the instruction, the control unit selects operations, the register bank supplies operands, and the ALU performs arithmetic or calculates memory/branch addresses. Loads return data from data memory; stores write data on the active clock edge. The next PC is selected between `PC + 4` and a branch/jump target.

## Supported instruction encodings
- R-type opcode `0110011`: ADD, SUB, AND, OR, XOR, SLT
- ADDI opcode `0010011`, funct3 `000`
- LW opcode `0000011`, funct3 `010`
- SW opcode `0100011`, funct3 `010`
- BEQ opcode `1100011`, funct3 `000`
- JAL opcode `1101111`

## Simplifications
This educational design does not implement all RV32I instructions, exceptions, interrupts, privilege modes, byte/halfword loads and stores, or misalignment traps.
