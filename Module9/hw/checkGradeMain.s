#
# Program Name: checkGradeMain
# Author: Zachary Meisner
# Date 11/04/2023
# Purpose: To read a students name and check their GPA average
# Input:
# name and GPA
# Output:
# student name and their corresponding letter grade
#

.global main
.text

main:
    SUB sp, sp, #4
    STR lr, [sp]

# Sentinel Loop
# Initialize:
    LDR r0, =prompt
    BL printf
    LDR r0, =format
    LDR r1, =number
    BL scanf

# StartLabel startLoop
    startLoop:
        LDR r1, =number
        LDR r1, [r1]

        CMP r1, #-1
        BEQ endLoop

            # move input number into r4 to check 0 <= input <= 100
            MOV r4, r1

            MOV r1, #0
            MOV r0, #0
            CMP r4, r0
            MOVGE r1, #1

            MOV r2, #0
            MOV r0, #100
            CMP r4, r0
            MOVLE r2, #1

            AND r1, r1, r2
            MOV r2, #1
            CMP r1, r2
            BEQ inputValid

            # input is invalid
            LDR r0, =error
            BL printf
            B EndIfLoop

            inputValid:
            BL nameInput
            MOV r0, r4
            BL checkGrade
            B EndIfLoop

            EndIfLoop:

        # GetNext value
        LDR r0, =prompt
        BL printf
        LDR r0, =format
        LDR r1, =number
        BL scanf
        B startLoop

    endLoop:

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "\nEnter your GPA, -1 to quit: "
    number: .word 0
    format: .asciz "%d"
    output: .asciz "\nYou entered %d"
    error: .asciz "\nERROR! Value must be 0...100\n"
    ending: .asciz "\nThe program is done"

# END main

.text
checkGrade:
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    # Move r0 input into r4 for a more concise input check
    MOV r4, r0

    # if block
    # default to valid since we already checked the input in the main loop
    MOV r1, #1
    MOV r2, #1
    CMP r1, r2
    # Check to see if the users grade is an A
    # if not, fall into the next case to check against B, C, etc.
    BEQ grade_A

    grade_A:
    MOV r0, #90
    CMP r4, r0
    BLT grade_B

    # Code for grade A
    LDR r0, =GradeA
    BL printf
    B EndIf

    grade_B:
    MOV r0, #80
    CMP r4, r0
    BLT grade_C

    # grade B
    LDR r0, =GradeB
    BL printf
    B EndIf

    grade_C:
    MOV r0, #70
    CMP r4, r0
    BLT grade_D

    # Grade C
    LDR r0, =GradeC
    BL printf
    B EndIf

    grade_D:
    MOV r0, #60
    CMP r4, r0
    BLT Else

    # Grade D
    LDR r0, =GradeD
    BL printf
    B EndIf

    Else:
    # Grade F
    LDR r0, =GradeF
    BL printf
    B EndIf

    EndIf:

# Return to OS land
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    GradeA: .asciz "GPA is A\n"
    GradeB: .asciz "GPA is B\n"
    GradeC: .asciz "GPA is C\n"
    GradeD: .asciz "GPA is D\n"
    GradeF: .asciz "GPA is F\n"

# END checkgrade

.text
nameInput:
    SUB sp, sp, #12
    STR lr, [sp, #4]
    STR r4, [sp, #8]

    LDR r0, =prompt1
    BL printf

    LDR r0, =formatName
    LDR r1, =inputName
    BL scanf

    LDR r0, =inputFormat
    LDR r1, =inputName
    BL printf

    LDR r4, [sp, #8]
    LDR lr, [sp, #4]
    ADD sp, sp, #12
    MOV pc, lr

.data
    inputName: .space 40
    prompt1:  .asciz "Enter your name: "
    formatName: .asciz "%s"
    inputFormat: .asciz "Hello %s, your "
