# Solidity

## Uint

`uint` defines an unsigned integer of 256 bits by default. You can also specify the number of bits, by range of 8 bits. 

Here are some examples below:

- uint8 = 0 to 255
- uint16 = 0 to 65,535
- uint32 = 0 to 4,294,967,295
- uint64 = 0 to 18,446,744,073,709,551,615
- uint128 = 0 to 2^128
- uint256 = 0 to 2^256

## Getter and Setter

### Getter

Definiton : In Solidity, a getter is a function that returns a value.

To return a value from a function (here our score ), you use the following keywords:

- In the function definition: returns + variable type returned between parentheses for example ( uint )
- In the function body: return followed by what you want to return for example return score; or return 137;

### Setter

Definition : In Solidity, a setter is a function that modifies the value of a variable (modifies the state of the contract). To creates a setter, you must specify the parameters when you declare your function. 

After your function name, specifies between parentheses 1) the variable type( `uint` ) and 2) the variable name ( `new_score` )

## Function visibility

There are four types of visibility for functions in Solidity : `public` (all) , `private` (only contract itself) , `external` (only external contracts and addresses) and `internal` (contract itself and derived contracts).

### View vc pure

- `view` functions can only read from the contract storage. They canʼt modify the contract storage. Usually, you will use view for getters. (CAN READ THE STATE)

- `pure` functions can neither read nor modify the contract storage. They are only used for computation (like mathematical operations). (CAN NOT READ THE STATE)

## Add Security with Modifiers

Special function that enables us to change the behaviour of function in Solidity. It is mostly used to atumoatically check a condition before execution.

- `msg.sender`
- `msg.value`

We should have a feature that enables only certain addresses to change the score (your address). To achieve this, we will introduce the notion of modifiers.

### Modifiers

Definition : A `modifier` is a special function that enables us to change the behaviour of functions in Solidity. It is mostly used to automatically check a condition before executing a function.

The modifier works with the following flow:

1. Check that the address of the caller ( msg.sender ) is equal to owner address.
2. If condition is true, it passes the check. The _; will be replaced by the function
body where the modifier is attached.

A modifier CAN RECEIVE ARGUMENTS like functions. 

## Constructor

Definition : A `constructor` is a function that is executed only once when the contract is deployed on the Ethereum blockchain.

Constructors are OPTIONAL. If there is no constructor, the contract will assume the default constructor, which is equivalent to `constructor () {}`

In upgradeblabe contract we use initializer function to start the lifecycle of contract

## Event

Events are only used in Web3 to output some return values. They are a way to show the changes made into a contract. 

Events act like a LOG statement.

Monitoring events is good to detect a contract atacks.

Only visible outside the contract, stored in the transaction logs not in EVM.

You can also use the keyword `indexed` (3 times) in front of the parameterʼs types in the event definition. It will create an index that will enable to search for events via Web3 in your front-end.

## Mapping

Mappings are another important complex data type used in Solidity. They are useful for association, such as associating an address with a balance or a score. 

You can access the value associated with a key in a mapping by specifing the key name inside square brackets [] as follows: `mapping_name[key]` 

You can use the keyword public in front of a mapping name to create automatically a getter function in Solidity, as follows: `mapping(address => uint) public score_list;`

In Solidity, mappings do not have a length, and there is no concept of a value associated with a key.

Mappings are virtually initialized in Solidity, such that every possible key exists and is mapped to a value which is the default value for that datatype.

## Arrays

Two types of array.

- Fixed size array : Type[n]
- Dynamic size array : Type[]

## Struct

We can build our own DATATYPE by combining simpler datatypes together into more complex types using structs.

## Inheritence

In object-oriented programming, inheritance is the mechanism of basing an object or class upon another object or class.

An object created through inheritance, a "child object", acquires some or all of the properties and behaviors of the "parent object

Use the keyword `is` in child contract

## Byte Array

Can be fixed size or dynamic:

- For fixed size : `bytes1`, `bytes2`, `bytes3`, …, `bytes32` are available
- For dynamic arrays use : `bytes`

