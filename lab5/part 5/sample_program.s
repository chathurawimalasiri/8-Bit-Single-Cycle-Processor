loadi 4 0x05
loadi 5 0x05
loadi 6 0x03
j 0x01
loadi 2 0x09
add 6 4 2
mov 0 6
beq 0x02 4 6
bne 0xFE 4 5
loadi 1 0x01
add 3 1 1
sra 2 5 0x01
sll 3 5 0x01
srl 2 5 0x01
sra 3 5 0x01
ror 2 5 0x01