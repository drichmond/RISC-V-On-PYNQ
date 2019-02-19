  .section ".text.init"
  .globl _start
_start:
	addi    r1, r0, 65536
// Enable ICache
	mfs	r12, rmsr
	nop
	ori	r12, r12, (1<<5)
	mts	rmsr, r12
	nop
// Enable DCache
	mfs	r12, rmsr
	nop
	ori	r12, r12, (1<<7)
	mts	rmsr, r12
	nop
	brlid   r15, main
	nop
_end:	
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
