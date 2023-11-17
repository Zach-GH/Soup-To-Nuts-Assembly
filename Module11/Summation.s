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

#
# Use PUSH and POP at beginning of function to get the same return number
# F4 = F3 + F2 = F1 + F0 + F1 + F1 + F0
# F3 = F2 + F1 = F1 + F0 + F1
# F2 = F1 + F0
#
.text
.global fibSum
fibSum:
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    MOV r4, r0
    SUB r4, r4, #1

    # if r0 is 0 or 1 return 1
    CMP r4, #0
    MOVEQ r0, #1
    BEQ Return2

    CMP r4, #1
    MOVEQ r0, #1
    BEQ Return2 @ return 1 in r0

    SUB r0, r4, #1
    BL fibSum
    SUB r0, r4, #1

    ADD r0, r4, r0

    b Return2 @ not really needed

    # pop stack and return
    Return2:
    # Print the result
    MOV r1, r0
    LDR r0, =printOut
    BL printf

    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
printOut: .asciz "\nprint output: %d\n"
printCounter: .asciz "\nCounter is at %d\n"
print1: .asciz "\nprint1: %d\n"
print2: .asciz "\nprint2: %d\n"
print3: .asciz "\nprint3: %d\n"
print4: .asciz "\nprint4: %d\n"

#END FibSum
