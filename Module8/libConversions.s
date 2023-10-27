#
# Program Name: libConversions.s
# Author: Zachary Meisner
# Date: 10/27/2023
# Purpose: Supply conversion equations for other files through link registers
# Functions: inches2Ft, feet2In, miles2kilometers, kph, CToFah
# Inputs: Inputs come from main file, link registers do not accept input
# Outputs: converted number for equation
#

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
    # answer returned in r0

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END feet2In


# In order to multiply by 1.6 we have to first multiply by 16, and then divide by 10
# this is due to the limitations of assembly and floating point numbers
# as assembly does not have the innate programmed ability to assign floating point numbers
# in an easy, consistent, or fully accurate way through computation.
# this is due to the underlying hardware and components required to output each answer.
# Ultimately, multiplication is done this way for the purposes of refining the accuracy of the answer
# in addition to assuring that the correct answer is given due to the overall inaccessability
# of the underlying registers within the system required for computation.
#
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

