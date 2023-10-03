.text
.global main

main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r0, #5
    BL subValue
    MOV r1, r0

    LDR r0, =output

    BL printf
    MOV r0, #0
    LDR r0, =newline
    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
    output:  .asciz "\nFahrenheit is %d\n"
    newline: .asciz "\n"

.text
# function addValue to add 32 for celsius to fahrenheit conversion
subValue:
    SUB sp, sp, #8
    STR lr, [sp, #0]
    STR r4, [sp, #4] // r4 is used to save r0
                     // so store the original value to the stack
    MOV r4, r0       // Save r0 in r4

    LDR r0, =prompt
    BL printf
    LDR r0, =inputFormat
    LDR r1, =inputNum
    BL scanf
    LDR r1, =inputNum
    LDR r0, [r1]
    MOV r6, #5       // saves value of 5 into r6
    SUB r0, #32      // subtracts a value of 32 to our input variable in r0
    MUL r0, r0, r6   // multiplies r6 and r0 (input * 5) and saves the output into the r0 register
    MOV r1, #9       // r1 equals 9 now
    // The input dividend is in r0 and the division is in r1
    BL __aeabi_idiv  // which means that this is our input value divided by 5

    LDR r4, [sp, #4]
    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr
.data
    inputNum: .word 0
    prompt: .asciz "Enter input number: "
    inputFormat: .asciz "%d"
