.text
.global main
.func main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    # Prompt for an input number
    LDR R0, =prompt
    BL printf

    # Scanf
    LDR R0, =input
    LDR R1, =num
    BL scanf

    # Print message
    //LDR R0, =format
    //LDR R1, =num
    //LDR R1, [R1, #0]

    LDR R1, addr_num
    VLDR S14, [R1] // load r1 as float in s15

    VCVT.F64.F32 D5, S14 // convert s0 to double in d1

    LDR R0, =format

    VMOV R2, R3, D5

    BL printf

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

end:
    MOV R7, #1
    SWI 0

addr_num: .word num
addr_input: .word input
.data
    num: .float 0.0
    prompt: .asciz "Enter A Number\n"
    input: .asciz "%f"
    format: .asciz "Your number is %f\n"

.global printf
