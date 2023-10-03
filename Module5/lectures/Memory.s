.text
.global main

main:
     #push and pop on the stack
     sub sp, sp, #4
     str lr, [sp, #0]

     ldr r4,=num1 // need num1 address into some register
     ldr r0, [r4, #0] // now the value 25 should be in num1 reg 0

     mov r0, #7 // move 7 into r0 to show values have been changed in register
     str r0, [r4, #0] // shows address of r4 which is num1

     ldr lr, [sp, #0]
     add sp, sp, #4
     mov pc, lr

.data
    num1: .word 25 // 32 bit integer initialized to 25
