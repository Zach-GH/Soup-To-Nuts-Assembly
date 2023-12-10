Assembly to machine code
---
1. `mov r1, r2` = `e1a01002`
2. `sub r8, r6, r3` = `e0468003`
3. `mul r3, r4, r5` = `e0030594`
4. `lsr r1, r2, r3` = `e1a01332`
5. `ldr r2, [r0, #4]` = `e5902004`

Machine code to assembly
---
6. `e3a03007` = `mov r3, #7`
7. `e2837005` = `add r7, r3, #5`
8. `e0030594` = `mul r3, r4, r5`
9. `e1a01332` = `lsr r1, r2, r3`
10. `e7902002` = `ldr r2, [r0, r2]`
