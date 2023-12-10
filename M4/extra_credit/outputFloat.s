.text
.global main
main:
    SUB sp, sp, #8 //#4
    STR lr, [sp, #4] //]

    # Prompt for input
    LDR r0, =prompt
    BL printf

    # Scanf
    LDR r0, =input
    LDR r1, =num
    BL scanf

    # Printing the message
    MOV r0, r1
    LDR r0, =format
    VCVT.F64.F32 d0, s0
    VMOV r2, r3, d0
    BL printf

    LDR lr, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    num: .float 0.0
    prompt: .asciz "Enter a number\n"
    input: .asciz "%f"
    format: .asciz "Your number is %f\n"
