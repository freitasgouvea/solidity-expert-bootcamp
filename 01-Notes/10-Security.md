# Security

The development and deployment of smart contracts is a stressful process and it is easy to make mistakes. 

The best way to avoid mistakes is to follow a set of best practices, use tools that help you avoid mistakes, and have your code audited by experts.

Keep in mind that the blockchain is a hostile environment, and that attackers will try to exploit any vulnerability they can find.

Assume that:

- Hackers will try to atack your contract
- Users will use your contract in unexpected ways
- Your contract may have bugs and flaws that you did not find during testing
or audits (even if you are a good programmer)
- Be prepared for the worst case scenario

With this in mind, you should take every precaution in the design, development, and deployment of your contracts.

## Best Practices

Reference:

- [Consensys Best Practices](https://consensys.github.io/smart-contract-best-practices/)

- [The Smart Contract Security Field Guide](https://scsfg.io/developers/)

### Prepare for Failure

Any non-trivial contract will have errors in it. Your code must, therefore, be able to respond to bugs and vulnerabilities gracefully.

- Pause the contract when things are going wrong ('circuit breaker')
- Manage the amount of money at risk (rate limiting, maximum usage)
- Have an effective upgrade path for bugfixes and improvements

Also, you should have a plan for what to do if the contract is hacked, including how to negotiate with the hacker, how to recover funds, and how to communicate with users.

### Stay up to Date

Keep track of new security developments.

- Check your contracts for any new bug as soon as it is discovered
- Upgrade to the latest version of any tool or library as soon as possible
- Adopt new security techniques that appear useful
- Stay informed about attacks and vulnerabilities
- When new versions of Solidity are released, check your contracts for any new bug as soon as it is discovered

Places to look for new developments:

- [Ethereum Foundation Blog](https://blog.ethereum.org/)
- [Wrecked News](https://wrecked.news/)

### Keep it Simple

Complexity is the enemy of security. The more complex a system is, the more likely it is to have bugs.

- Ensure the contract logic is simple
- Modularize code to keep contracts and functions small
- Use already-written tools or code where possible (eg. don't roll your own random number generator)
- Prefer clarity to performance whenever possible
- Only use the blockchain for the parts of your system that require decentralization

### Rolling out

It is always better to catch bugs before a full production release. So, rollout your contracts in phases, with increasing usage and testing in each phase.

- Test contracts thoroughly, and add tests whenever new attack vectors are discovered
- Rollout in phases, with increasing usage and testing in each phase
- Use a bug bounty program to encourage security researchers to find bugs

Automated testing is a good way to catch bugs before they are deployed. You should have a comprehensive test suite for your contracts, and add tests whenever new attack vectors are discovered.

### Blockchain Properties

While much of your programming experience will be relevant to Ethereum programming, there are some pitfalls to be aware of.

- Be extremely careful about external contract calls, which may execute malicious code and change control flow.
- Understand that your public functions are public, and may be called maliciously and in any order. The private data in smart contracts is also viewable by anyone.
- Keep gas costs and the block gas limit in mind.
- Be aware that timestamps are imprecise on a blockchain, miners can influence the time of execution of a transaction within a margin of several seconds.
- Randomness is non-trivial on blockchain, most approaches to random number generation are gameable on a blockchain.

### Simplicity vs. Complexity

In complex code it is hard to understand the logic and find bugs. So, you should keep your code as simple as possible.

See details [here](https://consensys.github.io/smart-contract-best-practices/general-philosophy/simplicity-vs-complexity/)

## Precautions

### General

It is impossible to know in advance whether your code is secure. However, you can architect your contracts in a way that allows them to fail gracefully, and with minimal damage. This section presents a variety of techniques that will help you prepare for failure.

### Upgradeability

In the upgradeability the contract can be upgraded to a new version. This is useful to fix bugs or add new features to the contract.

Upgradeability is a potential anti-pattern and should be used only if is really necessary.. It is useful in some cases, but it can be dangerous if it is not well tesed and implemented.

Also the upgradeability can be used to exploit the contract. For example, the contract can be upgraded to a version that allows the owner to withdraw all the funds.

Other risk is that owner of the contract can upgrade the contract to a malicious version and execute a rug pull.

Some recommendations:

- Be careful with the intializer function, its different from the constructor and can be called multiple times
- Test the upgrade process and see if the contract is working as expected
- Test the new version of the contract

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/precautions/upgradeability/)

### Circuit Breakers

The circtuit break is a mechanism to stop the contract in case of an emergency, such as a bug, an attack, or also an unsual activity.

This helps to prevent the contract from being exploited and the owner can stop the contract and fix the issue.

One example of circuit break is the [pausable](https://docs.openzeppelin.com/contracts/2.x/api/lifecycle) pattern in OpenZeppelin contracts.

### Speed Bumps

The speed bump is a mechanism to slow down the execution of a function, for example, using a timelock, and don't allow the users to execute some actions during a period of time.

When flash loans were introduced, a lot of contracts were exploited because the users were able to borrow a lot of funds and execute a lot of actions in a single transaction. 

To avoid this, the contracts started to use speed bumps to slow down the execution of the functions.

See example [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/precautions/speed-bumps/)

### Rate Limiting

The rate limiting is a mechanism to limit the number of times that a function can be called in a period of time.

One example of rate limiting is the `timelock` function in OpenZeppelin contracts.

### Deployment

In the deployment the initial state of the contract is set. This is the moment to set the owner of the contract, the initial values of the variables, etc.

In some cases there is a `initialize` function that is called after the deployment to set the initial state of the contract.

A lot of issues can happen in initialization, for example, the owner of the contract can be set to a malicious address, the initial values of the variables can be set to malicious values, etc.

To avoid this:

- Check that the contract is not initialized yet
- Check that the owner is not a malicious address
- Check that the initial values of the variables are not incorrect values (for example, zero address, zero value, etc)

### Safe Haven

Safe haven is a mechanism to protect the funds in case of an emergency. This is useful to protect the funds in case of an attack.

One example of safe haven is the `emergencyWithdraw` function in OpenZeppelin contracts. This function allows withdraw funds in case of an emergency.

## Solidity Specific

### Assert, Require, Revert

Be familiar with the `assert`, `require`, and `revert` functions.

The `assert`, `require`, and `revert` functions are used to check conditions in the code. If the condition is not met, the function will stop the execution and revert the changes.

The difference between them is that the `assert` is used to check internal errors, the `require` is used to check user inputs, and the `revert` is used to check conditions that are not errors.

Now we also have custom errors that can be used to provide more information about the error.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/assert-require-revert/)

### Modifiers as Guards

In most cases you should restrict who can call a function and what they can do. This can be done using modifiers.

Modifiers are used to add a condition to a function. For example, the `onlyOwner` modifier in OpenZeppelin contracts is used to check if the caller of the function is the owner of the contract.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/modifiers-as-guards/)

### Integer Division

Be careful with integer division. In Solidity, the integer division truncates the decimal part of the result. For example, `5 / 2 = 2`.

Look at the edge cases and make sure that the result is what you expect.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/integer-division/)

### Abstract vs Interfaces

Be aware of the tradeoffs between abstract contracts and interfaces.

Abstract contracts are used to define a contract that can be inherited by other contracts. The abstract contract can have functions with implementation and also functions without implementation.

Interfaces are used to define a contract that can be inherited by other contracts. The interface can only have functions without implementation.

### Fallback Functions

The fallback function is a function that is called when the contract receives a transaction and the function called doesn't exist.

They are useful to receive funds, but they can also be used to execute malicious code.

In the proxy pattern, the fallback function is used to delegate the call to the implementation contract.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/fallback-functions/)

### Payability

This was a new feature introduced in Solidity 0.6.0. The payability is used to receive funds in a function. 

The function can be `payable` or `nonpayable`. If the function is `payable`, the function can receive funds. If the function is `nonpayable`, the function can't receive funds.

### Visibility

The visibility of a function defines who can call the function. The visibility can be `public`, `external`, `internal`, or `private`.

The `public` functions can be called by anyone, the `external` functions can be called by anyone but only from outside the contract, the `internal` functions can be called only from inside the contract or from contracts that inherit from the contract, and the `private` functions can be called only from inside the contract.

Restrict the visibility of the functions as much as you can and be careful with the public and external functions.

### Locking Pragmas

The locking pragmas are used to lock the compiler version. Avoid using the `^` in the compiler version because it can cause issues in the future.

For example, if a new version of the compiler is released, the `^` will use the new version and if this version has breaking changes, it can break your contract or in worst case, it can cause a vulnerability.

### Event Monitoring

Events are used to log information about the contract. They are useful to monitor the contract and detect issues.

For example, you can log information about the users that interact with the contract, the funds that are deposited in the contract, etc.

The tools that can be used to monitor the events are:

- [Tenderly](https://tenderly.co/)
- [Defender](https://openzeppelin.com/defender/)

### Shadowing

Shadowing is when a variable in a child contract has the same name as a variable in a parent contract. This can cause issues because the child contract can access the variable in the parent contract.

To avoid this, you should use different names for the variables in the child and parent contracts.

### tx.origin

The `tx.origin` is used to get the address of the user that sent the transaction.

The `tx.origin` can be used to execute attacks. For example, the user can call a function in a contract and the contract can call another contract. If the contract uses the `tx.origin` to check if the user is the owner, the contract will be vulnerable to an attack.

To avoid this, you should use the `msg.sender` in most cases instead of `tx.origin`.

The only use case for `tx.origin` is to check that if the contract is called by another contract.

### Timestamp Dependence

The timestamp dependence is when the contract uses the timestamp to execute some logic. This is dangerous because the timestamp can be manipulated by the miners.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/timestamp-dependence/)

### Complex Inheritance

The complex inheritance is when the contract inherits from multiple contracts. 

If you change the order this will modify the storage layout, for example, and can cause issues.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/complex-inheritance/)

### Interface Types

When a function takes a contract address as an argument, it is better to pass an interface or contract type rather than a raw address. If the function is called elsewhere within the source code, the compiler will provide additional type safety guarantees.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/interface-types/)

### EXTCODESIZE Checks

The `EXTCODESIZE` is used to check if a contract exists in an address. This is useful to check if a contract is deployed in an address.

Avoid using extcodesize to check for Externally Owned Accounts. This is because the extcodesize will return 0 for EOAs and this can cause issues.

See details [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/extcodesize-checks/)

### Token Specific

See details how to avoid issues with contract addresses [here](https://consensys.github.io/smart-contract-best-practices/development-recommendations/solidity-specific/token-specific/)

## Attacks

### Reentrancy

The reentrancy attack is when a contract calls another contract and the called contract calls back the caller contract before the first call is finished.

This happens because the function have issues with the order of the operations. For example, the function transfer the funds to the user and then update the balance of the user. If the user is a contract, the contract can call the function again and withdraw the funds again. To avoid this, the function should update the balance of the user before transfer the funds.

The checks-effects-interactions pattern is used to avoid reentrancy. In this pattern, the function first checks the conditions, then update the state of the contract, and then interact with other contracts.

There are also reentrancy guards that can be used to avoid reentrancy. For example, the `nonReentrant` modifier in OpenZeppelin contracts.

There are static analysis tools that can be used to detect reentrancy issues. For example, the [MythX](https://mythx.io/) tool.

See details [here](https://scsfg.io/hackers/reentrancy/)

### Oracle Manipulation

The oracle manipulation is when the contract uses an oracle to get the price of an asset and the oracle is manipulated to return a malicious price.

The way that the hacker can manipulate the oracle is by buying a lot of the asset and then sell it to manipulate the price.

To avoid this, the contract can use multiple oracles and use a median of the prices. With this, if one oracle is manipulated, the median will not be affected.

Other way to mitigate this risk is only use a trusted oracle such as Chainlink.

Monitoring unusual price movements can also help to detect this kind of attack.

See details [here](https://scsfg.io/hackers/oracle-manipulation/)

### Frontrunning

The frontrunning is when the hacker monitors the transactions in the mempool and then send a transaction with a higher gas price to execute the transaction before the original transaction.

The steps to execute this attack are:

1) Monitor the transactions in the mempool
2) Find a transaction that can be frontrunned
3) Send a transaction with a higher gas price to execute the transaction before the original transaction

To avoid front running, the contract van use a pattern called `commit-reveal`. In this pattern, the user first commit the transaction and then reveal the transaction. This way, the hacker can't frontrun the transaction because he doesn't know the transaction before the user reveal it.

One example of the use of the commit-reveal pattern is the `lock` and `unlock` functions in OpenZeppelin contracts.

We can also use a transaction counter and set the gas limit to prevent this kind of attack.

See details [here](https://hackernoon.com/how-to-solve-the-frontrunning-vulnerability-in-smart-contracts)

### Timestamp Dependence

The timestamp dependence is when the contract uses the timestamp to execute some logic. This is dangerous because the timestamp can be manipulated by the miners.

### Insecure Arithmetic

After solidity 0.8.0, the arithmetic operations revert if the result is greater than the maximum value of the data type and the overflow and underflow are checked.

The arithmetic operations can cause issues if the values are not checked. For example, if the result of an operation is greater than the maximum value of the data type, the result will be 0.

Be careful with the smaller data-types like uint8, uint16, uint24...etc: they can even more easily hit their maximum value.

See [details](https://consensys.github.io/smart-contract-best-practices/attacks/insecure-arithmetic/)

### Denial of Service
 
DOS attacks are when the hacker tries to make the contract unusable. 

For example, the hacker can try to make the contract unusable by consuming all the gas in the contract. In Ethereum the transactions have cost and its very expensive to execute a DOS attack. However, this can be done more chaper in other blockchains that have low fees.

Other way to execute is adding a lot of data to the contract. For example, the hacker can add a lot of data to the contract and make the contract unusable.

Take care with the loops in the contract because they can be used to execute a DOS attack. 

One solution to avoid loops consimming all gas in one transaction is implementenig a kind of pagination style approach.

See [details](https://consensys.github.io/smart-contract-best-practices/attacks/denial-of-service/)

### Griefing

Griefing attacks represent an exploit aimed at vulnerabilities in smart contracts, usually related to business logic. 

Insufficient gas griefing attacks represent a subset of griefing attacks that primarily affect smart contracts performing external calls without checking the success return value. 

See [details](https://scsfg.io/hackers/griefing/)

### Force Feeding

This attack is done by sending ether to an contract that uses the ether balance to execute some kind of business logic.

To avoid this, never use the balance of contrato to implement any business logic. If you need to do this, create a variable that store the balance and only can be modifieded when your logic permittis.

See [details](https://scsfg.io/hackers/griefing/)

## Recent Attacks

## Rug Pulls

This kind of "attack" happens because the contract gives to the owner the ability to withdraw the funds deposited by the users. And at some point, the owner decides to withdraw all the funds and leave the project. 

In some cases, the owners are hacked and the hacker withdraws all the funds using the privileges of the owner.

### Bald

See [here](https://livecoins.com.br/bald-despenca-zero-golpe-rug-pull/)

### Kannagi Finance

Kannagi project was audited twice. Its important in an audit to detect this kind of stuff and highlight this in the report to be clear about the risks of usign this contract.

See [here](https://beincrypto.com/kannagi-finance-zksync-era-rug-pull/)

### DeFi Labs

In this case, someone used a backdoor funciton in their staking contract called `withdrawFunds` that permits someone with "funder" role execute the function.

This kind of function is a RED FLAG. 

Sometimes this type of function can be useful to allow someone to go in at all funds to mode then to somewhere safe in case of attack.

### Platypus Finance

This was a quite interesting attack, the attacker used a flash loan to manipulate the price of the token and then withdraw all the funds from the contract. But at the end the hacker was not able to swap the funds because The attacker forgot to code any way collect the funds after stealing them.

See [here](https://thedefiant.io/hackers-use-emergency-withdraw-flaw-to-raid-platypus)

### Wintermute

An admin address was compromised using the profanity vulnerability, Wintermute had removed funds from this address, but hadn't removed its admin role, which allowed the attacker to remove tokens from the vault. The address was compromised because it had been created using the profanity tool, which was recently found to have a vulnerability.

See [here](https://www.coindesk.com/business/2022/09/20/crypto-market-maker-wintermute-hacked-for-160m-says-ceo/)

### Nomad bridge

In the initialize function, committedRoot is set to 0x00 and another function, process function, can be called by anyone, and is intended to process messages that have already been proved.

Because of 0x00 value, anyone could validate a malicous message and started the exploit.

What seemed to be happening is that messages were being processed that hadn’t previously been confirmed. Once the initial exploiting transaction went through, anyone could simply submit a similar transaction to drain funds for themselves.

Subsequently there were many such transactions from exploiters, white hats , along with the use of MEV techniques to take advantage of the situation.

See [here](https://medium.com/marcopolo-protocol/nomad-bridge-hack-explained-and-how-map-protocol-can-help-975ebdc08b82)

### Arbitrum critical vulnerability

A bridge address is used to receive funds deposited in Arbitrum, it is vital that this address is set up correctly and cannot be switched to a malicious contract.

Upgradeable contracts can go very wrong if the initialize function isn't adequately secured.

So, an attacker could call the initialize function, setting the address of the bridge contract to a contract that he control, and thus receive any ETH that users deposit.

Tips:

- Be careful when changing the storage in optimization
- Test the upgrade and try to simulate posible attacks

See [full details](https://medium.com/@0xriptide/hackers-in-arbitrums-inbox-ca23272641a2)

### Poly Network

- At the time was the largest hack in web3, 600M in founds
- Happend across multiple chains
- Tried to ask to exchanges to blacklist USDC and Tether 

Tips:

- dont have one address with a number of roles

See [full details](https://blog.kraken.com/product/security/abusing-smart-contracts-to-steal-600-million-how-the-poly-network-hack-actually-happened)
