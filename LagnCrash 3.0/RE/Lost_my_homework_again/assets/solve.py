import base64
v1_out = "48 39 27 36 45 69 36 78 45 30 78 81 66 69 48 75 63 69 42 78 51 27 42 81 66 81 48 72 54 69 75 27 51 81 42 81 51 30 45 81 51 27 45 81 45 39 75 30".split(" ")
v2_out = "0 1 1 0 1 2 1 1 1 3 3 3 3 1 1 0 2 1 2 3 0 2 2 2 3 2 2 0 1 1 0 1 0 2 2 2 0 3 1 3 0 2 1 3 1 1 0 1".split(" ")

v1_out = [int(i) for i in v1_out]
v2_out = [int(i) for i in v2_out]

def v1(num):
	
    num -= 20
    remainder = num % 4
    quotient = num // 4
    num = remainder + quotient
    return num * 3

def v2(num):

    num -= 20
    remainder = num % 4
    return remainder

def re(v1_out, v2_out):
    x = []

    for i in range(len(v1_out)):
        remainder = v2_out[i]
        quotient = v1_out[i] / 3 - remainder
        num = quotient * 4 + remainder + 20
        x.append(int(num))

    return x

key = re(v1_out, v2_out)
plaintext = "".join([chr(i) for i in key])
print(plaintext)
#TE5DMjAyM3swcmQxbmFsX2FzczNtYmx5XzFzX3MwX2MwMEx9
print(base64.b64decode(plaintext).decode('utf-8'))
#LNC2023{0rd1nal_ass3mbly_1s_s0_c00L}