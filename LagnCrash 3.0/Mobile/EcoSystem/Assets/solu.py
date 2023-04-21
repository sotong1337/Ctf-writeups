""".global _magic             // Allow other files to call this routine
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
    RET                     // Return to caller"""

"""IOS Root view --> SuperSecureEncryptionMechanismIOS()
--> magic --> base64enc --> encrypt --> math"""

"""Math --> base64 --> replace --> magic --> b64"""

import base64
cipher = "BW8Ifwk/CX8JXwZfCT8IbwlfC28Hfw1fCF8Kfwk/Bk8JXwRPCT8HTwlfBU8GXwtPDU8ETwxvCm8OXwp/Bl8Gbw5PCn8Dbwd/CV8Kfw1fCT8NTwRPAl8Gbw5fDW8KTwVPDU8FTwZfBm8PTwdPCk8GTw9PB18KTwRPBF8Hbw0/DT8="
cipher = base64.b64decode(cipher)
cipher = ["{:08b}".format(i) for i in cipher]

decoded1 = []
for i in range(0, len(cipher), 2):
    decoded1.append(cipher[i + 1][:4] + cipher[i][4:])
print(decoded1)
decoded1 = "".join([chr(int(i, 2)) for i in decoded1])
decoded1 = decoded1.replace("]", "0").replace("^", "P")
print(decoded1)
decoded1 = base64.b64decode(decoded1)
print(decoded1)

print(len(decoded1))
decoded2 = ""
for i in decoded1:
    if i > 78:
        decoded2 += chr(i - 47)
    else:
        decoded2 += chr(i + 47)

print(decoded2)