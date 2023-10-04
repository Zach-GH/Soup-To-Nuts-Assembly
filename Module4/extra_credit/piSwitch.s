.global main
.func main
main:
    MOV R2, #1
    CMP R2, #0
    BEQ case_0

    CMP R2, #1
    BEQ case_1

    B case_def

case_0:
    LDR R0, =output_0
    B end

case_1:
    LDR R0, =output_1
    B end

case_def:
    LDR R0, =output_def

end:
  BL puts
  MOV R7, #1
  SWI 0

.data
output_0: .asciz "It's 0"
output_1: .asciz "It's 1"
output_def: .asciz "I don't know what it is"

.global puts
