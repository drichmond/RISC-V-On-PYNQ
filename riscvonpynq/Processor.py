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
import pynq, os, enum, numpy as np, time
from pynq import Xlnk

__author__ = "Dustin Richmond"
__copyright__ = "Copyright 2018, The Regents of the University of California"

class Processor(pynq.DefaultHierarchy):
    """Parent Hierarchy driver for RISC-V Processors

    Facilitates loading user programs on to RISC-V Processors.

    Note
    ----
    In order to be recognized as a RISC-V Processor hierarchy, three
    conditions must be met: First, there must be a PS-Memory-Mapped
    Block RAM Controller where the name matches the variable
    _bram. Second, the hierarchy name (fullpath) must equal the
    variable _name. Finally, there must be a GPIO port with the name
    _reset_name.

    Subclasses of this module are responsible for setting _name (The
    name of the Hierarchy), _bits (Processor bit-width), _proc
    (Processor Type Name)

    """
    _reset_name = 'riscv_resetn'
    _bram = 'psBramController'
    _name = None
    _bits = None
    _proc = None

    @classmethod
    def checkhierarchy(cls, description):
        return ((cls._bram in description['ip'].keys()) and
                (cls._name == description['fullpath']) and
                (cls._reset_name in description['gpio']))

    def __init__(self, build_path, reset_value, description, *args):
        """Return a new Processor object. 

        Parameters
        ----------
        build_path : str
            Path to the RISC-V build files for this processor

        reset_value : int
            Value to be written (0 or 1) to the GPIO pin to reset the
            RISC-V procesor.

        description : dict
            Dictionary describing this processor.

        """
        super().__init__(description, *args)

        if(reset_value not in {1, 0}):
            raise ValueError(f'reset_value must be 0 or 1, not {reset_value}')

        self.__reset_value = reset_value
        self.__nreset_value = int(not(reset_value))

        self.__resetPin = self.__getattr__(self._reset_name)
        self.__reset_s = None
        self._reset()

        self._mem = self.__getattr__(self._bram)
        self._stkidx = self._mem.mmio.length
        self._memstr = description['ip'][self._bram]['fullpath']
        self.__clear_argptrs()

        self.__loaded = False
        self.__build_path = build_path

    @property
    def name(self):
        """ Return the name of the RISC-V Processor Hierarchy"""
        return self._name

    @property
    def stkptr(self):
        """ Return the memory size in Bytes of the desired stack pointer"""
        return self._stkidx

    @property
    def build_path(self):
        """ Return the path to the build directory for this RISC-V Processor"""
        return self.__build_path

    @property
    def proc(self):
        """Return the name of the RISC-V Processor IP RISC-V Processor
        Hierarchy"""
        return self._proc

    @property
    def bits(self):
        """Return the bit width of the RISC-V Processor IP"""
        return self._bits

    def _reset(self):
        """Put the RISC-V Processor into the reset state"""
        self.__reset_s = self.__reset_value
        self.__resetPin.write(self.__reset_value)

    def _nreset(self):
        """Remove the RISC-V Processor from the reset state

        Note
        ----
        This method will raise a RuntimeError if the processor is not
        in the reset state; this means the processor is not in the
        reset state or its state is undefined.

        """

        if(self.__reset_s != self.__reset_value):
            raise RuntimeError("Processor not in reset state!")
        else:
            self.__reset_s = self.__nreset_value
            self.__resetPin.write(self.__nreset_value)

    def _validate(self, *args):
        """Validate that all arguments are numpy types. 

        Note
        ----
        This method will raise a TypeError if an argument is not an
        instance of np.ndarray, or np.generic.

        """
        for a in args:
            if(not isinstance(a, (np.ndarray, np.generic))):
                raise TypeError(f'Argument {type(a)} not a numpy type')

    def __clear_argptrs(self):
        """Reset all of the pointers used to pass arguments to a RISC-V
        Processor

        Note
        ----

        argv_buf : np.ndarray
            A buffer for a list of pointers to arguments that is used
            for argv in the call to the main method

        argv_ptr : int
            Physical address of the argv buffer in the RISC-V memory
            space.

        arg_bufs : list
            List of np.ndarrays with argument data

        arg_ptrs : list
            List of pointers to each buffer in arg_bufs from the
            perspective of the RISC-V Processor memory space.

        """
        self.__argv_buf = None
        self.__argv_ptr = None
        self.__arg_bufs = None
        self.__arg_ptrs = None

    def run(self, prog, *args):
        """Run a given program on the RISC-V Processor, and block until the
        program terminates.

        Parameters
        ----------
        prog : riscvonpynq.Program
            A Program class from the riscvonpynq library that wraps a
            user program

        args : tuple
            Arguments to pass to the main method of the program

        """
        self.launch(prog, *args)
        self.irq.wait()
        return self.land()

    def launch(self, prog, *args):
        """Launch a given program on the RISC-V Processor, and return while
        the program executes.

        Parameters
        ----------
        prog : riscvonpynq.Program
            A Program class from the riscvonpynq library that wraps a
            user program

        args : tuple
            Arguments to pass to the main method of the program

        """
        path = prog.build(self)
        self._load(path, *args)
        self._nreset()

    def _load(self, bin_path, *args):
        """Load a program into the memory space of the RISC-V Processor and
        load its arguments

        Parameters
        ----------
        bin_path : str
            Path of the binary file to be loaded

        args : tuple
            Arguments to pass to the main method of the program

        """
        if(self.__loaded):
            raise RuntimeError('Processor already loaded!')

        pynq.PL.load_ip_data(self._memstr,  bin_path)

        binname = np.fromstring(bin_path + '\0', np.int8)
        self.__args = (binname, *args)
        bs = self._alloc_args(self.__args)

        self.__argv_buf = bs[0]
        self.__argv_ptr = bs[1]
        self.__arg_bufs = bs[2]
        self.__arg_ptrs = bs[3]

        argc = len(self.__arg_bufs)
        argv = self.__argv_ptr
        self._mem.write(self._stkidx - 4, argc)
        try:
            self._mem.write(self._stkidx - 8, argv)
        except ValueError:
            self._mem.write(self._stkidx - 8, int(argv))
        self.__loaded = True

    def land(self):
        """Terminate execution on a RISC-V Processor, unload the program and
        arguments, and return the program's return value (if it terminated). 
        
        Note
        ----
        Any modified data in the program argument buffers will be
        copied back to the original buffer (if applicable) by _unload()

        """        
        self._reset()
        self._unload()            
        return self._retval
        
    def _unload(self):
        """Unload a program from a RISC-V Processor: Copy any modified
        argument data back to the processor memory space and
        deallocate any buffers. 

        """        
        if(not self.__loaded):
            raise RuntimeError('Processor not loaded!')
        self._copyout_args(self.__arg_bufs, self.__args)
        self._dealloc_args(self.__arg_bufs, self.__args, self.__argv_buf)
        self.__clear_argptrs()
        self.__loaded = False

    def _copyout_args(self, arg_bufs, args):
        """Copy argument data back to the processor memory space 

        """        
        self._validate(*args)        
        for (dest, src) in zip(args, arg_bufs):
            if isinstance(dest, pynq.xlnk.ContiguousArray):
                pass
            elif(isinstance(dest, np.ndarray)):
                np.copyto(dest, src)
            else:
                dest = src

    @property
    def _retval(self):
        """Get the return value of a program from the RISC-V Processor's
        stack.

        """        
        return np.int32(np.uint32(self._mem.read(self._stkidx - 4)))

