.global inches2Ft
.text

inches2Ft:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r3, #10
    MUL r0, r0, r3
    MOV r1, #12
    bl __aeabi_idiv
    # answer returned in r0

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END inches2Ft


.global feet2In
.text
feet2In:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r3, #12
    MUL r0, r0, r3
    //MOV r3, #10 // for scaling purposes
    //MUL r0, r0, r3
    # answer returned in r0

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END feet2In


# add comment as to why we multiply by 16 and divide by 10
# The constraints of the assembly programming language we are using
# in addition to the accuracy provided 
.global miles2kilometers
.text
miles2kilometers:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r3, #16
    MUL r0, r0, r3
    MOV r1, #10
    bl __aeabi_idiv

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END miles2kilometers


.global kph
.text
kph:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r4, r1
    BL miles2kilometers

    MOV r1, r4
    bl __aeabi_idiv

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END kph

.global CToFah
.text
CToFah:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    MOV r1, #5
    MOV r6, #9

    MUL r0, r0, r6 // input * 9
    BL __aeabi_idiv // divide by 5
    ADD r0, #32 // add 32
    MOV r6, #10
    MUL r0, r0, r6 // multiply by 10 for scaling output
 
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END CToFah

