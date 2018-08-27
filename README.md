# RISC-V-On-PYNQ

This repository demonstrates a library for evaluating RISC-V Projects
from the paper "Everyone's a Critic: A Tool for Evaluating RISC-V
Projects".

This repository is a python package for the PYNQ 2.1+ distribution on
the PYNQ-Z1 board. You can install this package by running the following command: 

``` bash

sudo -H pip3.6 install https://github.com/drichmond/RISC-V-On-PYNQ/

```

This will install:

- The `riscvonpynq` Python package.

- A RISC-V-Tutorial folder with notebooks describing how to add new
  processor overlays

- A RISC-V-Demo folder with notebooks demonstrating how to interact
  with existing processor overlays

## `riscvonpynq` Package

The `riscvonpynq` package contains:

- An Overlay Driver (a subclass of `pynq.Overlay`). It extends the
  Overlay functionality by adding the location of an Overlay class to
  the bitstream search path.

- Jupyter Notebook Magics. This allows Jupyter Notebook Cells to
  compile C/C++ and Assembly programs for for RISC-V Processor
  Overlays. Users write `main` and can pass arguments as Numpy types.

- A RISC-V Program Class. This class allows programs to be manipulated
  and compiled from Python using pre-existing build files for a processor.

- Processor drivers (a subclass of `pynq.DefaultHierarchy`). These
  drivers allow users to upload binaries, run programs, and read
  RISC-V Processor Memory. 

There are two RISC-V Processor Drivers: One driver for RISC-V
Processors with BRAM-only Memory, and one driver for RISC-V Processors
with BRAM and DDR Mixed Memory.

More examples and demonstrations are available in the notebooks
installed by this package.

## RISC-V-Tutorial Notebooks

The RISC-V Tutorial Notebooks are a set of notebooks describing how to
set up the RISC-V Toolchain, and then build RISC-V processor
overlays. There are five notebooks:

1. [Downloading Dependencies](notebooks/tutorial/1-Downloading-And-Configuring.ipynb)
2. [Creating a FPGA Bitstream](notebooks/tutorial/2-Creating-A-Bitstream.ipynb)
3. [Compiling the RISC-V GCC Toolchain](notebooks/tutorial/3-Compiling-RISC-V-GCC-Toolchain.ipynb)
4. [Packaging a RISC-V Overlay](notebooks/tutorial/4-Packaging-An-Overlay.ipynb)

Completing these notebooks require:

1. A PYNQ-Z1 with a 16 GB MicroSD Card
2. A Host (Windows or Linux) with Vivado 2017.4
3. An Internet Connection on both computers

## RISC-V-Demo Notebooks

The RISC-V Demonstration notebooks show examples of existing processor
overlays. We provide two example overlays using processors from one
RISC-V Processor Projects.

- RISC-V [PicoRV32](https://github.com/cliffordwolf/picorv32) AXI Demo
- RISC-V [PicoRV32](https://github.com/cliffordwolf/picorv32) BRAM Demo

Each notebook demonstrates how to upload programs using the Jupyter
Notebook Magics we have provided. Each processor has a set of build
files (a makefile, init.S file for initialization, and a .ld linker
script) and we briefly describe these in each notebook.

We have internally tested other processors and will be adding them as
we clean up the code. 

**We welcome pull requests!**



