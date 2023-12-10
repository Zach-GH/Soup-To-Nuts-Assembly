#
# Program Name: findLargestMain.s
# Author: Zachary Meisner
# Date: 11/04/2023
# Purpose: To find the largest of three numbers
# Input: Three numbers
# Output: The largest number
#

.text
.global main

main:
    # Off to OS Land
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt for first input
    LDR r0, =prompt
    BL printf
    LDR r0, =input
    LDR r1, =num
    BL scanf

    # StartLabel startLoop
    startLoop:
        LDR r1, =num
        LDR r1, [r1]

        # The only drawback of using -1 as the loop exit
        # is that the first value can never be -1
        CMP r1, #-1
        BEQ endLoop

            # Block or statement to execute
            # We move the first input into r4 for holding
            MOV r4, r1
            # We go get the second input and return the value in r0
            BL secondInput
            # We move the second input into r6 for safe keeping
            MOV r6, r0
            # Go get the third input
            BL thirdInput
            # Compare all three inputs and output the highest
            BL findMaxOf3

        # Get Next Value
        LDR r0, =prompt
        BL printf
        LDR r0, =input
        LDR r1, =num
        BL scanf
        B startLoop

     endLoop:

    # Return from OS Land
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "\nEnter first number, -1 to quit: "
    input: .asciz "%d"
    num: .word 0


.text
secondInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    LDR r0, =prompt2
    BL printf

    LDR r0, =inputFormat2
    LDR r1, =inputNum2
    BL scanf

    LDR r1, =inputNum2
    LDR r0, [r1, #0]

    LDR r4, [sp, #4]
    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr

.data
    inputNum2: .word 0
    prompt2: .asciz "\nEnter a second number: "
    inputFormat2: .asciz "%d"


.text
thirdInput:
    SUB sp, sp, #12
    STR lr, [sp, #4]
    STR r4, [sp, #8]

    LDR r0, =prompt3
    BL printf

    LDR r0, =inputFormat3
    LDR r1, =inputNum3
    BL scanf

    LDR r1, =inputNum3
    LDR r0, [r1, #0]

    LDR r4, [sp, #8]
    LDR lr, [sp, #4]
    ADD sp, sp, #12
    MOV pc, lr

.data
    inputNum3: .word 0
    prompt3: .asciz "\nEnter a third number: "
    inputFormat3: .asciz "%d"


# We get to the following compare function and have these tools to use
# In r4, we have our first input value
# in r6, we have our second input value
# in r8, we have our third input value (below)

# CPSR status instructions
# ADDEQ - Adds two values if inputs to previous CMP instruction are equal
# SUBLT - Subtracts two values if input1 < input2 in the previous CMP instruction

# Valid options for checking status
# EQ - Rn and op2 values are equal
# GT - Rn value is greater than or equal the op2 value
# GE - Rn value is less than or equal the op2 value
# LT - Rn value is less than the op2 value
# LE - Rn value is less than or equal the op2 value

# CMP r1, r2
# BEQ label1
#    #Some Code
# label1:
#
# Compare r1 and r2 to see if they are equal
# If they are equal GOTO label1:
# otherwise execute some code
#

.text
findMaxOf3:
    SUB sp, sp, #16
    STR lr, [sp, #8]
    STR r4, [sp, #12]

    MOV r8, r0

    # meat and potatoes of compare value function
    # we start by clearing all input in r1 r0 and r2 for good measure
    MOV r1, #0
    MOV r0, #0
    MOV r2, #0

    # compare r4 and r6
    CMP r4, r6
    # if r4 is greater than or equal to r6
    MOVGE r1, #1

    CMP r4, r8
    # if r4 is greater than or equal to r8
    MOVGE r2, #1

    # if r4 is greater than both r6 and r8
    AND r1, r1, r2
    MOV r2, #1
    CMP r1, r2
    # r4 is the highest continue if not
    BEQ foundFirstHighest

    # If the first input is not the highest check the second
    # clear prior register input
    MOV r1, #0
    CMP r6, r8
    MOVGE r1, #1
    # test if r6 greater than or equal to r8
    CMP r1, r2
    # r6 is the highest continue if not
    BEQ foundSecondHighest

    # If the second input is not the highest it must be the third
    MOV r1, #1
    # default to the third input as the highest if we fail all prior tests
    CMP r1, r2
    # r8 is the highest do not continue
    BEQ foundThirdHighest
    B EndIf

    # Following three cases output the corresponding register value to be printed
    foundFirstHighest:
    MOV r1, r4
    LDR r0, =output
    BL printf
    B EndIf

    foundSecondHighest:
    MOV r1, r6
    LDR r0, =output
    BL printf
    B EndIf

    foundThirdHighest:
    MOV r1, r8
    LDR r0, =output
    BL printf
    B EndIf

    EndIf:

    # Return from OS land
    LDR r4, [sp, #12]
    LDR lr, [sp, #8]
    ADD sp, sp, #16
    MOV pc, lr

.data
    output: .asciz "\n%d was the highest number!"
