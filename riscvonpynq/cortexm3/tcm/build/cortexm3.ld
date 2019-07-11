/*----------------------------------------------------------------------*/
/* Sections                                                             */
/*----------------------------------------------------------------------*/
MEMORY
{
	mem : ORIGIN = 0x00000000, LENGTH = 0x00008000
}

SECTIONS {
	 .text :
	 {
	 . = ALIGN(4);
	 KEEP(*(.interrupt_vector))
	 *(.text)
	 *(.text*)
	 *(.rodata)
	 *(.rodata*)
	 . = ALIGN(4);
	 } > mem
	 .data : 
	 {
	 . = ALIGN(4);
	 _data_begin = .;
	 *(.data)
	 *(.data*)
	 . = ALIGN(4);
	 _data_end = .;
	 } > mem
	 .bss :
	 {
	 _bss_begin = .;
	 __bss_start__ = _bss_begin;
	 *(.bss)
	 *(.bss*)
	 *(COMMON)
	 . = ALIGN(4);
	 _bss_end = .;
	 __bss_end__ = _bss_end;
	 } > mem
	 _stack_size = 1024;
	 _stack_end = ORIGIN(mem)+LENGTH(mem);
	 _stack_begin = _stack_end - _stack_size;
	 . = _stack_begin;
	 ._stack :
	 {
	 . = . + _stack_size;
	 } > mem
}
ENTRY(handler_reset);
