.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt for input in feet
    LDR r0, =prompt
    BL printf

    # Read feet
    LDR r0, =input
    LDR r1, =num
    BL scanf

    LDR r1, =num
    LDR r1, [r1, #0]
    MOV r4, #10
    MUL r4, r1, r4 // we have to multiply by 10 for the float value to scale correctly

    BL secondInput // go get the second input
    BL inches2Ft   // convert the second input to feet
    ADD r4, r0, r4 // add inches and feet together

    # Printing The Message
    LDR r0, =output
    BL printf

    MOV r0, r4
    MOV r1, #10
    BL printScaledInt
    LDR r0, =newline
    BL printf

    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt:  .asciz "Enter total length of feet: "
    output:  .asciz "\nThe length in feet is "
    input:   .asciz "%d"
    newline: .asciz "\n"
    num:     .word 0

.text
# function secondInput
secondInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    MOV r4, r0

    LDR r0, =prompt1
    BL printf

    LDR r0, =inputFormat
    LDR r1, =inputNum
    BL scanf
    LDR r1, =inputNum
    LDR r0, [r1, #0]

    LDR r4, [sp, #4]
    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr
.data
    inputNum: .word 0
    prompt1: .asciz "Enter inches: "
    inputFormat: .asciz "%d"