### bytes.concat function

A recent change (0.8.4).You can concatenate a variable number of bytes or bytes1 ... bytes32 using `bytes.concat`. The function returns a single bytes memory array.

## String

You can compare two strings by their `keccak256` hash using `keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2))` and concatenate two strings using `string.concat(s1, s2)`.

## Enums

The keyword `enum` can be used to create a user defined enumerations, similar to other languages.

## Storage, memory and calldata

### Storage

Storage data is PERMANENT, forms part of the smart contract's state and can be ACCESSED ACROSS ALL FUNCTIONS. 

Storage data location is expensive and should be used only if necessary. 

The `storage` keyword is used to define a variable that can be found in storage location.

### Memory

Memory data is stored in a TEMPORARY location and is only ACCESSIBLE WITHIN A FUNCTION. 

Memory data is normally used to store data temporarily whilst executing logic within a function. When the execution is completed,the data is discarded. 

The `memory` keyword is used to define a variable that is stored in memory location.

Memory variables CAN BE CHANGED.

### Calldata

Calldata is the location where external values from outside a function into a function are stored. 

It is a non-modifiable and non-persistent data location. 

The `calldata` keyword is required to define a VARIABLE stored in the calldata location.

Calldata variables CAN NOT BE CHANGED.

#### Memory vc Calldata

```js
pragma solidity ^0.8.0;

contract Test {

  function memoryTest(string memory _exampleString)
  public pure
  returns (string memory) {
    _exampleString = "example"; // You can modify memory
    string memory newString = _exampleString;
    // You can use memory within a function's logic
    return newString; // You can return memory
  }
  function calldataTest(string calldata _exampleString)
  external
  pure returns (string calldata) {
    // cannot modify _exampleString
    // but can return it
    return _exampleString;
  }
}
```

## Constant and Immutable variables

`constant` keyword

it can be assigned at construction time or hardcoded

Examples:

```
// define a constant a file level
uint256 constant X = 32**22 + 8;

contract C {
  string constant TEXT = "abc";
  bytes32 constant MY_HASH = keccak256("abc");
  uint256 immutable decimals;
  uint256 immutable maxBalance;
  address immutable owner = msg.sender;
  
  constructor(uint256 _decimals, address _reference) {
    decimals = _decimals;
    // Assignments to immutables can even access the environment.
    maxBalance = _reference.balance;
  }

}
```

## Interfaces

The `interface` specifies funciton signatures but the implementation is specified in child contract.

Example:

```
interface DataFeed {
  function getData(address token) external returns (uint value);
}
```

## Fallback and Recieve function

`receive() external payable { ... }`: Called when contract recieves ether

`fallback () external [payable]`: Called if a funciton cannot found matching the required funciton sgnature. It also handles the case when ether is received but there is no receive function.

## Checking inputs and dealing with errors

### Require

The `require` function either creates an error without any data or an error of type Error(string).

It should be used to ensure valid conditions that cannot be detected until execution time. This includes conditions on inputs or return values from calls to external contracts."

Example:

```
require(_amount > 0,"Amount must be > 0");
```

### Assert 

The `assert` function creates an error of type Panic(uint256).

Assert should only be used to TEST FOR INTERNAL ERRORS, and to check invariants. 

Properly functioning code should never create a Panic, not even on invalid external input.

Example:

```
assert(a>b);
```

### Revert

The revert statement acts like a throw statement in other languages and causes the EVM to revert.

The require statement is ofen used in its place.

It can take a string as an error message, or a Error object.

Example:

```
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract VendingMachine {
  address owner;
  error Unauthorized();

  function buy(uint amount) public payable {
    if (amount > msg.value / 2 ether)
      revert("Not enough Ether provided.");

    // Alternative way to do it:
    require(
      amount <= msg.value / 2 ether,
      "Not enough Ether provided."
    );

    // Perform the purchase.
  }

  function withdraw() public {
    if (msg.sender != owner)
      revert Unauthorized();

    payable(msg.sender).transfer(address(this).balance);
  }
}
```

