# RISC-V.complete

This folder contains the verified output files that should be generated when you
follow the instructions in the How-To-RISC-V tutorial. You can install the
tutorial on your PYNQ board by following the instructions in the parent
directory.

It contains the following files and folders:

- README.md: This file.

- vivado: A folder containing the Vivado source and constraint files for
  implementing the tutorial on the PYNQ-Z1 board.

- ip: A folder containing a custom interface definition for PCPI and the
  picorv32 RISC-V processor IP for Vivado IP Integrator

- ip/picorv32: A Vivado IP block encapuslating the picorv32 RISC-V processor.

- riscv.tcl: A complete tcl for generating the riscv.bit file with a picorv32
  RISC-V processor instantiated, configured, and connected.. The script creates
  a Vivado 2017.1 project titled **riscv** and instantiates a Zynq 7000 PS with
  the correct settings for the PYNQ-Z1 board.

- notebooks: A placeholder for notebooks. This file contains a RISC-V makefile,
  Hex-Converter script, and a Linker script. It should be moved onto your PYNQ
  board as described in the tutorial.

- riscv.bit: A FPGA bit file with the picorv32 RISC-V processor instantiated,
  configured, and connected.


