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
                MOV r0, #0
                BL getUserInput
                # Move the max value into r6
                MOV r6, r0

                # For some reason the randFunc function the first two iterations
                # is stuck on the number 32
                # here, we basically initialize the function
                # so it outputs random numbers every time
                BL randFunc
                MOV r0, r6
                BL randFunc

                # We have a max val, let us also assign a lowest val
                MOV r4, #1

                # Get the second input (users number for the computer to guess)
                MOV r0, #1
                BL getUserInput
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

                    # If the number is 2 then you win!
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
                    LDR r0, =win
                    BL printf
                    LDR r0, =playAgain
                    BL printf
                    B ContinueGameLoop

                youLose:
                    MOV r8, #0
                    LDR r0, =lose
                    BL printf
                    LDR r0, =playAgain
                    BL printf
                    B ContinueGameLoop

            guessNumberFromComputer:
            # if the number is less than 1
            # End the loop otherwise
            # guess the number from the computer
            # this uses the similar logic as above
            CMP r0, #1
            BLT EndGameLoop

            MOV r0, #0
            BL getUserInput
            # move max val into r6
            MOV r6, r0

            # assign a lower val
            MOV r4, #1

            StartLoop2:
                CMP r0, #2
                BLT checkLose

                CMP r0, #2
                BEQ youWonGame

                BL guessAgainstComputer
                B StartLoop2

                checkLose:
                CMP r0, #1
                BEQ youLost
                BL guessAgainstComputer
                B StartLoop2

                youLost:
                LDR r0, =lose
                BL printf
                B ContinueGameLoop

                youWonGame:
                LDR r0, =win
                BL printf
                B ContinueGameLoop

            EndLoop2:
            LDR r0, =lose
            BL printf
            B EndGameLoop

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
    playAgain: .asciz "\nPlay Again?\n"
    # Prompt the user for initial user input/option
    prompt:  .asciz "\nEnter 2 to play against the computer
                     \nEnter 1 to guess a number generated by computer
                     \nEnter 0 or a negative number to quit: \n"
    # Stores user input
    input:   .asciz "%d"
    # Storage for the user input
    num:     .word 0
    # invalid
    invalid: .asciz "\nInvalid user input, please enter a number above 0 and below the max value %d\n"
    badInitialInput: .asciz "\nBad initial input please enter 2, 1, or any number below 1\n"
    lose: .asciz "\nComputer Wins! You Lose!\n"
    win: .asciz "\nYou: Take that Computer!\n"
    Bye: .asciz "\nSee you next time!\n"
    guessComputerPrompt: .asciz "\nGuess The Number the Computer Sets!\n"
    gameError: .asciz "\nThe game has unexpectedly shut down with an error!\n"


