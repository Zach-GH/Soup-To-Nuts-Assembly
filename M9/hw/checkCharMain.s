.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp, #0]

# Sentinel loop
# Initialize
    LDR r0, =prompt
    BL printf
    LDR r0, =format
    LDR r1, =number
    BL scanf

# StartLabel:
    startLoop:
        LDR r1, =number
        LDR r1, [r1]

        CMP r1, #-1
        BEQ endLoop

            BL checkChar

        LDR r0, =prompt
        BL printf
        LDR r0, =format
        LDR r1, =number
        BL scanf

        B startLoop

    endLoop:
        LDR r0, =ByeBye
        BL printf

        LDR lr, [sp, #0]
        ADD sp, sp, #4
        MOV pc, lr

.data
    prompt: .asciz "\nEnter a character, -1 to quit: "
    number: .word 0
    format: .asciz "%d"
    ByeBye: .asciz "\nBye Bye!\n"

# End main

.text
checkChar:
    SUB sp, sp, #8
    STR lr, [sp, #4]

    # Prompt for and read character
    LDR r0, =promptChar
    BL printf
    LDR r0, =formatChar
    LDR r1, =character
    BL scanf

    # Load character into r0
    LDR r0, =character
    LDRB r0, [r0]

    # Check if lowercase letter
    CMP r0, #'a'
    BLT checkUppercase
    CMP r0, #'z'
    BLE lowercaseOutput

checkUppercase:
    CMP r0, #'A'
    BLT ErrorMsg
    CMP r0, #'Z'
    BLE uppercaseOutput
    B ErrorMsg

lowercaseOutput:
    LDR r0, =lowercase
    BL printf
    B EndCharCheck

uppercaseOutput:
    LDR r0, =uppercase
    BL printf
    B EndCharCheck

ErrorMsg:
    LDR r0, =error
    BL printf

EndCharCheck:
    LDR lr, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    promptChar: .asciz ""
    formatChar: .asciz "%c"
    character: .space 1
    error:    .asciz "\nNot a letter\n"
    lowercase: .asciz "\nCharacter is lowercase\n"
    uppercase: .asciz "\nCharacter is uppercase\n"
