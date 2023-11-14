.text
.global multiSum
multiSum:
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    # if (n == 0) return 0
    CMP r4, #1
    BNE Else
        MOV r0, r6
        B Return

    # else return m + Mult(m,n-1)
    Else:
        SUB r4, r4, #1
        BL multiSum
        ADD r0, r6, r0
        B Return
    EndIf:
        
    Return: 
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

#END multiSum

.text
.global fibSum
fibSum:
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    CMP r0, #1
    BEQ FibReturn1

    CMP r0, #0
    BEQ FibReturn1

    # Print Statement 1
    MOV r4, r0
    MOV r1, r0
    LDR r0, =debug1
    BL printf
    MOV r0, r4

    SUB r0, r0, #2
    BL fibSum

    # Load Fib(n-1) from the stack
    LDR r1, [sp, #4]
    # Add Fib(n-1) to Fib(n-2)
    ADD r4, r4, r0

    # Print Statement 2
    ADD r1, r4, #1
    LDR r0, =debug2
    BL printf
    MOV r0, r4

    B PhoneHome

FibReturn1:
    ADD r4, r0, #1
    B PrintResult

FibReturn0:
    ADD r4, r0, #1 //#0
    B PrintResult

PrintResult:
    MOV r4, r0
    LDR r0, =debug3
    BL printf
    MOV r0, r4

    B PhoneHome

PhoneHome:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8

    MOV pc, lr

.data
goldenOut: .asciz "\nGolden Wind value is:  %d\n"
debug1: .asciz "\nBefore recursive call %d\n"
debug2: .asciz "\nAfter recursive call %d\n"
debug3: .asciz "\nFinal Output: %d\n"
#END FibSum
