# Author: Zachary Meisner
# Date: 12/11/2023
# Purpose: Intake user input, add it all together, and calculate average
# Functions: startInitLoop startMainLoop processAverage processTotalAdded processTotalNumber
# Inputs: user input number in loop
# Outputs: total number, total amount, total average
#

.global main
.text
main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # initialize the registers we will be using
    MOV r0, #0
    MOV r1, #0
    MOV r4, #0 // totalNumber
    MOV r6, #0 // totalAverage
    MOV r8, #0 // totalAdded

    startInitLoop:
        BL getInput
        BL inputVerification
        startMainLoop:
            # add 1 to r4 to keep track of the total number
            ADD r4, r4, #1
            # Add r8 and r0 together to get a whole number of every input added together
            ADD r8, r8, r0
            B startInitLoop

    processAverage:
    # we are dividing the totalAdded by totalNumber to get the average
    MOV r0, r8
    MOV r1, r4
    BL __aeabi_idiv
    # after dividing the new output is in r0 so move it to r1 to print the output
    MOV r6, r0
    MOV r1, r6
    LDR r0, =totalAverage
    BL printf
    B EndInitLoop

    # process the total of all user inputs added together
    processTotalAdded:
    MOV r1, r8
    LDR r0, =totalAdded
    BL printf
    B processAverage

    # process the average of all the user inputs
    processTotalNumber:
    MOV r1, r4
    LDR r0, =totalNumber
    BL printf
    B processTotalAdded

    inputVerification:
        # if r0 is less than 0 then process output values
        CMP r0, #0
        BLT processTotalNumber
        # if this is a value higher than -1 continue the loop
        B startMainLoop

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

    LDR r0, =promptInput
    BL printf
    LDR r0, =inputFormat
    LDR r1, =inputNum
    BL scanf
    LDR r1, =inputNum
    LDR r0, [r1, #0]

    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr

# End getInput

.data
    # main
    outputNumber: .asciz "\nOutput number: %d\n"
    totalAverage: .asciz "\nYour total average was: %d\n"
    totalNumber: .asciz "\nYour total number of inputs was: %d\n"
    totalAdded: .asciz "\nTotal of inputs added together: %d\n"
    promptInput: .asciz "\nEnter a number: "
    inputFormat: .asciz "%d"
    inputNum: .word 0

