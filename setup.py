# ----------------------------------------------------------------------
# Copyright (c) 2018, The Regents of the University of California All
# rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#
#     * Neither the name of The Regents of the University of California
#       nor the names of its contributors may be used to endorse or
#       promote products derived from this software without specific
#       prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL REGENTS OF THE
# UNIVERSITY OF CALIFORNIA BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.
# ----------------------------------------------------------------------
from setuptools import setup, find_packages

import os

jupyter_dest = '//home/xilinx/jupyter_notebooks'
notebooks_root = 'notebooks'
data_files = []

# Find all of the tutorial notebooks in the tutorials_src path
tutorials_src = os.path.join(notebooks_root, 'tutorial')
tutorials_dest = os.path.join(jupyter_dest, 'RISC-V-Tutorial')
tutorials = [os.path.join(tutorials_src, f)
             for f in os.listdir(tutorials_src)
             if f.endswith(".ipynb")]
data_files.append((tutorials_dest, tutorials))

# Find all of the tutorial notebook pictures in the pictures_src path
pictures_src = os.path.join(tutorials_src, 'pictures')
pictures_dest = os.path.join(tutorials_dest, 'pictures')
pictures = [os.path.join(pictures_src, f)
            for f in os.listdir(pictures_src)
            if f.endswith(".png")]
data_files.append((pictures_dest, pictures))

examples_src = os.path.join(notebooks_root, 'examples')
examples_dest = os.path.join(jupyter_dest, 'RISC-V-Examples')
examples = [os.path.join(examples_src, f)
             for f in os.listdir(examples_src)
             if f.endswith(".ipynb")]
data_files.append((examples_dest, examples))

setup(name='riscvonpynq',
      version='0.1',
      description="A simple package describing how to create a RISC-V FPGA bitstream\
            and package it as a PYNQ overlay",
      author='Dustin Richmond',
      author_email='drichmond@eng.ucsd.edu',
      url='https://github.com/drichmond/RISC-V-On-PYNQ/',
      license='BSD-3',
      data_files = data_files,
      packages=find_packages(),
      package_data={'':['*.bit', '*.tcl', '*.hwh', '*.S', '*.ld', 'makefile']},
      install_requires=['pynq'],
      dependency_links=['http://github.com/xilinx/PYNQ.git@v2.1#egg=pynq'],
)
