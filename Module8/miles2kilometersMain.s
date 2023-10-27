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
    LDR r0, [r1, #0]
    MOV r4, #10
    MUL r0, r0, r4 // we have to multiply by 10 for the float value to scale correctly

    BL miles2kilometers   // convert miles to kilometers
    MOV r4, r0 // move the value so we can assign the output properly

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
    prompt:  .asciz "Enter total miles: "
    output:  .asciz "\nThe length in kilometers is "
    input:   .asciz "%d"
    newline: .asciz "\n"
    num:     .word 0
