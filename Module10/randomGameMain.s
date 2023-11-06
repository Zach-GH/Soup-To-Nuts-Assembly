#
# Program Name: randomGameMain.s
# Author: Zachary Meisner
# Date: 11/5/2023
# Purpose: Module 10 Homework
# Functions:
# Inputs:
# Outputs:
#

.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    startLoop:
        LDR r0, =prompt
        BL printf

        LDR r0, =input
        LDR r1, =num
        BL scanf

        LDR r1, =num
        LDR r1, [r1]

        CMP r1, #-1
        BEQ endLoop

            BL caseStatement

            B startLoop

    endLoop:
        LDR r0, =ByeBye
        BL printf

        # Return to the OS
        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.text
caseStatement:
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Start of IF block
   MOV r4, r1 // move user input into r4

   CMP r4, #1
   BEQ inputIs1

   CMP r4, #0
   BEQ inputIs0

   LDR r0, =Invalid
   BL printf
   B EndIf

   # if input is 1
   inputIs1:
   MOV r0, #2
   BL guessTheNumber
   MOV r4, r0 // store the maximum value chosen in r4
   MOV r0, #1
   BL guessTheNumber

   # Print out user entered number
   MOV r1, r0
   LDR r0, =case1
   BL printf

   # Print out max value
   MOV r1, r4
   LDR r0, =maxVal
   BL printf

   B EndIf

   inputIs0:
   MOV r0, #2
   BL guessTheNumber
   MOV r4, r0 // store the maximum value chosen in r4
   MOV r0, #0
   # Allow the user to input a number for the computer
   BL guessTheNumber

   # Print out user entered number
   MOV r1, r0
   LDR r0, =case0
   BL printf

   # Print out max value
   MOV r1, r4
   LDR r0, =maxVal
   BL printf

   B EndIf

   EndIf:

   # Return to the OS
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr

# Function to retrieve input from the user for the computer to guess
# Allows the user to input a number for the computer to guess
#
guessTheNumber:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    CMP r0, #2
    BEQ response2

    CMP r0, #1
    BEQ response1

    CMP r0, #0
    BEQ response0

    response2:
    LDR r0, =prompt2
    B EndIf2

    response1:
    LDR r0, =prompt1
    B EndIf2

    response0:
    LDR r0, =prompt0
    B EndIf2

    EndIf2:

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
    # case statements for each user input
    prompt:  .asciz "\nEnter option\n 1 : Guess The Number\n 0 : Challenge The Computer\n-1 : To Quit\n"
    input:   .asciz "%d"
    num:     .word 0
    ByeBye:  .asciz "\nBye Bye!\n"
    case0:   .asciz "\nYour number is %d!\n"
    case1:   .asciz "\nYour number is %d!\n"
    maxVal:  .asciz "\nYour chosen max value is %d!\n"
    Invalid: .asciz "input must be -1 to 1\n"
    inputNum: .word 0
    prompt2: .asciz "What is the maximum value to guess? "
    prompt1: .asciz "Enter a number for the computer to guess! "
    prompt0: .asciz "Enter your number guess to beat the computer! "
    inputFormat: .asciz "%d"
