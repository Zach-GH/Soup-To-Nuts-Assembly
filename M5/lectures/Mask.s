.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp]

    MVN r4, #0 // first mov the negation of #0 into r4 making all r4 bits value 1
    MOV r5, #0x0000000f // put into r5 the first 4 lower level bits
                        // so it has the value 15
    MOV r6, #1 // now put 1 into r6 so all bits are 0 except for the lowest order bit
    AND r1, r4, r5 // r4 with all the bits set mask out with r5 just the bottom 4 bits
                   // outputting result into r1
                   // just the bottom 4 bits will go into r1
    ORR r2, r1, r4 // r4 OR r1 all bits turned back on in r2 
    AND r1, r2, r6 // just look at lowest order bit r2 AND r6
                   // r2 which has all bits on
                   // r6 which only has lowest order bit on
                   // r1 will only have its lowest bit on with all others masked out

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
