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

    # initialize by prompting user
    LDR r0, =prompt
    BL printf

    # Read input
    LDR r0, =input
    LDR r1, =num
    BL scanf

    LDR r1, =num
    LDR r0, [r1, #0]

    StartSentinelLoop:
        CMP r0, #-1
        BEQ EndSentinelLoop

            BL userInput
            # Move the max value into r6
            MOV r6, r0

            # We have a max val, let us also assign a lowest val
            MOV r4, #1

            BL secondInput
            MOV r5, r0

            SUB r0, r6, r0

            CMP r0, #1
            BLT invalidCase

            CMP r0, r6
            BGT invalidCase

            StartLoop:
                CMP r0, #1
                BEQ EndLoop

                    #MOV r0, r10
                    BL checkRandom

                    B StartLoop

            EndLoop:
                LDR r0, =win
                BL printf

            # Get next value
            LDR r0, =prompt
            BL printf
            LDR r0, =input
            LDR r1, =num
            BL scanf
            LDR r1, =num
            LDR r0, [r1, #0]

            B StartSentinelLoop

    invalidCase:
    MOV r1, r6
    LDR r0, =invalid
    BL printf
    B EndIf

    EndIf:
    EndSentinelLoop:

        # Return to the OS
        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.data
    # Prompt the user for initial user input/option
    prompt:  .asciz "\nEnter any number to play, -1 to quit: "
    # Stores user input
    input:   .asciz "%d"
    # Storage for the user input
    num:     .word 0
    # invalid
    invalid: .asciz "\nInvalid user input, please enter a number above 0 and below the max value %d\n"
    win: .asciz "\nYou Win!\n"
    debug: .asciz "\nDEBUG Value: %d\n"
    debug2: .asciz "\nDEBUG2 Value: %d\n"


.text
# function userInput
userInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]

    LDR r0, =prompt1
    BL printf

    LDR r0, =inputFormat
    LDR r1, =inputNum
    BL scanf
    LDR r1, =inputNum
    LDR r0, [r1, #0]

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

    LDR r0, =prompt2
    BL printf

    LDR r0, =inputFormat2
    LDR r1, =inputNum2
    BL scanf
    LDR r1, =inputNum2
    LDR r0, [r1, #0]

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
.global guessingGame
# guessingGame function
guessingGame:
    SUB sp, sp, #16
    STR lr, [sp, #12]
    # Store r10 to preserve its value
    #STR r10, [sp, #4]

    CMP r0, #2
    MOVGE r1, #1
    CMP r0, #3
    MOVLE r2, #1

    AND r1, r1, r2
    CMP r1, #1
    BEQ case_3

    # Invalid Input
    LDR r0, =badInput
    BL printf
    B EndIf2

    # if input is 3
    case_3:
    CMP r0, #3
    BLT case_2

    # case 3 output (the number is higher)
    # Since the number is higher
    # and we want to do a binary search
    # we add 2 to the low value
    ADD r4, r4, #2
    MOV r1, r4
    LDR r0, =lower
    BL printf

    BL checkRandom
    # End of case 3
    B EndIf2

    # if input is 2
    case_2:
    # case 2 output (the number is lower)
    # Since the number is lower
    # and we want to do a binary search
    # we subtract 2 from the high value
    SUB r6, r6, #2
    MOV r1, r6
    LDR r0, =higher
    BL printf

    #MOV r0, r10
    BL checkRandom
    B EndIf2

    EndIf2:

    LDR lr, [sp, #12]
    ADD sp, sp, #16
    MOV pc, lr
.data
    badInput: .asciz "input must be 1 to 3\n"
    computerGuess2: .asciz "\nIs your number %d?\n"
    lower: .asciz "\nLower Number Threshold: %d\n"
    higher: .asciz "\nHigher Number Threshold: %d\n"


.text
.global checkRandom
checkRandom:
SUB sp, sp, #20
STR lr, [sp, #16]

MOV r0, r6
BL randFunc
MOV r10, r0

MOV r1, r0
LDR r0, =compGuess
BL printf

CMP r10, r4
MOVGE r1, #1

CMP r10, r6
MOVLE r2, #1

AND r1, r1, r2
CMP r1, #1
BEQ randomPassed
BNE newRandomNumber

randomPassed:
    MOV r1, r10
    LDR r0, =computerGuess
    BL printf

    LDR r0, =checkUserGuess
    BL printf

    LDR r0, =checkUserInputInput
    LDR r1, =guessFeedback
    BL scanf
    LDR r1, =guessFeedback
    LDR r0, [r1, #0]
    CMP r0, #1
    BEQ returnToMainLoop

    BL guessingGame

    B returnToMain

B EndRandom

newRandomNumber:
    BL checkRandom
B EndRandom

returnToMainLoop:

returnToMain:

EndRandom:

LDR lr, [sp, #16]
ADD sp, sp, #20
MOV pc, lr

.data
computerGuess: .asciz "\nIs your number %d?"
checkUserGuess: .asciz "\nEnter the corresponding number for your answer\n
                           Is the number:\n
                           Higher?:     3\n
                           Lower?:      2\n
                           Correct!:    1\n"
checkUserInputInput: .asciz "%d"
guessFeedback: .word 0
compGuess: .asciz "\nComputer Guess: %d\n"
NotPassed: .asciz "\nNot Passed\n"
