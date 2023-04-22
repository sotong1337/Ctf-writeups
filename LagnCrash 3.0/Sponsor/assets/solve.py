from pwn import *

for i in range(1, 5):
    io = remote('nc.lagncra.sh', 8013)

    io.recvuntil(b'Mentoring')
    io.sendline(b"2")

    io.recvuntil(b'(YYYY)')
    io.sendline(b"2018")

    io.recvuntil(b'CISSP')
    io.sendline(bytes(str(i), 'ascii'))

    print(i, end = ": ")
    print(io.recvall(timeout=0.5))

    io.close()