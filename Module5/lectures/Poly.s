.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp]

    LDR r0, =prompt
    BL printf
    LDR r0, =formatString
    LDR r1, =Y
    BL scanf

    // load in the address of the Y variable
    LDR r0, =Y
    LDR r0, [r0] // put the value of Y into r0
    MOV r1, #9 // move the value of 9 into r1
    MUL r0, r0, r1 // multiply by 9
    MOV r1, #5 // move the value 5 into r1
    BL __aeabi_idiv // the value is now in r0
    MOV r1, #7 // move value 7 into r0
    ADD r0, r0, r1 // add the values together and store them in r0

    MOV r1, r0
    LDR r0, =output
    BL printf

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
    output: .asciz "\nThe value of X is: %d\n"
    prompt: .asciz "Enter the value for Y:  "
    Y: .word 0 // starting value is 0
    formatString: .asciz "%d"
