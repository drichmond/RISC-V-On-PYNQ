  .section ".text.init"
  .globl _start
_start:
	addi    r1, r0, STKPTR
	nop
	lwi    r5, r1, -4
	nop
	lwi    r6, r1, -8
	nop
	brlid   r15, main
	nop
	swi r3, r1, -4
	nop
	ori r12, r0, 1
	nop
	swi r12, r0, iomem
	nop
__end:	
	bri _end
	nop
	
.section ".tdata.begin"
.globl _tdata_begin
_tdata_begin:

.section ".tdata.end"
.globl _tdata_end
_tdata_end:

.section ".tbss.end"
.globl _tbss_end
_tbss_end:

.section ".tohost","aw",@progbits
.align 6
.globl tohost
tohost: .int 0
.align 6
.globl fromhost
fromhost: .int 0
.section ".iomem","w",@nobits
.align 6
.globl iomem
iomem: .int 0
