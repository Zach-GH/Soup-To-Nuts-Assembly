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

    #Save arg in r4
    MOV r6, r0

    CMP r6, #0
    BEQ Return0

    CMP r6, #1
    BEQ Return1

    CMP r4, #0
    BEQ Recursive1

    CMP r4, #1
    BEQ Recursive2

    Recursive1:
        ADD r4, r4, #1
        SUB r4, r6, #1
        MOV r8, r0
        CMP r4, #1
        BEQ fibSum
        #MOV r8, r0

    Recursive2:
        ADD r4, r4, #1
        SUB r10, r6, #2
        MOV r10, r0
        CMP r4, #2
        BEQ fibSum
        #MOV r10, r0

    MOV r1, r8
    LDR r0, =printOut
    BL printf
    MOV r8, r0

    MOV r1, r10
    LDR r0, =printOut
    BL printf
    MOV r10, r0

    ADD r0, r8, r10

    Return0:
        #MOV r0, #0
        ADD r0, r0, #0
        B Return2

    Return1:
        #MOV r0, #1
        ADD r0, r0, #1
        B Return2

    #MOV r4, r0

    # if (n == 0) return 0
    #CMP r4, #0
    #MOVEQ r1, #1
    #CMP r4, #1
    #MOVEQ r2, #1

    #ORR r1, r1, r2
    #CMP r1, #1
    #BNE Else2
        #MOV r0, #1
        #B Return2

    # Else return FibSum(n-1) + FibSum(n-2)
    #Else2:
        #CMP r6, #0
        #BEQ Recursive1
        #CMP r6, #1
        #BEQ Recursive2

        #ADD r6, r6, #1
        #CMP r6, #4
        #BEQ fibSum

        # If this is uncommented we can only see the two separate values instead of the accurate value at the end
        #MOV r1, r10 // is 11 + 11 for some reason
        #LDR r0, =print4
        #BL printf
        #MOV r10, r0
        #MOV r1, r8
        #LDR r0, =print4
        #BL printf
        #MOV r8, r1
        #B Return2
    #EndIf2:

    #Recursive1:
        #ADD r6, r6, #1
        #SUB r8, r4, #1
        #MOV r1, r8
        #LDR r0, =print1
        #BL printf
        #MOV r8, r0
        #MOV r0, r8
        #B Else2
        #B fibSum
        #B Recursive2

    #Recursive2:
        #ADD r6, r6, #1
        #SUB r10, r4, #2
        #MOV r1, r10
        #LDR r0, =print2
        #BL printf
        #MOV r10, r0
        #MOV r0, r10
        #B fibSum
        #B Else2

    Return2:
    # Print the result
    #ADD r0, r10, r8
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
