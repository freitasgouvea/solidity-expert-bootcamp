## Ethereum Data Structures

Ethereum uses Merkle Patricia Tries / Radix Tries for their searching performance and low memory footprint.

Trie, it is also called Radix Trie, Patricia Trie, or Prefix Tree, is a data structure which is fastest at finding common prefixes, simple to implement, and requires small memory. As Ethereum uses Merkle Tree to efficiently store the hash in blocks, Trie is used as a core data structure of data storage. Ethereum uses “Modified Merkel Patricia Trie” which is invented with Merkle Tree, Patricia Tree(Trie), and some improvements. Modified Merkle Patricia Trie is used as the main data structure in Ethereum tries receipt trie, world state trie, account storage trie, and transaction trie.

Also see: [Verkle trees](https://vitalik.ca/general/2021/06/18/verkle.html)

## Ethereum State

There are three main state tries STORED IN THE BLOCK: 

1. world state trie, 
2. transaction trie, and 
3. receipt trie

And, account storage trie(account storage contents trie) construct leaf node in world state trie.

[Ethereum State Trie Architecture Explained]()https://medium.com/@eiki1212/ethereum-state-trie-architecture-explained-a30237009d4e

### 1. World State

World state trie is a mapping between addresses and account states. It can be seen as a global state that is constantly updated by transaction executions. The Ethereum network is a decentralized computer and state trie is considered hard drive. 

All the information about accounts are stored in world state trie and you can retrieve information by querying it. World state trie is closely related to account storage trie because it has “storageRoot” field that points the root node in account storage trie.

#### Account Storage

Account Storage Trie is where data associated with an account is stored. This is only relevant for Contract Account and all smart contract data is persisted in the account storage trie as a mapping between 32-bytes integers.

And, account state stores information about accounts such as how much the account has and how many transactions were sent from the account. It has four fields: nonce, balance, storageRoot, and codeHash. It is a leaf node in world state trie.

### 2. Transaction

Transaction trie records transactions in Ethereum. Transaction plays a core role to change states, as Ethereum is transaction-based “state” machine. Once the transaction is recorded in a block, it cannot be changed permanently as to prove the balance of accounts(world state). 

As Transaction Trie is constructed with Modified Merkel Patricia Trie, the only root node is stored in the block. Below gray box describes the transaction data field.

- `nonce`: Transaction nonce is a sequence number of transactions sent from a given address.
- `Gas Price`: price you are offering to pay
- `Gas Limit`: Gas Limit is a limit of the amount of ETH the sender is willing to pay for the transaction
- `Recipient`: The recipient is the destination of Ethereum address.
- `Value`: The value field represents the amount of ether/wei from the sender to the recipient.
- `Data`: Data field is for contract related activities such as deployment or execution of a contract.
- `v,r,s`: This field is components of an ECDSA digital signature of the originating EOA.


See [Ethereum Transaction Structure Explained](https://medium.com/@eiki1212/ethereum-transaction-structure-explained-aa5a94182ad6)

3. Transaction Receipt

Transaction Receipt Trie records receipts(outcome) of transactions. The receipt is a result of the transaction which is executed successfully. The receipt includes a hash of transaction, block number, amount of gas used, and address of contract, etc.

- `blockHash`: String, 32 Bytes - hash of the block where this transaction was in.
- `blockNumber`: Number - block number where this transaction was in.
- `transactionHash`: String, 32 Bytes - hash of the transaction.
- `transactionIndex`: Number - integer of the transactions index position in the block.
- `from`: String, 20 Bytes - address of the sender.
- `to`: String, 20 Bytes - address of the receiver. null when its a contract creation transaction.
- `cumulativeGasUsed`: Number - The total amount of gas used when this transaction was executed in the block.
- `gasUsed`: Number - The amount of gas used by this specific transaction alone.
- `contractAddress`: String - 20 Bytes - The contract address created, if the transaction was a contract creation, otherwise null.
- `logs`: Array - Array of log objects, which this transaction generated.
- `status` : String - '0x0' indicates transaction failure , '0x1' indicates transaction succeeded.

## Etehereum block fields

see [BLOCKS](https://ethereum.org/en/developers/docs/blocks/)

### Some practical points about transaction selection

- Miners choose which transactions to include in a block
- Miners can add their own transactions to a block
- Miners choose the order of transactions in a block
- Your transaction is in competition with other transactions for inclusion in the block

### Transaction Processing

- Before the transaction executes it needs to pass some validity tests
- The transaction follows the rules for well-formed RLP (recursive length prefix.)
- The signature on the transaction is valid.
- The nonce on the transaction is valid, i.e. it is equivalent to the sender accountʼs current nonce.
- The gas_limit is greater than or equal to the intrinsic_gas used by the transaction.
- The senderʼs account balance contains the cost required in up-front payment.

See [RLP](https://ethereum.org/en/developers/docs/data-structures-and-encoding/rlp/)

## EVM

The EVM is a STACK MACHINE, the stack has a maximum size of 1024 (push and pop).

Each stack have a size of 256 bits, is a 256-bit word machine,  easy to use Keccak256 hash scheme and elliptic-curve computations

During execution 2 areas are available for variables:

- `memory` (VOLATILE) : - a transient memory which does not persist between transactions

- `storage` (PERMANENT) : - part of a Merkle Patricia storage trie associated with the contractʼs account, part of the global state

gas counter: increase each opcode is executed

### Data aeras

- stack
- calldata
- memory
- storage
- code
- logs

If you need only store data it is better use bytecode because is cheaper and you dont need smart contract code

Its cheaper to use the events to logs vs contract variables that uses storage

### The Stack

- push: add intems to stack
- pop: remove first item (top) if stack

EVM: 1024 elements can be put on stack ecah one with 256 bits

The top 16 items can be manipulated or accessd at once (or stack too depp error)

### Call Stack

The "call stack" is the current execution environment of the contract where the EVM is running.

It is an array of addresses of contracts being called, and these addresses are added or removed from the call stack as the CALL opcodes are executed.

### Memory

1. we can load 256-bit at the time
2. we can store 256-bit or 8-bit at the time

Opcodes related to memory:

- `MLOAD`: read/loads a word from memory into the stack.
- `MSTORE`: store/save a word to memory
- `MSTORE8`: store/save a byte to memory

#### Memory expand

When your contract writes to memory, you have to pay for the number of bytes written. 

If you are writing to an area of memory that hasn't been written to before there is an additional memory expansion cost for using it for the first time.

Memory is expanded in 32 bytes (256-bit) increments when writing to previously untouched memory space

#### Free memory pointer

Def: The free memory pointer is simply a pointer to the location where free memory starts. It ensures smart contracts keep track of which memory locations have been written to and which havenʼt.

Goal: This protects against a contract overwriting some memory that has been allocated to another variable.

starts at address 0x80

### Storage

![image](https://github.com/freitasgouvea/solidity-expert-bootcamp/assets/46804396/5b36ca3a-7271-4bdb-8620-12c963a43dc3)

For FIXED SIZE variables, data is stored contiguously item after item starting with the first state variable, which is stored in slot 0. For each variable, a size in bytes is determined according to its type.

For VARIABLE SIZE length items such as arrays and mappings, the storage slot contains a pointer to another area of storage where the variable starts

- mapping: the mapping itself is not allocated but the pointer to where map is stored (same for arrays)

THE ORDER is the same of the contract!!!

For mapping/account storage key value pair both sides have 256-bits. In this case, change the value from `uint256` to `uint8` has no effect for optimization storage.

### Code execution

1. evm code provide instructions to execute the stack
2. the stack is executed according to code instructions
3. and access data from memory or storage

#### opcodes list

- Stack-manipulating opcodes (`POP`, `PUSH`, `DUP`, `SWAP`)
- Arithmetic/comparison/bitwise opcodes (`ADD`, `SUB`, `GT`, `LT`, `AND`, `OR`)
- Environmental opcodes (`CALLER`, `CALLVALUE`, `NUMBER`)
- Memory-manipulating opcodes (`MLOAD`, `MSTORE`, `MSTORE8`, `MSIZE`)
- Storage-manipulating opcodes (`SLOAD`, `SSTORE`)
- Program counter related opcodes (`JUMP`, `JUMPI`, `PC`, `JUMPDEST`)
- Halting opcodes (`STOP`, `RETURN`, `REVERT`, `INVALID`, `SELFDESTRUCT`)

Details [Ethereum Virtual Machine Opcodes](https://www.ethervm.io/)

### Machine state

The machine state is a tuple consisting of five elements: 

1. gas_available
2. program_counter
3. memory_contents A series of zeroes of size 2
256
4. memory_words.count
5. stack_contents

There is also the current operation to be executed

### Gas refunds

see updates introduced in [EIP-3529](https://eips.ethereum.org/EIPS/eip-3529)

## Reference

[EVM Deep Dives](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy?utm_source=%2Fprofile%2F80455042-noxx&utm_medium=reader2)
