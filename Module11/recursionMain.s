# If r0 is less than 0 (a negative number) end the loop
# Author: Zachary Meisner
# Date: 11/12/2023
# Purpose: Demonstrating Recursion
# Functions:
# Inputs:
# Outputs:
#

.global main
.text
main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    startInitLoop:
        MOV r0, #2
        BL getInput
        BL inputVerification
        startMainLoop:
            # If r0 is less than 2 go to multiRecursion
            CMP r0, #3
            BLT getMultiInput

            getMultiInput:
                CMP r0, #2
                BLT getGoldInput

                MOV r0, #1
                BL getInput
                MOV r6, r0

                MOV r0, #0
                BL getInput
                MOV r4, r0

                BL multiCase

                multiCase:
                BL multiSum
                MOV r1, r0
                LDR r0, =outputMult
                BL printf
                MOV r0, #0
                B startInitLoop
                
            getGoldInput:
                CMP r0, #1
                BLT EndMainLoop

                MOV r0, #0
                BL getInput
                MOV r4, r0
                BL goldCase

                goldCase:
                MOV r6, #0
                MOV r0, r4
                BL fibSum
                MOV r0, #0
                B startInitLoop

                
    badInitInput:
    LDR r0, =badInitInputMessage
    BL printf
    B startInitLoop

    inputVerification:
        # input threshold bottom is -1
        CMP r0, #-1
        MOVGE r1, #1
        # input threshold top is 2
        CMP r0, #2
        MOVLE r2, #1
        # both conditions have to be satisfied to be considered valid input
        AND r1, r1, r2
        CMP r1, #1
        # if input is valid start the main loop
        BEQ startMainLoop
        CMP r1, #1
        # else continue on until -1
        BNE badInitInput

    EndMainLoop:
    EndInitLoop:

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

# End Main

.text
.global getInput
getInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]

    CMP r0, #3
    BLT input2
    input2:
        CMP r0, #2
        BLT input1
        LDR r0, =promptInput2
        BL printf
        B processInput

    input1:
        CMP r0, #1
        BLT input0
        LDR r0, =promptInput1 // M

        BL printf
        B processInput

    input0:
        LDR r0, =promptInput0 // N
        BL printf
        B processInput

    processInput:
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

# End getInput

.data
    # main
    outputNumber: .asciz "\nOutput number: %d\n"
    badInitInputMessage: .asciz "\nBad initial input\n"
    # getInput
    promptInput2: .asciz "\nEnter  2 for multi-recursion
                          \nEnter  1 for fibonacci-recursion
                          \nEnter -1 to quit: \n\n"
    promptInput1: .asciz "\nEnter M: "
    promptInput0: .asciz "\nEnter N: "
    inputFormat: .asciz "%d"
    inputNum: .word 0
    # multiRecursion
    outputMult: .asciz "\nOutput multiplied recursion: %d\n"

