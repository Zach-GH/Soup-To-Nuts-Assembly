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

    # Clear the screen
    BL clearScreen

    # initialize by prompting user
    LDR r0, =prompt
    BL printf

    # Read input
    LDR r0, =input
    LDR r1, =num
    BL scanf

    LDR r1, =num
    LDR r0, [r1, #0]

    CMP r0, #-1
    MOVGE r1, #1
    CMP r0, #2
    MOVLE r2, #1

    AND r1, r1, r2
    CMP r1, #1
    BEQ StartGameLoop
    CMP r1, #1
    BNE badCaseInput

    # if input is validated
    StartGameLoop:
        # if the input is less than 2 guess the number from the computer
        CMP r0, #2
        BLT guessNumberFromComputer
            # if the number IS 2, you fall into this case and play against the computer
            playAgainstTheComputer:
                # initialize the loop counter
                # if we do not have a loop counter
                # the game will fall into an infinite loop
                # where the program cannot output any generated numbers
                # that pass the input verification between the high and low thresholds set
                MOV r8, #0
                # Get the initial input (max value)
                BL userMaxValInput
                # Move the max value into r6
                MOV r6, r0
                # We have a max val, let us also assign a lowest val
                MOV r4, #1
                # Get the second input (users number for the computer to guess)
                BL secondInput
                # Move this into r5 for safekeeping
                MOV r5, r0
                # Assess that the number is not higher or lower than the max value
                # we do this by subtracting the user guess by the max value
                # and then we check for negative
                SUB r0, r6, r0
                CMP r0, #1
                BLT invalidCase

                StartLoop:
                    CMP r0, #2
                    BLT checkGameLost

                    # Re-Verify the number to assure it equals 2
                    CMP r0, #2
                    BEQ youWin

                    BL checkRandom
                    B StartLoop

                    checkGameLost:
                    CMP r0, #1
                    BEQ youLose

                    BL checkRandom
                    # If the number does not come back as 1 or 2
                    # the game is still going
                    # and when we continue on with the loop
                    # it is business as usual
                    B StartLoop

                youWin:
                    MOV r8, #0
                    LDR r0, =win2
                    BL printf
                    B ContinueGameLoop
                    #B EndGameLoop

                youLose:
                    MOV r8, #0
                    LDR r0, =lose
                    BL printf
                    B ContinueGameLoop
                    #B EndGameLoop

            guessNumberFromComputer:
            # if the number is less than 1
            # End the loop otherwise
            # guess the number from the computer
            # this uses the similar logic as above
            CMP r0, #1
            BLT EndGameLoop

            BL userMaxValInput
            # move max val into r6
            MOV r6, r0
            # assign a lower val
            MOV r4, #1

            #BL secondInput
            #MOV r5, r0
            #SUB r0, r6, r0
            #CMP r0, #1
            #BLT invalidCase

            StartLoop2:
                CMP r0, #1
                BEQ EndLoop2
                    LDR r0, =guessComputerPrompt
                    BL printf
                    MOV r0, #1 // Force Quit
                    B StartLoop2
            EndLoop2:
            LDR r0, =win2
            BL printf

            B EndIf

    invalidCase:
    MOV r1, r6
    LDR r0, =invalid
    BL printf
    B EndIf

    badCaseInput:
    LDR r0, =badInitialInput
    BL printf
    B EndIf

    EndIf:
    ContinueGameLoop:
        # Get next value
        LDR r0, =playAgain
        BL printf
        LDR r0, =prompt
        BL printf
        LDR r0, =input
        LDR r1, =num

        BL scanf
        LDR r1, =num
        LDR r0, [r1, #0]

        B StartGameLoop

    EndGameLoop:
        LDR r0, =Bye
        BL printf
        # Return to the OS
        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.data
    playAgain: .asciz "\nPlay Again?"
    # Prompt the user for initial user input/option
    prompt:  .asciz "\nEnter 2 to play against the computer
                     \nEnter 1 to guess a number from the computer
                     \nEnter 0 or a negative number to quit: \n"
    # Stores user input
    input:   .asciz "%d"
    # Storage for the user input
    num:     .word 0
    # invalid
    invalid: .asciz "\nInvalid user input, please enter a number above 0 and below the max value %d\n"
    badInitialInput: .asciz "\nBad initial input please enter 2, 1, or any number below 1\n"
    lose: .asciz "\nComputer Wins! You Lose!\n"
    win2: .asciz "\nYou win! Take that Computer!\n"
    Bye: .asciz "\nSee you next time!\n"
    guessComputerPrompt: .asciz "\nGuess The Number the Computer Sets!\n"
    gameError: .asciz "\nThe game has unexpectedly shut down with an error!\n"


.text
# function userMaxValInput
userMaxValInput:
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
    prompt1: .asciz "\nEnter Max Value to use for the game: \n"
    # intake user input
    inputFormat: .asciz "%d"


.text
# function secondInput
secondInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]

    LDR r0, =prompt2
    BL printf

    LDR r0, =inputFormat2

    LDR r1, =inputNum2
    BL scanf
    LDR r1, =inputNum2
    LDR r0, [r1, #0]

    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr
.data
    # store user input
    inputNum2: .word 0
    # prompt for computer guess input
    prompt2: .asciz "\nEnter your input for the computer to guess: \n"
    # intake user input
    inputFormat2: .asciz "%d"

.text
.global guessingGame
# guessingGame function
guessingGame:
    SUB sp, sp, #12
    STR lr, [sp, #8]

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
    #ADD r4, r4, #2
    # See binary search logic comment below
    MOV r4, r10
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
    #SUB r6, r6, #2
    # Binary Search Logic Comment
    # Originally, I had thought this binary search logic would be good
    # However, I found it is much more efficient to move the number thresholds
    # to the last registered value because we know that the number is lower or higher
    # than the outputted number.
    MOV r6, r10
    MOV r1, r6
    LDR r0, =higher
    BL printf

    #MOV r0, r10
    BL checkRandom
    B EndIf2

    EndIf2:

    LDR lr, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr
.data
    badInput: .asciz "\ninput must be 1 to 3\n"
    lower: .asciz "\nLower Number Threshold: %d\n"
    higher: .asciz "\nHigher Number Threshold: %d\n"


.text
.global checkRandom
checkRandom:
SUB sp, sp, #16
STR lr, [sp, #12]

MOV r0, r6
BL randFunc
MOV r10, r0

# Debug Statement used to output bad computer guesses
# this is supposed to show the iteration of the loop
# to use the random function until we get a matching value
MOV r1, r0
LDR r0, =compGuess
BL printf

CMP r10, r4
MOVGE r1, #1

CMP r10, r6
MOVLE r2, #1

AND r1, r1, r2
ADD r8, r8, #1
CMP r8, #20
BGE youWon

CMP r1, #1
BEQ randomPassed
BNE newRandomNumber

randomPassed:
    # Clear screen
    BL clearScreen
    MOV r1, r8
    LDR r0, =almostWon
    BL printf
    # Clear r8 loop counter because we passed the number verification
    MOV r8, #0
    MOV r1, r5
    LDR r0, =chosenUserNum
    BL printf

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

newRandomNumber:
    BL checkRandom
    
B EndRandom

youWon:
    # Clear screen
    BL clearScreen
    MOV r0, #2
B returnToMain

returnToMainLoop:

returnToMain:

EndRandom:

LDR lr, [sp, #12]
ADD sp, sp, #16
MOV pc, lr

.data
chosenUserNum: .asciz "\nYour original number: %d\n"
computerGuess: .asciz  "\nIs your number %d?\n"
checkUserGuess: .asciz "\nEnter the corresponding number for your answer
                        \nIs the number:
                        \nHigher?:     3
                        \nLower?:      2
                        \nCorrect!:    1\n"
checkUserInputInput: .asciz "%d"
guessFeedback: .word 0
compGuess: .asciz "\nBad Computer Guess: %d\n"
almostWon: .asciz "\nYou almost won with %d computer guesses!\n"

.text
.global clearScreen
clearScreen:
    SUB sp, sp, #20
    STR lr, [sp, #16]

    LDR r0, =clearCommand
    BL system

    LDR lr, [sp, #16]
    ADD sp, sp, #20
    MOV pc, lr
.data
    clearCommand: .asciz "clear"
