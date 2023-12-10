.global randFunc
.text
# Function: 	randFunc
# Author:	Charles Kann
# Date:		7/31/2020
# Purpose: 	To retrieve a random number from 0..r0
randFunc:
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    #Get the random number, setting the limit using a modulus operation
    BL rand

    MOV r4, r0   	// Save the random number
    # Modulus operation
    MOV r1, #101 // I had to change this to include 10 otherwise it would only output 1 through 9
    BL __aeabi_idiv
    MOV r1, #101
    MUL r0, r0, r1
    SUB r0, r4, r0

    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

