.text
.global main
main:
# Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

# Prompt for input in feet
    LDR r0, =prompt1
    BL printf
# Read feet
    LDR r0, =input1
    //LDR r1, =num1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
   // LDR r1, =num1
    LDR r0, [sp, #0]
    ADD sp, sp, #4
    MOV r4, r0

    BL secondInput
    MUL r4, r4, r0

# Read feet and inches
    //LDR r0, =input1
    //LDR r1, =num1
    //MOV r4, r0
    //LDR r0, =input2
    //LDR r1, =num2

    //LDR r4, =input2 // added
    //LDR r5, =num2 // added

    //SUB sp, sp, #4
    //MOV r1, sp

    // BL scanf

    //LDR r0, [sp, #0]
    //ADD sp, sp, #4

    //MOV r4, #12 // added
    //MUL r1, r1, r4 // added
    //ADD r1, r1, r5 // added


# Convert
    BL inches2Ft
    ADD r0, r0, r4
    MOV r4, r0

# Printing The Message
    LDR r0, =format1
    BL printf
    MOV r0, r4
    MOV r1, #10
    //BL printScaledInt
    LDR r0, =newline
    BL printf

# Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter total length of feet: "
    prompt2: .asciz "Enter total length of inches: \n" // added
    format1: .asciz "\nThe length in inches is "
    input1:  .asciz "%d"
    input2:  .asciz "%d" // added
    newline: .asciz "\n"
    num1: .word 0 //
    num2: .word 0 // added

.text
# function secondInput
secondInput:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4]

    MOV r4, r0

    LDR r0, =prompt
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
    inputNum: .word 0
    prompt: .asciz "Enter inches: "
    inputFormat: .asciz "%d"
