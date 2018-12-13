from riscvonpynq.Overlay import Overlay
from riscvonpynq.Processor import LmbProcessor
import os
import inspect

class Overlay(Overlay):
    """Overlay driver for the Orca bram Overlay

    Note
    ----
    This class definition must be co-located with the .tcl and .bit
    file for the overlay for the search path modifications in
    riscvonpynq.Overlay to work. __init__ in riscvonpynq.Overlay uses
    the path of this file to search for the .bit file using the
    inspect package.

    """
    pass

class Processor(LmbProcessor):
    """Hierarchy driver for the Orca LMB Processor

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
    (Processor Type Name, must match name of the linker script file
    (.ld) in the build directory)

    This class must be placed in a known location relative to the
    build files for this processor. The relative path can be modified
    in __get_path.

    """
    _name = 'orcaLmbProcessor'
    _proc = 'orca'
    _bits = 32
    @classmethod
    def checkhierarchy(cls, description):
        return super().checkhierarchy(description)
    def __get_path(self):
        """
        Get the directory path of this file, or the directory path of the
        class that inherits from this class.

        """
        # Get file path of the current class (i.e. /opt/python3.6/<...>/stream.py)
        file_path = os.path.abspath(inspect.getfile(inspect.getmodule(self)))
        # Get directory path of the current class (i.e. /opt/python3.6/<...>/stream/)
        return os.path.dirname(file_path)

    def __init__(self, description, *args):
        """Return a new Processor object.

        Parameters
        ----------
        description : dict
            Dictionary describing this processor.

        """
        build_path = os.path.join(self.__get_path(), "build")
        reset_value = 0
        super().__init__(build_path, reset_value, description, *args)
