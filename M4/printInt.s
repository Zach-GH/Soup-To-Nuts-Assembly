#
# Program Name: printInt
# Author: Zachary Meisner
# Date: 9/25/2023
# Purpose: uses scanf for an integer using data memory
# Input:
#   - input: User entered number
# Output:
#   - format: Prints the number
#

.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt for an input
    LDR r0, =prompt
    BL  printf

    # Scanf
    LDR r0, =input
    LDR r1, =num
    BL scanf

    # Printing the message
    LDR r0, =format
    LDR r1, =num
    LDR r1, [r1, #0]
    BL printf

    # Return the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Allocates space for a word-aligned 4-byte value in the memory
    num: .word 0
    # Prompt the user to enter a number
    prompt: .asciz "Enter A Number\n"
    # Format of the user input, %d means integer number
    input: .asciz "%d"
    # Format to print the entered number
    format: .asciz "Your number is %d \n"
