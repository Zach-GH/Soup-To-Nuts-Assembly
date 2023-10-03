.text
.global main
main:
    SUB sp, sp, #4
    STR lr, [sp]



    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.data
