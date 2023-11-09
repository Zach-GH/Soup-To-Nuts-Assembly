#
# Program Name: libFunctions.s
# Author: Zachary Meisner
# Date: 11/08/2023
# Purpose: A file with the sole purpose of supplying a back end of functions for general use.
# Functions: checkNegative
# Inputs: user input from other files
# Outputs: corresponding value or a failure code (0 unless determined otherwise)
#
# Basic Function Template
# .global functionName
# .text
# functionName:
# stack
#
# function code
#
# stack
# END functionName
#

# This function is used to check the initial input for a selected max value.
# Against a second user input, to assure that it is not higher than the max value,
# in addition to assuring that the value is not negative.
# To determine this, we take the entered number, and subtract the max value.
# If the function is negative, the input verification for the input fails
# and the function spits out a 0, for negative, where-as it would return
# the actual value if the input passes.
#
.global checkNegative
.text
checkNegative:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    // move the inputs to temporary registers for safe input verification
    MOV r4, r0 // r0 is user input
    MOV r6, r1 // r1 is max value

    SUB r0, r6, r4 // move (userInput - maxValue) into r0 and return

    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr
#END checkNegative
