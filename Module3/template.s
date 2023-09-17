    #
    # Program Name: template.s
    # Author: Zachary Meisner
    # Date: 9/17/2023
    # Purpose: This program is a template that can be used to start an
    # ARM assembly program using gcc
    #
    
    .text
    .global main

    main:
      # Save return to OS on stack
      SUB sp, sp, #4
      STR lr, [sp, #0]

      # Enter your program here.

      # Return to the OS
      LDR lr, [sp, #0]
      ADD sp, sp, #4
      MOV pc, lr
    
    .data
