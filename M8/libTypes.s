#
# Program Name: libTypes.s
# Author: Zachary Meisner
# Date: 10/27/2023
# Purpose: To introduce scaled integer printing for floating point answer output.
# Functions: printScaledInt
# Inputs: All input comes from the main file as linked register functions cannot intake input
# Ouputs: A Floating point number
#

.global printScaledInt
.text

printScaledInt:
    # push
    SUB sp, #4
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    MOV r4, r0
    MOV r5, r1

    # get whole part and save in r7
    bl __aeabi_idiv // r0/r1, result in r0
    MOV r6, r0
    # get decimal part and save in r7
    MUL r7, r5, r6
    SUB r7, r4, r7

    # print the whole part
    LDR r0, = __PSI_format
    MOV r1, r6
    bl printf
    # print the dot
    LDR r0, = __PSI_dot
    bl printf
    # print the decimal part
    LDR r0, = __PSI_format
    MOV r1, r7
    bl printf

    # pop and return
    LDR lr, [sp, #0]
    ADD sp, #4
    MOV pc, lr

.data
    # Prints the whole part of the floating point number
    __PSI_format: .asciz "%d"
    # Prints the dot in the decimal part of the number
    __PSI_dot: .asciz "."
#END printScaledInt

