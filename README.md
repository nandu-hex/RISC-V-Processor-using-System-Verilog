# RISC-V CPU Design Using SystemVerilog

A small educational 32-bit, single-cycle RISC-V CPU implemented in SystemVerilog.

## Supported instructions
- R-type: `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`
- I-type: `ADDI`, `LW`
- S-type: `SW`
- B-type: `BEQ`
- J-type: `JAL`

This is a teaching implementation, not a complete implementation of every RV32I instruction. It assumes aligned 32-bit instruction and data accesses.

## Folder structure
- `rtl/` — synthesizable design modules
- `testbench/` — simulation testbenches
- `programs/` — sample machine-code program
- `docs/` — architecture notes
- `simulation/` — simulation notes

## Run in Vivado
1. Create an RTL project.
2. Add all `.sv` files from `rtl/` as Design Sources.
3. Add `testbench/tb_riscv_cpu.sv` as a Simulation Source.
4. Set `tb_riscv_cpu` as the simulation top.
5. Run Behavioral Simulation.
6. The instruction memory in this project has a built-in sample program, so simulation does not depend on the current working directory or the `.hex` file.

The separate `programs/test_program.hex` is provided as a readable copy of the sample program.

## Expected result
The built-in program executes:
- `x1 = 5`
- `x2 = 7`
- `x3 = x1 + x2 = 12`
- stores `12` to data memory word 0
- loads it into `x4`

At the end, `x3 == 12`, `x4 == 12`, and `data_memory[0] == 12`.

## Notes
- Register `x0` always reads as zero.
- Data memory is word-indexed internally; byte addresses from instructions are converted to word indices using address bits `[31:2]`.
- `jal` stores `PC + 4` in `rd` and jumps to `PC + immediate`.
- The project is intended for learning and can be extended with more RV32I instructions, exceptions, and stronger verification.
