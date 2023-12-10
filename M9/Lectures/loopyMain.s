.global main
.text
main:
    SUB sp, sp, #4
    STR lr, [sp]

# Sentinel Loop
# Initialize:
    LDR r0, =prompt
    BL printf
    LDR r0, =format
    LDR r1, =number
    BL scanf

# StartLabel startLoop
    startLoop:
        LDR r1, =number
        LDR r1, [r1]

        CMP r1, #-1
        BEQ endLoop

            # statement or block to execute
            MOV r3, #0
            CMP r1, #0
            ADDGT r3, r3, #1 // r3 will become 1 if greater than 0
            MOV r4, #0
            CMP r1, #100
            ADDLT r4, r4, #1 // if less than 100 set r1
            AND r0, r3, r4

            CMP r0, #1
            BNE elseError
                LDR r0, =output
                BL printf
                B endError // standard and expected

            elseError:
                LDR r0, =error
                BL printf

            endError:

        # GetNext value
        LDR r0, =prompt
        BL printf
        LDR r0, =format
        LDR r1, =number
        BL scanf
        B startLoop

    endLoop:


    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt: .asciz "\nEnter a number, -1 to quit: "
    number: .word 0
    format: .asciz "%d"
    output: .asciz "\nYou entered %d"
    error: .asciz "\nValue must be 0...100"
    ending: .asciz "\nThe program is done"

# END main
