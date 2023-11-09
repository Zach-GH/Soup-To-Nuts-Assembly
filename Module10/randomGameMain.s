#
# Program Name: randomGame.s
# Author: Zachary Meisner
# Date: 10/27/2023
# Purpose: Module 10 Guessing Game
# Functions:
# Inputs: user input for each function
# Outputs:
#

.global main
.text
main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # initialize by prompting user, answer goes into r4
    LDR r0, =prompt
    BL printf

    # Read input
    LDR r0, =input
    LDR r1, =num
    BL scanf

    LDR r1, =num
    LDR r4, [r1, #0]

    StartSentinelLoop:
        MOV r0, #-1
        CMP r4, r0
        BEQ EndSentinelLoop

            # Loop Block
            MOV r0, #0 // clear the user inputi
            #BL caseStatement // take the user input and verify which command to use
            BL userInput

            MOV r4, r0
            MOV r6, r0 // move the max value into r6 for outputting the invalidCase

            BL secondInput

            MOV r1, r4 // move max value into r1

            BL checkNegative
            MOV r1, r0 // move output of checkNegative into r1 for loader output
            MOV r4, r0

            CMP r1, #0
            BLE invalidCase // if the output is not 0 or negative, let the computer guess

            MOV r1, r4
            LDR r0, =output
            BL printf

            B EndIf

            invalidCase:
            MOV r1, #0 // Clear the r1 register
            MOV r1, r6 // Moving the max value into r1 for invalid output
            LDR r0, =invalid
            BL printf

            B EndIf

            EndIf:

            # Get next value
            LDR r0, =prompt
            BL printf
            LDR r0, =input
            LDR r1, =num
            BL scanf
            LDR r1, =num
            LDR r4, [r1, #0]

            B StartSentinelLoop

    EndSentinelLoop:

        # Return to the OS
        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.data
    # Prompt the user for initial user input/option
    prompt:  .asciz "\nEnter any number to continue, -1 to quit: "
    # Stores user input
    input:   .asciz "%d"
    # Storage for the user input
    num:     .word 0
    # output
    output:  .asciz "\nYour output is %d\n"
    # invalid
    invalid: .asciz "\nInvalid user input, please enter a number above 0 and below the max value %d\n"


.text
# function userInput
userInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    MOV  r4, r0
    MOV r2, #3

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
    # store user Input
    inputNum: .word 0
    # prompt user for input
    prompt1: .asciz "\nEnter Max Value that the computer can guess against: "
    # intake user input
    inputFormat: .asciz "%d"

.text
# function secondInput
secondInput:
    SUB sp, sp, #12
    STR lr, [sp, #4]
    STR r4, [sp, #8]

    MOV r4, r0

    LDR r0, =prompt2
    BL printf

    LDR r0, =inputFormat2
    LDR r1, =inputNum2
    BL scanf
    LDR r1, =inputNum2
    LDR r0, [r1, #0]

    LDR r4, [sp, #8]
    LDR lr, [sp, #4]
    ADD sp, sp, #12
    MOV pc, lr
.data
    # store user input
    inputNum2: .word 0
    # prompt for computer guess input
    prompt2: .asciz "\nEnter your input for the computer to guess: "
    # intake user input
    inputFormat2: .asciz "%d"

