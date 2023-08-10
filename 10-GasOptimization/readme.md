# Homework 10
## Optimisation 2

1. Why are negative numbers more expensive to store than positive numbers ?

A: Negative numbers are more expensive to store than positive numbers in EVM because they require an extra bit to store the sign. This is because the EVM uses two's complement representation for negative numbers, where the most significant bit is used to indicate the sign (0 for positive, 1 for negative). This means that a uint256, which can store up to 256 bits of data, can only store 255 bits of data for negative numbers. 

In addition, negative numbers require more operations to be performed on them. For example, to add two negative numbers, the EVM must first convert them to their two's complement representations, then add the two representations, and then convert the result back to a signed integer. This is more expensive than simply adding two positive integers.

2. Test the following statements in Remix, which is cheaper and why ?
Assume that the denominator can never be zero.

```
result = numerator / demoninator;
```

```
assembly {
result := div(numerator, demoninator)
}
```

A: The assmebly code is more cheaper. The assembly division algorithm is based on the [Booth's algorithm](), which is a much faster algorithm.

Tests logs

```
| src/Div.sol:Div contract |                 |     |        |     |         |
|--------------------------|-----------------|-----|--------|-----|---------|
| Deployment Cost          | Deployment Size |     |        |     |         |
| 48299                    | 272             |     |        |     |         |
| Function Name            | min             | avg | median | max | # calls |
| divAssembly              | 288             | 288 | 288    | 288 | 1       |
| divSolidity              | 342             | 342 | 342    | 342 | 1       |
```

See [Div](./src/Div.sol)