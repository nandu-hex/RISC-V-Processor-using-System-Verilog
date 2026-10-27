# Simulation

Run `tb_alu`, `tb_register_bank`, and `tb_riscv_cpu` as separate simulation tops.

For the CPU test, expected values after the sample program executes are:
- `x3 = 12`
- `x4 = 12`
- `data memory word 0 = 12`

In Vivado, add all RTL files as Design Sources and only one testbench at a time as Simulation Sources, then select that testbench as the simulation top.
