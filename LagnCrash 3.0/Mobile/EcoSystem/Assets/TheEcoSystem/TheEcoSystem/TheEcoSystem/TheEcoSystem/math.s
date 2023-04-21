//
//  math.s
//  The EcoSystem
//
//  Created by Carl Ian Voller on 5/10/22.
//

.global _math              // Allow other files to call this routine
.align 4

_math: MOV    X4, X1

loop:
    LDRB    W5, [X0], #1

    CMP     W5, #'!'
    B.LT    cont

    CMP     W5, #'~'
    B.GT    cont

    CMP     W5, #78
    B.LT    smaller
    B.GE    bigger

    B       cont

smaller:
    ADD     W6, W5, #47
    MOV     W5, W6
    B       cont

bigger:
    SUB     W6, W5, #47
    MOV     W5, W6
    B       cont
    
cont:
    STRB    W5, [X1], #1    // store character to output str
    CMP     W5, #0          // stop on hitting a null character
    B.NE    loop            // loop if character isn't null
    SUB     X0, X1, X4      // get the length by subtracting the pointers
    RET                     // Return to caller
