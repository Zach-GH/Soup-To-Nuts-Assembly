.text
.global magicBeanStalk
.global setSeed
.global randFunc
magicBeanStalk:
    SUB sp, sp, #4
    STR lr, [sp]

    # We start here and it is important to note that 
    # The number we recieve is the max value.
    BL setSeed

    # print first random number
    BL randFunc

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
    prompt: .asciz "\nEnter the seed: "
    format: .asciz "%d"
    seed:   .word  0
    output: .asciz "\nThe random number is %d\n"

.text
# Function: 	setSeed
# Author:	Charles Kann
# Date:		7/31/2020
# Purpose:	Set a seed for the randFunc
# Input:	r0: seed
# Output:	None
# Side effect:	Seed is set
setSeed:
    SUB sp, sp, #4
    STR lr, [sp]

    BL srand  // r0 already has the seed

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr


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
    MOV r8, r0   	// Save the random number
    # Modulus operation
    MOV r1, #100
    BL __aeabi_idiv
    MOV r1, #100
    MUL r0, r0, r1
    SUB r0, r8, r0

    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr
