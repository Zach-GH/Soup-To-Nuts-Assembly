.global main
.func main
main:
    LDR R1, addr_num_1
    VLDR S0, [R1]

    LDR R2, addr_num_2
    VLDR S1, [R2]

    VADD.f32 S2, S0, S1

    VCVT.F64.F32 D1, S2

    LDR R0, =output

    VMOV R2, R3, D1

    BL printf

end:
  MOV R7, #1
  SWI 0

addr_num_1: .word num_1
addr_num_2: .word num_2
.data
num_1: .float 1.2345
num_2: .float 1.1111
output: .asciz "1.2345 + 1.1111 = %f\n"
//pi: .float 3.141592
//output: .asciz "The value of Pi is %f\n"

.global printf
