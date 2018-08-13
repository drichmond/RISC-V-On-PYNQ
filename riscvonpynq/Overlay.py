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
import os, inspect, pynq
from .magic.Magic import Magic

__author__ = "Dustin Richmond"
__copyright__ = "Copyright 2018, The Regents of the University of California"

class Overlay(pynq.Overlay):
    """The Overlay class wraps the pynq.Overlay class with an updated
    __init__ method. The new __init__ method modifies the PYNQ Overlay
    Search Path to include the folder of the class definition.

    """
    def __get_path(self):
        """Get the directory path of this file, or the directory path of the
        class that inherits from this class.

        """
        # Get file path of the current class (i.e. /opt/python3.6/<...>/stream.py)
        file_path = os.path.abspath(inspect.getfile(inspect.getmodule(self)))
        # Get directory path of the current class (i.e. /opt/python3.6/<...>/stream/)
        return os.path.dirname(file_path)

    def __init__(self, bitfile, **kwargs):
        """Return a new Overlay object, with an amended search path.

        The following lines enable a PYNQ-Like API for Overlays. For
        example, without these lines you cannot call
        streamOverlay('stream.bit') if stream.bit is not in the PYNQ
        package. because stream.bit is not on the bitstream search
        path. 

        This class fixes that by searching the location of subclass
        definition if an absolute path is not provided.

        Parameters
        ----------
        bitfile : str
            The bitstream name or absolute path as a string.
        download : boolean or None
            Whether the overlay should be downloaded. If None then the
            overlay will be downloaded if it isn't already loaded.

        Note
        ----
        This class requires a Vivado '.tcl' file to be next to bitstream file
        with same name (e.g. base.bit and base.tcl).

        """
        if(not os.path.isabs(bitfile)):
            bitfile = os.path.join(self.__get_path(), bitfile)
        super().__init__(bitfile, **kwargs)
                
