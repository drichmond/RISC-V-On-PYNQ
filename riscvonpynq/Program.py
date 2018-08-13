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
import os, enum, tempfile, time, shutil
from subprocess import run, PIPE

class Lang(enum.Enum):
    """An Enum for tracking supported programming languages"""

    C = 1
    CPP = 2
    ASM = 3

class Program:
    """Representation of a RISC-V program. 

    Attributes
    ----------
    name: str
        Name of this program, used to derive the bin name, and source
        file name.

    """

    def __init__(self, path, name, lang):
        """Return a new Program object

        Parameters
        ----------
        path: str
            Path to the directory containing the body of the program

        name: str
            Filename of the program to be compiled (sans extension)

        lang: Lang
            Enum representing the source language
        """

        if not os.path.isdir(path):
            raise IOError(f"File {path} not found!")
        self.__path = path
        if lang == Lang.C:
            src_name = f'{name}.c'
        elif lang == Lang.ASM:
            src_name = f'{name}.S'
        elif lang == Lang.CPP:
            src_name = f'{name}.cpp'
        else:
            raise RuntimeError(f'Must specify language: {[l for l in Lang]}')
        src_file = os.path.join(path, src_name)
        if(not os.path.isfile(src_file)):
            raise RuntimeError(f'File {src_file} could not be found')
        self.__bin_name = f'{name}.bin'
        self.__src_name = src_name
        self.__name = name

        self.__compiled = False

    @property
    def name(self):
        return self.__name

    def __compile_bin(self, proc):
        """Create a compile bin file with the RISC-V program
        
        Parameters
        ----------
        path: str
            Path to the directory

        Note
        ----
        If you want to sneak in extra INCLUDE or CFLAGS directives to
        the makefile, this is the place to do it. Just define them as
        STKPTR is defined below.

        """
        bin_path = os.path.join(self.__path, self.__bin_name)
        make_args = ['make', "-C", proc.build_path, bin_path,
                     f'STKPTR={proc.stkptr}']
        result = run(make_args, stdout=PIPE, stderr=PIPE)
        if result.returncode:
            raise RuntimeError(result.stderr.decode())
            
    def build(self, proc):
        """Compile this Program into a bin file.

        Parameters
        ----------
        proc: riscvonpynq.Processor
           A processor object to compile this program for

        Returns
        -------
        path : str
            Path of the compiled binary
        
        """
        self.__compile_bin(proc)
        self.__compiled = True
        return os.path.join(self.__path, self.__bin_name)