class MixedProcessor(Processor):
    """Subclass Hierarchy driver for RISC-V Processors with mixed DDR/BRAM
    memory spaces

    Facilitates loading user programs on to RISC-V Processors.

    """
    def __init__(self, build_path, reset_value, description, *args):
        """Return a new MixedProcessor object. 

        Parameters
        ----------
        build_path : str
            Path to the RISC-V build files for this processor

        reset_value : int
            Value to be written (0 or 1) to the GPIO pin to reset the
            RISC-V procesor.

        description : dict
            Dictionary describing this processor.

        """
        super().__init__(build_path, reset_value, description, *args)
        self.__xlnk = Xlnk()        

    def _dealloc_args(self, arg_bufs, args, argv_buf):
        """Dealloc any CMA Arrays allocated by this class, but do not
        deallocate CMA Arrays allocated by the user

        Parameters
        ----------
        arg_bufs : list
            List of np.ndarrays with argument data in the RISC-V
            Processor memory space

        args : tuple
            Tuple of np.ndarrays with argument data in the PS memory
            space.

        argv_buf : pynq.xlnk.ContiguousArray
            Buffer containing pointers to each buffer in arg_bufs

        Note
        ----
        If a buffer in args is an instance of
        pynq.xlnk.ContiguousArray this means it was allocated by the
        user and will not be deallocated

        """
        self._validate(*args)
        [ None if isinstance(a, pynq.xlnk.ContiguousArray)
          else cma.freebuffer()
          for (cma, a) in zip(arg_bufs, args) ]
        argv_buf.freebuffer()

    def _alloc_args(self, args):
        """Allocate CMA Arrays to hold any user-provided arguments.

        Parameters
        ----------
        args : tuple
            Tuple of np.ndarrays with argument data in the PS memory
            space.

        Note
        ----
        If a buffer in args is an instance of
        pynq.xlnk.ContiguousArray this means it was allocated by the
        user and will not be allocated/copied

        """        
        self._validate(*args)
        arg_bufs = [a if isinstance(a, pynq.xlnk.ContiguousArray)
                     else (self.__xlnk.cma_array(1, a.dtype) if isinstance(a, np.generic)
                           else self.__xlnk.cma_array(a.shape, a.dtype))
                     for a in args]
        [None if isinstance(src, pynq.xlnk.ContiguousArray)
         else np.copyto(dest, src) 
         for (dest, src) in zip(arg_bufs, args)]
        argv_buf = self.__xlnk.cma_array(len(args), np.uint32)
        argv_ptr = self.__xlnk.cma_get_phy_addr(argv_buf.pointer)
        arg_ptrs = [self.__xlnk.cma_get_phy_addr(pya.pointer) for pya in arg_bufs]
        argv_buf[:] = arg_ptrs
        return (argv_buf, argv_ptr, arg_bufs, arg_ptrs)

class BramProcessor(Processor):
    """Subclass Hierarchy driver for RISC-V Processors with mixed DDR/BRAM
    memory spaces

    Facilitates loading user programs on to RISC-V Processors.

    """
    def __init__(self, build_path, reset_value, description, *args):
        """Return a new BramProcessor object. 

        Parameters
        ----------
        build_path : str
            Path to the RISC-V build files for this processor

        reset_value : int
            Value to be written (0 or 1) to the GPIO pin to reset the
            RISC-V procesor.

        description : dict
            Dictionary describing this processor.

        Note
        ----
        Since the Processor isn't connected to DDR we divide the BRAM 
        memory in half, and use the "Upper" half for arguments 
        (see __argptr and _stkidx)

        """
        super().__init__(build_path, reset_value, description, *args)
        self._stkidx = np.uint32(self._mem.mmio.length / 2 )
        self.__argptr = np.uint32(self._mem.mmio.array.nbytes / 2)

    def _dealloc_args(self, *args):
        """Dealloc any Arrays allocated by this class

        Note
        ----
        Since the BRAM is contiguous, and allocation is tracked by
        __argptr, we simply reset __argptr

        """
        self.__argptr = np.uint32(self._mem.mmio.array.nbytes / 2)

    def _alloc_buf(self, c, ty):
        """Allocate a buffer in the RISC-V Processor memory space

        Parameters
        ----------
        c : int
            Number of elements (or count) to allocate in buffer

        ty : type
            Underlying type to allocate for the buffer.

        """
        mem = self._mem.mmio.array
        ptr = np.uint32(self.__argptr)
        buf = np.frombuffer(mem, count = c, dtype=ty, offset = ptr)
        l = np.uint32((buf.itemsize * c + mem.itemsize - 1) / mem.itemsize)*mem.itemsize
        self.__argptr += np.uint32(l)
        return (ptr, buf)

    def _alloc_args(self, args):
        """Allocate space in the BRAMN to hold any user-provided arguments.

        Parameters
        ----------
        args : tuple
            Tuple of np.ndarrays with argument data in the PS memory
            space.

        """        
        self._validate(*args)
        arg_ptrs, arg_bufs = zip(*[ self._alloc_buf(arg.size, arg.dtype) 
                                    for arg in args ])
        argv_ptr, argv_buf = self._alloc_buf(len(args), np.uint32)
        [ np.copyto(dest, src) for (dest, src) in zip(arg_bufs, args) ]
        argv_buf[:] = arg_ptrs
        return (argv_buf, argv_ptr, arg_bufs, arg_ptrs)

class LmbProcessor(BramProcessor):
    """Subclass Hierarchy driver for RISC-V Processors with mixed BRAM
    memory spaces

    Facilitates loading user programs on to RISC-V Processors.

    """
    pass
