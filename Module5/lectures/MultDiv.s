.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp]

    MOV r4, #5 // put the number 5 into register 4
    // to multiply by 4 we have to multiply by 2 squared
    // to multiply by 2 squared, we just have to shift left 2 binary digits
    // LSL is logical shift left
    // we are putting the value into r5 and shift the value of r4 by 2 positions
    // the value in r5 should now be 20
    LSL r5, r4, #2

    // we still have 5 in r4 but we want to multiply by 9
    // the number 9 is 8+1 or a 3 shift and a 2 shift
    LSL r5, r4, #3 // shift the value of r4 into r5 by 3 bits which
                   // is equivalent to x8 so we should get 40
    ADD r5, r5, #5 // add to r5 the value of 5 which gives us the fourth 5 i.e. 9x5

    // Divide 7/3 and then -7/3
    MOV r4, #7 // move the value of 7 into r4
    // since we want to divide by 2 we shift right by 1 bit
    // we want have to shift arithmatically to maintain the signed bit
    ASR r5, r4, #1 //into r5 for r4 by 1 bit
    // this gives us 3.5 which is truncated to 3
    // now for the negative number
    MOV r4, #-7
    ASR r5, r4, #1
    // instead of -3 we will have -4 because when truncation occurs we go
    // to the next lowest value

    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
