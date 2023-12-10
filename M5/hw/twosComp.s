.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp]

    # Prompt for an input
    LDR r0, =prompt
    BL printf

    # Scanf
    LDR r0, =input
    LDR r1, =num
    BL scanf

    # Printing the message
    LDR r0, =format
    LDR r1, =num
    LDR r1, [r1, #0]
    MVN r1, r1  // one's complement
    ADD r1, r1, #1 // adding one for twos complement
    BL printf

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
    # Allocates space for a word-aligned 4-byte value in the memory
    num: .word 0
    # Prompt the user to enter a number
    prompt: .asciz "Enter a Number\n"
    # Format of the user input
    input: .asciz "%d"
    # Format to print entered number
    format: .asciz "Two's complement says your number is %d \n"
