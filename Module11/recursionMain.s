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
            BLT multiCase

            multiCase:
                CMP r0, #2
                BLT goldCase
                BL multiRecursion
                
            goldCase:
                CMP r0, #1
                BLT EndMainLoop
                BL goldenRatio

                
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

.text
.global multiRecursion
# A program to calculate multiplication using successive addition with recursion.
# Mult(m,n)=if n is 1 return m
# else return m+Mult(m-1,n)
multiRecursion:
    SUB sp, sp, #12
    STR lr, [sp, #0]

    MOV r0, #1
    BL getInput
    MOV r6, r0
    MOV r0, #0
    BL getInput
    MOV r4, r0

    BL Recursion

    #Recursion:
        # if (n == 1) return m
        #CMP r4, #1
        #BNE Else
            #MOV r0, r6
            #B Return

    # else return m + Mult(m-1,n)
    #Else:
        # This has to be special and put into the r8 register
        # So our subtraction does not affect the overall output
        # Due to m + m-1 (where m has to stay unchanged)
        #SUB r8, r6, #1
        #MOV r0, r8
        #MOV r1, r4

        #MUL r0, r8, r4
        #BL Recursion
        #ADD r0, r0, r6
        #B Return
    EndIf:

    Return:
        MOV r1, r0
        LDR r0, =outputMult
        BL printf
        MOV r0, #-1
        BL inputVerification

        LDR lr, [sp, #0]
        ADD sp, sp, #12
        MOV pc, lr

Recursion:
    CMP r4, #1
    BEQ RecursionBaseCase
        #MOV r0, r6
        #B RecursionReturn

    #Else:
    SUB r8, r6, #1
    MOV r0, r8
    MOV r1, r4

    BL Recursion
    ADD r0, r6, r0

RecursionBaseCase:
    B RecursionReturn

RecursionReturn:
    BX lr

# End multiRecursion

.text
.global goldenRatio
# A program to calculate a Fibonacci number recursively.
# A Fibonacci number is defined recursively as:
# Fib(n) = if (n==0 or n==1) return 1
# else return Fib(n-1)+Fib(n=2)
goldenRatio:
    SUB sp, sp, #16
    STR lr, [sp, #0]

    # prompt user for input1
    MOV r0, #1
    BL getInput
    # move input1 into r6 for safekeeping
    MOV r6, r0
    MOV r1, r6
    LDR r0, =outputNumber
    BL printf
    MOV r0, r6
    BL inputVerification

    LDR lr, [sp, #0]
    ADD sp, sp, #16
    MOV pc, lr

# End goldenRatio

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
    # goldenRatio

