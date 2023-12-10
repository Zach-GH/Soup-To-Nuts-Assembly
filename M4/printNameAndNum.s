#
# Program Name: printNameAndNum
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

    # Prompt for a number input
    LDR r0, =prompt_name
    BL  printf
    LDR r0, =prompt
    BL  printf

    # Scanf
    # for name
    LDR r0, =input_name
    LDR r1, = name
    BL scanf
    # for number
    LDR r0, =input
    LDR r1, =num
    BL scanf

    # Printing the message
    LDR r0, =format_name
    LDR r1, =name
    BL printf
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
    prompt: .asciz "Enter your Age \n"
    input: .asciz "%d"
    # Prompt the user for a name
    prompt_name: .asciz "and then Enter your Name:\n"
    # Format user input for name
    input_name: .asciz "%s"
    # Format to print the entered number
    format_name: .asciz "Hello %s you are "
    format: .asciz "%d years old how are you today?\n"
    name: .space 40