### Try Catch

`try / catch` statements can be used to catch errors in calls to external contracts.

Example:

```
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.1;

interface DataFeed {
    function getData(address token) external returns (uint value);
}

contract FeedConsumer {
    DataFeed feed;
    uint errorCount;

    function rate(address token) public returns (uint value, bool success) {
        // Permanently disable the mechanism if there are
        // more than 10 errors.
        require(errorCount < 10);
        try feed.getData(token) returns (uint v) {
        return (v, true);
        } catch Error(string memory /*reason*/) {
        // This is executed in case
        // revert was called inside getData
        // and a reason string was provided.
        errorCount++;
        return (0, false);
        } catch Panic(uint /*errorCode*/) {
        // This is executed in case of a panic,
        // i.e. a serious error like division by zero
        // or overflow. The error code can be used
        // to determine the kind of error.
        errorCount++;
        return (0, false);
        } catch (bytes memory /*lowLevelData*/) {
        // This is executed in case revert() was used.
        errorCount++;
        return (0, false);
        }
    }
}

```

### Custom errors

A recent addition to the language is the `error` TYPE allowing custom errors.

These are more gas efficient and readable.

We can define a error with the error keyword, either in a contract or at file level, and then use it as part of the revert statement as follows.

Example: 

```
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/// Not enough funds for transfer. Requested `requested`,
/// but only `available` available.
error NotEnoughFunds(uint requested, uint available);

contract Token {
    mapping(address => uint) balances;

    function transfer(address to, uint amount) public {
        uint balance = balances[msg.sender];
        if (balance < amount)
        revert NotEnoughFunds(amount, balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        // ...
    }
}
```

Errors cannot be overloaded or overridden but are inherited.

Instances of errors can only be created using `revert` statements.

## Using other contracts and libraries

- `import` statement to make the code available in your compilatiopn file, same than copy the code.

- `using` keyword

- libraries do not have a state, instead their functions run in the context of your contract

See Deployed Libraries vs Pre-complied contracts

## Delete data from a contract

### 1. Simple types.

You can use `delete myVariable;` or `myVariable = 0;`

### 2. Arrays

You can use `delete myArray;` , this will either set the length to zero for a dynamic array, or set each item to zero for a static array.

### 3. Structs

You can delete an instance with `delete myStructInstance;` , unless the struct contains a mapping

### 4. Mappings within structs
You need to delete the individual key value pairs. `delete (myMapping[key])`

## Function Selectors

The first four bytes of the call data specifies the function to be called:

```
method_id = first 4 bytes of msg.data
```

The compiler create something like:

```
if method_id == 0x25d8dcf2 jump to 0x11
if method_id == 0xaabbccdd jump to 0x22
if method_id == 0xffaaccee jump to 0x33
other code
0x11:
code for function with method id 0x25d8dcf2
0x22:
code for another function...
0x33:
code for another function...
```

## Further Solidity Types

### User Defined Types

See [docs](https://docs.soliditylang.org/en/latest/types.html#user-defined-value-types)

### Function Types

- To understand this concept more easy image its a type that can recieves anything, including some object or function, in this case. Like in python when we pass a function as an object or an argument to another function. And the function that recieves this argument can use another parameterized function.

- Doing this we can have a generic function that can execute another function.

- `external`: if the function is external we need to know the address of contract and function signature

See [docs](https://docs.soliditylang.org/en/latest/types.html#function-types)

#### Function type conversions

We can do it if: 

1) identical parameters types and order
2) identical return types and order
3) same visibility
4) same state mutability (pure, view payable);

## Recent changes

- event selector
- assembly memory safe
- five level library references
- extend comparison operators
- abi.encodeCall
- external function fields
- enum min/max comparasion
- user defined value type
- override
- block.basefee

- deprecation of block.difficult
- add block.prevrandao
- deprecated selfdestruct
- named parameters in mappings

- allow qualifield access ro events from other contracts
- relax restrictions on initialization of immutable variables