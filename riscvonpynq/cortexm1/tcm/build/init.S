    .syntax     divided

    .section    .stack
    .align      3
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
    .extern main
//    ldr r0, =0x10
//    ldr r1, =0xdeadbeef
//    str r1, [r0]
    ldr     r0, =main
    bx     r0
