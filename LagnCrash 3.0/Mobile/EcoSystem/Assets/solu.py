"""Math --> base64 --> replace --> magic --> b64"""

import base64
cipher = "BW8Ifwk/CX8JXwZfCT8IbwlfC28Hfw1fCF8Kfwk/Bk8JXwRPCT8HTwlfBU8GXwtPDU8ETwxvCm8OXwp/Bl8Gbw5PCn8Dbwd/CV8Kfw1fCT8NTwRPAl8Gbw5fDW8KTwVPDU8FTwZfBm8PTwdPCk8GTw9PB18KTwRPBF8Hbw0/DT8="
cipher = base64.b64decode(cipher)
print(cipher)

cipher = ["{:08b}".format(i) for i in cipher] # converts to binary

decoded1 = []
for i in range(0, len(cipher), 2):
    # cipher[i]: AND operated output
    # cipher[i + 1]: OR operated output
    decoded1.append(cipher[i + 1][:4] + cipher[i][4:]) # take first 4 from OR, last 4 from AND, and combine
print(decoded1)

decoded1 = "".join([chr(int(i, 2)) for i in decoded1]) # convert from binary to string representation
print(decoded1)

decoded1 = decoded1.replace("\x5D", "0").replace("\x5E", "P")
# note \x5D is actually ']' and \x5E is '^' in hex
print(decoded1)

decoded1 = base64.b64decode(decoded1)
print(decoded1)

print(len(decoded1))
decoded2 = ""
for i in decoded1:
    if i >= 80 and i <= 124:
        decoded2 += chr(i - 47)
    elif i >= 31 and i <= 79:
        decoded2 += chr(i + 47)

print(decoded2)