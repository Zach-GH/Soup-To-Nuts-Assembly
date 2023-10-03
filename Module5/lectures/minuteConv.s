.text
.global main
main:
    # Push and pop the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # Read value from the user
    LDR r0, =prompt // load into r0 address of string
    BL printf // print out prompt
    // scan value in
    // format of scan needs to be in r0
    LDR r0, =formatString
    // need address of where we are going to store the value
    LDR r1, =totalMinutes
    BL scanf // now we can read the value in

    LDR r0, =totalMinutes // need the address of totalMinutes into r0
    LDR r0, [r0] // move the value into r0
    MOV r1, #60 // need value to divide by
    BL __aeabi_idiv
    MOV r4, r0 // move number of hours into r4

    // now we need the number of minutes
    // multiply r4 by 60 for value of minutes
    MOV r1, #60 // move 60 into r1
    MOV r0, r4 // move value of hours into r0
    MUL r0, r1, r4 // multiply and store in r0

    // subtract total number of minutes by totalMinutes
    // move into r1 totalMinutes
    LDR r1, =totalMinutes
    LDR r1, [r1] // need the value not the address
    SUB r1, r1, r0 // subtract r0 into r1 remaining minutes after all hours accounted for

    // r4 is total hours r1 is total minutes
    MOV r2, r1 // move r1 into r2
    MOV r1, r4 // move r4 into r1 // always do this with r1 and r2 to save and print output
    LDR r0, =output // load address of string into r0 to work with r1 and r2
    BL printf // branch and link and printf to print result

    # Restore link register
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    output: .asciz "\nHours is %d and minutes is %d\n"
    prompt: .asciz "Enter total minutes: "
    totalMinutes: .word 0 // word 32 bits 0 is what is stored
    formatString: .asciz "%d" // read as integer so use %d
