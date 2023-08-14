# Homework 12

## Solidity / Yul bitwise

1 - What are the potential dangers when performing the following bitwise operations:

a. Left shift
b. Right shift

A: Left shift can cause overflow errors and data loss, if the leftmost bit is shifted out. Right shift can cause underflow errors and loss of precision, as bits shifted out are discarded.

2 - Bit Operations

- Imagine you have a uint256 variable in storage named x
- check if x starts with de or be
- if x starts with 0xde multiply x by 4
- if x starts with 0xbe divide x by 4

Write the code in: 

a) [Solidity]()
b) [Yul]()

Which one is most gas efficient ?

A: Yul is more gas efficient.