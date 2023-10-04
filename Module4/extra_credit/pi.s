.global main
.func main
main:
   LDR R1, addr_pi
   VLDR S0, [R1]

   VCVT.F64.F32 D1, S0

   LDR R0, =output

   VMOV R2, R3, D1

   BL printf

end:
  MOV R7, #1
  SWI 0

addr_pi: .word pi

.data
pi: .float 3.141592
output: .asciz "The value of Pi is %f\n"

.global printf
