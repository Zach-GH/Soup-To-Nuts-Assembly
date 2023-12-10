.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r0, #5
    BL addValue
    MOV r1, r0
    LDR r0, =output
    BL printf

    MOV r0, #0
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
.data
    output: .asciz "Your answer is %d\n"

.text
# function addValue to add 32 for celsius to fahrenheit conversion
addValue:
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
    MOV r6, #9       // saves value of 9 into r6
    MUL r0, r0, r6   // multiplies r6 and r0 (input * 9) and saves the output into the r0 register
    MOV r1, #5       // r1 equals 5 now
    // The input dividend is in r0 and the division is in r1
    BL __aeabi_idiv  // which means that this is our input value divided by 5
    ADD r0, #32      // adds a value of 32 to our input variable in r0

    LDR r4, [sp, #4]
    LDR lr, [sp, #0]
    ADD sp, sp, #8
    MOV pc, lr
.data
    inputNum: .word 0
    prompt: .asciz "Enter input number: "
    inputFormat: .asciz "%d"
