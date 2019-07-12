    .syntax     divided
    .thumb
    .section    .stack
    #ifdef __STACK_SIZE
        .equ        Stack_Size, (__STACK_SIZE >> 1)
    #else
        .equ        Stack_Size, 0x00000400
    #endif
    .globl      __StackTop
    .globl      __StackLimit
    __StackLimit:
      .space      Stack_Size
      .size       __StackLimit, . - __StackLimit
    __StackTop:
      .size       __StackTop, . - __StackTop

    .text
    .align      2
    .globl      Reset_Handler
    .type       Reset_Handler, %function


Reset_Handler:
	//.extern main
	mov    r0, #0
	mov    r1, #0
	mov    r2, #20
	str    r0, [r2]
	mov    r2, #0
	mov    r3, #0
	mov    r4, #0
	mov    r5, #0
	mov    r6, #0
	mov    r7, #0
	//bl     main
