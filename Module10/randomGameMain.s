#
# Program Name: randomGameMain.s
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

            MOV r0, r6 // move max value into r1 for beanstalk generating cap (seems to work well)

            BL magicBeanStalk
            # Output the computers guess
            MOV r10, r0
            MOV r1, r0
            LDR r0, =computerGuess
            BL printf

            BL checkUserGuess

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
    prompt:  .asciz "\nEnter any number to play the game, -1 to quit: "
    # Stores user input
    input:   .asciz "%d"
    # Storage for the user input
    num:     .word 0
    # output
    computerGuess:  .asciz "\nIs your number %d?\n"
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

.text
.global userCase
# userCase function
userCase:
    SUB sp, sp, #16
    STR lr, [sp, #12]
    STR r4, [sp, #8]
    STR r10, [sp, #4] // Store r5 to preserve its value

    MOV r6, #0
    MOV r7, #0

    MOV r5, r10

    MOV r8, #0
    CMP r0, #0
    MOVGE r1, #1

    MOV r10, #0
    CMP r0, #3
    MOVLE r2, #1

    AND r1, r1, r2
    MOV r2, #1
    CMP r1, r2
    BEQ case_3

    # Invalid Input
    LDR r0, =badInput
    BL printf
    MOV r0, #0
    B EndIf2

    # if input is 3
    case_3:
    CMP r0, #3
    BLT case_2

    MOV r0, r5
    BL magicBeanStalk
    MOV r5, r0
    ADD r7, r7, #1
    ADD r1, r7, r0

    LDR r0, =computerGuess2
    BL printf
    # case 3 output (the number is higher)
    BL checkUserGuess
    B EndIf2

    case_2:
    CMP r0, #2
    BLT case_1

    MOV r0, r5
    BL magicBeanStalk
    MOV r5, r0
    ADD r6, r6, #1
    SUB r1, r6, r0

    LDR r0, =computerGuess2
    BL printf
    # case 2 output (the number is lower)
    BL checkUserGuess
    B EndIf2

    case_1:
    # case 1 output (the number is right!)
    LDR r0, =win
    BL printf

    B EndIf2

    EndIf2:

    LDR r4, [sp, #8]
    LDR lr, [sp, #12]
    ADD sp, sp, #16
    MOV pc, lr
.data
    badInput: .asciz "input must be 1 to 3\n"
    computerGuess2: .asciz "\nIs your number %d?\n"
    win: .asciz "\nWinner Winner Chicken Dinner!\n"
