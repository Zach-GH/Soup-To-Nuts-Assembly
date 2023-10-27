#
# Program Name: oneFileToRuleThemAllMain.s
# Author: Zachary Meisner
# Date: 10/27/2023
# Purpose: Module 8 Homework to demonstrate
# all needed functionality for conversion ratios.
# Functions: main, caseStatement, userInput, secondInput, milesInput
# Inputs: user input for each function, second user input for hours, third for miles.
# Outputs: Converted floating number pertaining to each required equation.
#

.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r0, #-0x32

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
            MOV r0, r4
            BL caseStatement // take the user input and verify which command to use

            MOV r1, #10 // printScaledInt multiplies the input by 10 to scale output
            BL printScaledInt
            LDR r0, =newline
            BL printf

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
    prompt:  .asciz "Enter option\n
                     3 : kph\n
                     2 : miles2kilometers\n
                     1 : CToF\n
                     0 : Inches2Ft\n
                    -1 : To Quit\n"

    # Stores user input
    input:   .asciz "%d"
    # For printing values, must have this to use printScaledInt
    newline: .asciz "\n"
    # Storage for the user input
    num:     .word 0

.text
# caseStatement
caseStatement:
   SUB sp, sp, #4
   STR lr, [sp, #0]

   # Start of IF block
   MOV r4, r0 // take the original input and store it in r4
   MOV r1, #0
   MOV r0, #-1
   CMP r4, r0 // compare input against -1
   MOVGE r1, #1

   MOV r2, #0
   MOV r0, #3
   CMP r4, r0 // compare input against 3
   MOVLE r2, #1

   AND r1, r1, r2
   MOV r2, #1
   CMP r1, r2
   BEQ case_3 // input is valid

   # Invalid Input
   LDR r0, =Invalid
   BL printf
   MOV r0, #0
   B EndIf

   # if input is 3
   case_3:
   MOV r0, #3
   CMP r4, r0
   BLT case_2

   # case 3 output
   BL milesInput
   MOV r4, r0
   BL secondInput
   MOV r1, r0
   MOV r0, r4
   BL kph // kilometers per hour
   MOV r4, r0
   LDR r0, =case3
   BL printf
   MOV r0, #10
   MUL r0, r0, r4 // scaling the output value
   B EndIf

   # if input is 2
   case_2:
   MOV r0, #2
   CMP r4, r0
   BLT case_1

   # case 2 output
   BL milesInput
   BL miles2kilometers // convert miles to kilometers
   MOV r4, r0
   LDR r0, =case2
   BL printf
   MOV r2, #10
   MUL r0, r4, r2 
   B EndIf

   # if input is 1
   case_1:
   MOV r0, #1
   CMP r4, r0
   BLT case_0

   # case 1 output
   BL userInput
   BL CToFah // convert celsius to fahrenheit
   MOV r4, r0
   LDR r0, =case1
   BL printf
   MOV r0, r4
   B EndIf

   # if input is 0
   case_0:
   MOV r0, #0
   CMP r4, r0
   BLT Else

   # case 0 output
   BL userInput
   BL inches2Ft // convert inches to feet
   MOV r4, r0
   LDR r0, =case0
   BL printf
   MOV r0, r4
   B EndIf

   # if input is -1 and case -1 output
   Else:
   LDR r0, =ByeBye
   BL printf
   B EndIf

   EndIf:

   # Return to the OS
   LDR lr, [sp, #0]
   ADD sp, sp, #4
   MOV pc, lr
.data
    # case statements for each user input
    case0: .asciz "\nTotal Feet: \n"
    case1: .asciz "\nTotal Fahrenheit: \n"
    case2: .asciz "\nTotal Kilometers: \n"
    case3: .asciz "\nTotal Kilometers over x miles and hours: \n"
    ByeBye: .asciz "\nBye Bye\n"
    Invalid: .asciz "input must be -1 to 3\n"


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
    prompt1: .asciz "Enter input: "
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
    # prompt for user hours
    prompt2: .asciz "Enter total hours: "
    # intake user input
    inputFormat2: .asciz "%d"

.text
# function milesInput
milesInput:
    SUB sp, sp, #16
    STR lr, [sp, #8]
    STR r4, [sp, #12]

    MOV r4, r0

    LDR r0, =promptMiles
    BL printf

    LDR r0, =inputFormat3
    LDR r1, =inputNum3
    BL scanf
    LDR r1, =inputNum3
    LDR r0, [r1, #0]

    LDR r4, [sp, #12]
    LDR lr, [sp, #8]
    ADD sp, sp, #16
    MOV pc, lr
.data
    # store user input
    inputNum3: .word 0
    # prompt user for miles
    promptMiles: .asciz "Enter total miles: "
    # intake user input
    inputFormat3: .asciz "%d"
