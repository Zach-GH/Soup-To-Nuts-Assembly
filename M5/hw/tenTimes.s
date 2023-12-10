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
    //LDR r0, =format
    LDR r1, =num
    LDR r1, [r1, #0]
    LSL r4, r1, #3 // shifting by 3 bits which multiplies number by 8
    LSL r1, r1, #2 // taking inputted value and multiplying it by 4 (or two squared)
    MOV r0, r1 // moving multiplied value of r1 into r0 for division
    MOV r1, #2 // setting up variable r1 for division by 2
    BL __aeabi_idiv // division operation which should output answer into r0
    // we divide to get half of the output from 2 squared, or just division by 2
    ADD r1, r0, r4 // adding r0 and r4 for the final output

    LDR r0, =format // this has to be done after our use of r0
    // this is because if we load r0 with format we get a segmentation fault
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
    format: .asciz "Your number multiplied is %d \n"
