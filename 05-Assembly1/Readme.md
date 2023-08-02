### Homework 5

1. Look at the example of init code in today's notes

See [gist](https://gist.github.com/extropyCoder/4243c0f90e6a6e97006a31f5b9265b94)

When we do the CODECOPY operation, what are we overwriting ? (debugging this in Remix might help here)

A: The CODECOPY operation is executed after the constructor execution and copies the code of the running contract to memory.

Memory before the CODECOPY:

```
{
	"0x0": "0000000000000000000000000000000000000000000000000000000000000000\t????????????????????????????????",
	"0x20": "0000000000000000000000000000000000000000000000000000000000000000\t????????????????????????????????",
	"0x40": "0000000000000000000000000000000000000000000000000000000000000080\t????????????????????????????????"
}
```

Memory after the CODECOPY:

```
{
	"0x0": "6080604052348015600f57600080fd5b506004361060285760003560e01c8063\t????R4????W?????P??6???W??5????c",
	"0x20": "57de26a414602d575b600080fd5b60336047565b604051603e9190605d565b60\tW??????W???????3?GV???Q??????V??",
	"0x40": "405180910390f35b60008054905090565b6057816076565b82525050565b6000\t?Q?????????T?P?V??W??vV??RPPV???",
	"0x60": "602082019050607060008301846050565b92915050565b600081905091905056\t? ???P?p??????PV???PPV?????P??PV",
	"0x80": "fea2646970667358221220dc291e6cac0af81a378212175534640bf290cb6a45\t??dipfsX?? ???l?\n??7???U4d\u000b???jE",
	"0xa0": "d72bcae2333675e243350364736f6c6343000806003300000000000000000000\t????36u?C5?dsolcC????3??????????"
}
```

2. Could the answer to Q1 allow an optimisation ?

A: I tested to use an initializer to set value and the Memory after the CODECOPY has one more item using slot `0xc0`: 

```
{
	[...]

	"0xc0": "35805161031764736f6c63430008060033000000000000000000000000000000\t5?Qa??dsolcC????3???????????????"
}
```

I dont think its posible to optimize the CODECOPY operation, bucause we will store the code of the running contract to memory 

(Review)

3. Can you trigger a revert in the init code in Remix ?

A: Yes, ths tx is reverted and the contract is not deployed.

Example tested:

```
  constructor(uint256 val){
    if (val < 10) {
      revert();
    }
    value1 = val;
}
```

4. Write some Yul to:

- Add 0x07 to 0x08
- store the result at the next free memory location.
- (optional) write this again in opcodes

Yul:

```
// Define a data section to store the constants
data {
    x_slot: slot // Define a slot to store the result
}

// Main function
function main() -> result {
    // Assign the constants to variables
    let x := 0x07
    let y := 0x08
    
    // Add the values
    let sum := add(x, y)
    
    // Store the result in the designated memory slot
    mstore(x_slot, sum)
    
    // Return the result for reference
    result := sum
}

```

Opcodes:

```
// EVM bytecode to add 0x07 to 0x08 and store the result at memory slot 0x20

// Push the constant 0x07 onto the stack
PUSH1 0x07

// Push the constant 0x08 onto the stack
PUSH1 0x08

// Add the top two stack elements (0x07 + 0x08)
ADD

// Store the result at memory slot 0x20
PUSH1 0x20
MSTORE

// The result is now on the top of the stack (in case you want to use it later)

// Return (optional)
STOP
```

5. Can you think of a situation where the opcode EXTCODECOPY is used ?

A: It is used to check and compare a contract's bytecode, similar to comparing a known hash of a download file to confirm its legitimacy. 

For example, a contract may want to check if another contract's bytecode is one of a set of permitted implementations, or it may perform analyses on code and whitelist any contract with matching bytecode if the analysis passes. 

See [EIP-1052](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1052.md)

Reference [here](https://ethereum.stackexchange.com/a/59824/58444)

An unconventional of EXTCODECOPY is to use a deployed contract as the "storage" of another contract, as is is done by this library: https://github.com/0xsequence/sstore2

6. Complete the assembly exercises in this [repo](https://github.com/ExtropyIO/ExpertSolidityBootcamp/tree/main/exercises/assembly)

See completed assembly exercises in `./src`

See [diving-into-the-ethereum-vm-part-2-storage-layout](https://medium.com/@hayeah/diving-into-the-ethereum-vm-part-2-storage-layout-bc5349cb11b7)