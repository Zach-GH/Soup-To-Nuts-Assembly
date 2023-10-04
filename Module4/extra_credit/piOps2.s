.global main
.func main
main:
    LDR R1, addr_num_1
    VLDR S0, [R1]

    LDR R2, addr_num_2
    VLDR S1, [R2]

    VCMP.F32 S0, S1

    VMRS APSR_nzcv, FPSCR

    MOVEQ  R1, #1
    MOVNE R1, #0

    LDR R0, =output

    BL printf

end:
  MOV R7, #1
  SWI 0

addr_num_1: .word num_1
addr_num_2: .word num_2

.data
num_1: .float 1.234
num_2: .float 5.678
output: .asciz "Are numbers equal: %d\n"

.global printf
