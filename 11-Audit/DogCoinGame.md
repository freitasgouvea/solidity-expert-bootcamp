# DogCoinGame audit

## Introduction

This report provides an overview of the security of the [DogCoinGame](https://raw.githubusercontent.com/ExtropyIO/ExpertSolidityBootcamp/main/exercises/audit/DogCoinGame.sol) smart contract. 

The audit identified several security issues. The identified issues should be addressed to further improve the security of the contract.

## Findings

The following is a list of the potential security issues that were identified during the audit:

1) The DogCoinGame smart contract does not have a proper access control mechanism in place. This could allow an attacker to gain unauthorized access to the contract and steal funds.
  - The `addWinner` function does not require the caller to be an approved address. This means that any address can put addresses to the winners list, even if they have not paid the entry fee.
  - The `payout` function does not require the caller to be the owner of the contract. This means that any address can call the `payout` function.

2) The DogCoinGame smart contract does not emit any events when players are added or winners are paid out.  
  - This means that it would be difficult to track down the smart contract calls.
  - This also means that it would be difficult to track down the source of any security breaches.

3) The `addPlayer` function does not validate correctly the `msg.value`. The correct amount is 1 ETH but the contract is validating that the msg.value is equals to 1 wei.

4) The `addWinner` function does not validate the address of the player. This means that an attacker could call the `addWinner` function with a malicious address, which could then be used to steal funds from the contract. 

5) The `addWinner` function permits the same address to be added multiple times. This means that an caller could add multiple times addrresses to the contract and take advantage of this.

6) The `payout` function is intended to distribute rewards to winners when the contract balance reaches 100 ETH. But if the contract balance is more than 100 ETH, the payout function will not distribute any rewards and the funds will be locked in the contract.

7) The `amountToPay` variable inside `payout` function can produce a overflow error if the `winners.length` is less than 100 or not a multiple of 100. This means that the contract will not distribute any rewards or will distribute with incorrect amounts.

## Recommendations

The following are the recommendations for addressing the potential security issues that were identified during the audit:

1) The DogCoinGame smart contract should have a proper access control mechanism in place. This could be achieved by using the Access Control mechanism.

2) The DogCoinGame smart contract should emit events when players are added or winners are paid out. This could be achieved by emitting events inside the `addPlayer` and `payout` functions.

3) The `addPlayer` function should validate correctly the `msg.value`. This could be achieved by validating that the `msg.value` is equals to 1 ETH.

4) The `addWinner` function should validate the address of the player. This could be achieved by validating that the address is not the zero address and verifying that the address is on the players list.

5) The `addWinner` function should not permit the same address to be added multiple times. This could be achieved by verifying that the address is not already on the winners list.

6) The `payout` function should distribute rewards to winners when the contract balance reaches 100 ETH. This could be achieved by verifying that the contract balance is equals or more to 100 ETH.

7) The `amountToPay` variable inside `payout` function should not produce a overflow error. This could be achieved by modifyng the distribution logic to distribute the rewards to the winners.

## Conclusion

The identified issues should be addressed to further improve the security of the contract and to ensure that the contract works as intended.