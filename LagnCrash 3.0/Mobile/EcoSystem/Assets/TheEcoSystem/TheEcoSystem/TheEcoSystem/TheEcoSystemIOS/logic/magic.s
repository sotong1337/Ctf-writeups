//
//  magic.s
//  TheEcoSystemIOS
//
//  Created by Carl Ian Voller on 7/10/22.
//  Copyright © 2022 Apple. All rights reserved.
//

.global _magic             // Allow other files to call this routine
.align 4

_magic: MOV    X4, X1

loop:
    LDRB    W5, [X0], #1

    MOV     W6, #240
    LSR     W6, W6, 4

    AND     W4, W5, W6
    ORR     W3, W5, W6
    
cont:
    STRB    W4, [X1], #1    // store character to output str
    STRB    W3, [X1], #1    // store character to output str
    CMP     W5, #0x00       // stop on hitting a null character
    B.NE    loop            // loop if character isn't null
    SUB     X0, X1, X4      // get the length by subtracting the pointers
    RET                     // Return to caller