.text
.global getUserInput
# function getUserInput
getUserInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]

    CMP r0, #1
    BLT userMaxValInput

    LDR r0, =promptUserGuess
    BL printf
    LDR r0, =inputFormat
    LDR r1, =inputNum
    BL scanf
    LDR r1, =inputNum
    LDR r0, [r1, #0]
    B EndInputPrompt

    userMaxValInput:
        LDR r0, =promptMaxVal
        BL printf
        LDR r0, =inputFormat
        LDR r1, =inputNum
        BL scanf
        LDR r1, =inputNum
        LDR r0, [r1, #0]
        B EndInputPrompt

    EndInputPrompt:
        LDR lr, [sp, #0]
        ADD sp, sp, #8
        MOV pc, lr
.data
    # store user Input
    inputNum: .word 0
    # prompt user for input
    promptMaxVal: .asciz "\nEnter Max Value to use for the game: \n"
    # intake user input
    inputFormat: .asciz "%d"
    #inputNum2: .word 0
    promptUserGuess: .asciz "\nEnter your input for the computer to guess: \n"
    #inputFormat2: .asciz "%d"

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
    # Binary Search
    ADD r4, r4, #2
    MOV r1, r4
    LDR r0, =lower
    BL printf

    BL checkRandom
    B EndIf2

    # if input is 2
    case_2:
    # case 2 output (the number is lower)
    # Binary Search
    SUB r6, r6, #2
    MOV r1, r6
    LDR r0, =higher
    BL printf

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

MOV r10, #10

MOV r0, r6
BL randFunc
MOV r10, r0

# Debug Statement used to output bad computer guesses
# this is supposed to show the iteration of the loop
# to use the random function until we get a matching value
MOV r1, r10
LDR r0, =compGuess
BL printf

MOV r1, #0
MOV r2, #0

CMP r10, r4
MOVGE r1, #1

CMP r10, r6
MOVLT r2, #1

AND r1, r1, r2
ADD r8, r8, #1
CMP r8, #100
BGE youWon

CMP r1, #1
BEQ randomPassed
BNE newRandomNumber

randomPassed:
    # Clear screen
    BL clearScreen
    MOV r1, r8
    # Almost Won statement
    LDR r0, =almostWon
    BL printf

    # Clear r8 loop counter because we passed the number verification
    MOV r8, #0

    # Move onto user and computer guess output
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
    BEQ returnToMain

    BL guessingGame

B returnToMain

newRandomNumber:
    BL checkRandom
B EndRandom

youWon:
    # Clear Screen
    BL clearScreen
    # Move r8 into r1 for output
    MOV r1, r8
    LDR r0, =computerLost
    BL printf
    MOV r0, #2
B returnToMain

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
computerLost: .asciz "\nThe computer has tried to guess your number %d times and gave up!\n"

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

.text
.global guessAgainstComputer
guessAgainstComputer:
    SUB sp, sp, #24
    STR lr, [sp, #20]

    MOV r1, #0
    MOV r2, #0

    # Computer guesses random number
    MOV r0, r6
    BL randFunc
    # Move the computers guess into r10
    MOV r10, r0

    # Verify that the guess is good
    CMP r10, r4
    MOVGE r1, #1

    CMP r10, r6
    MOVLE r2, #1

    AND r1, r1, r2
    CMP r1, #1
    # The guess has passed, move onto users guess
    BEQ computerGuessPassed
    # The guess did not pass, try again
    BNE newComputerNumber

    newComputerNumber:
        BL guessAgainstComputer

    computerGuessPassed:
        #MOV r1, r10
        #LDR r0, =computerGuessPass
        #BL printf
        LDR r0, =promptUserForGuess
        BL printf
        LDR r0, =userInputFormat
        LDR r1, =usersGuessFB
        BL scanf
        LDR r1, =usersGuessFB
        LDR r0, [r1, #0]
        # Move the users guess into r5
        MOV r5, r0

        MOV r1, r5
        LDR r0, =yourGuessWasDrumrollPlease
        BL printf

        MOV r1, #0
        MOV r2, #0

        CMP r5, r4
        MOVGE r1, #1

        CMP r5, r6
        MOVLE r2, #1

        # Add the amount of times that we have guessed
        AND r1, r1, r2
        ADD r8, r8, #1
        CMP r8, #20
        BGE theHouseAlwaysWins

        CMP r1, #1
        BEQ userGuessPassed
        BNE badUserGuess

        userGuessPassed:
            #BL clearScreen
            # Output the amount of times you have guessed out
            MOV r1, r8
            LDR r0, =youHaveGuessed
            BL printf
            # Now we have to verify against the Computers number
            CMP r5, r10
            BGT yourGuessWasHigh

            CMP r5, r10
            BLT yourGuessWasLow

            CMP r5, r10
            BEQ youBeatTheComputer

            yourGuessWasHigh:
                MOV r1, r5
                LDR r0, =yourGuessHigh
                BL printf
                BL computerGuessPassed

            yourGuessWasLow:
                MOV r1, r5
                LDR r0, =yourGuessLow
                BL printf
                BL computerGuessPassed

            youBeatTheComputer:
                BL clearScreen
                LDR r0, =youBeatMe
                BL printf
                MOV r0, #2
            B EndGuessAgainstComputer

        badUserGuess:
            LDR r0, =yourGuessWasBad
            BL printf
            MOV r1, r6
            LDR r0, =highThresh
            BL printf
            MOV r1, r4
            LDR r0, =lowThresh
            BL printf
            BL computerGuessPassed

        theHouseAlwaysWins:
            BL clearScreen
            MOV r1, r8
            LDR r0, =houseWins
            BL printf
            MOV r0, #1
        B EndGuessAgainstComputer

    EndGuessAgainstComputer:

    LDR lr, [sp, #20]
    ADD sp, sp, #24
    MOV pc, lr
.data
promptUserForGuess: .asciz "\nWhat is your guess?\n"
usersGuessFB: .word 0
yourGuessWasBad: .asciz "\nYour guess was not within threshold of alotted values, please guess again!"
highThresh: .asciz "\nHigh Threshold: %d"
lowThresh: .asciz "\nLow Threshold: %d \n"
youHaveGuessed: .asciz "\nYou have guessed %d times so far, when will you give up?\n"
yourGuessHigh: .asciz "\n%d is too High! Guess Again\n"
yourGuessLow: .asciz "\n%d is too Low! Guess Again\n"
youBeatMe: .asciz "\nComputer: You beat me! Congratulations!\n"
houseWins: .asciz "\nThey say the house always wins, you guessed %d times and still could not beat me!\n"
computerGuessPass: .asciz "\nThe Computers guess was %d"
userInputFormat: .asciz "%d"
yourGuessWasDrumrollPlease: .asciz "\nYour guess was %d\n"
