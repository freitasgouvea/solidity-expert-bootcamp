# Intro

## Nodes and Clients

A "node" is any instance of Ethereum client software that is connected to other computers also running Ethereum software, forming a network. 

A client is an implementation of Ethereum that verifies data against the protocol rules and keeps the network secure.

See: [Understanding Nodes](https://kauri.io/#collections/Ethereum%20101/ethereum-101-part-2-understanding-nodes/)

## Modular Blockchain (layers)

Post-Merge Ethereum consists of two parts: the execution layer and the consensus layer. Both layers are run by different client software.

Modular design with various software pieces working together is called encapsulated complexity. This approach makes it easier to execute The Merge seamlessly and enables the reuse of individual clients, for example, in the layer 2 ecosystem.

If we follow the principle of separation of concerns, we can use a combination of
blockchains to provide the functionality of a L1 and increase scalability.

See: [Diagram](https://ethereum.org/static/7a59bdb7a666b01a74535e8bea21a532/8b936/eth1eth2client.png)

### Encapsulated complexity

Encapsulated complexity occurs when there is a system with sub-systems that are internally complex, but that present a simple "interface" to the outside. Systemic complexity occurs when the different parts of a system can't even be cleanly separated, and have complex interactions with each other.

See: [Encapsulated vs systemic complexity in protocol design](https://vitalik.ca/general/2022/02/28/complexity.html)


### Client diversity

Multiple client implementations can make the network stronger by reducing its dependency on a single codebase. The ideal goal is to achieve diversity without any client dominating the network, thereby eliminating a potential single point of failure. The variety of languages also invites a broader developer community and allows them to create integrations in their preferred language.

See: [Applying the “Five Why’s” to our client diversity problem](https://notes.ethereum.org/@afhGjrKfTKmksTOtqhB9RQ/BJGj7uh08)

### ETH2

eth1 is execution layer: handle transactions

eth2 is consensus layer: handle proof of stake consensus

* see etherum roadmap (specialy The Scourge)

### Layers of Modular Blockchain

#### 1. Execution layer

Def: Transactions and state changes are initially processed here. Users also typically interact with the blockchain through this layer by signing transactions, deploying smart contracts, and transferring assets.

- Fuel
- Optimism
- Polygon Hermez
- Scroll
- Starknet
- zksync
- arbitrium
- aztec

#### 2. Consensus layer

Def: The consensus layer of blockchains provides ordering and finality through a network of full nodes downloading and executing the contents of blocks, and reaching consensus on the validity of state transitions.

- Ethereum
- Aptos
- Sui
- Cosmos
- Evmos

#### 3. Data Availability layer (NEW)

Def: The data required to verify that a state transition is valid should be published and stored on this layer. This should be easily verifiable in the event of attacks where malicious block producers withhold transaction data. The data availability layer is the main bottleneck for the blockchain scalability trilemma, we’ll explore why later on.

- zkporter
- celestia
- ethereum
- starkex
- eigenlayr
- polygon avail

#### * Settlement layer (only in rollups)

Def: The settlement layer is where the execution of rollups is verified and disputes are resolved. This layer does not exist in monolithic chains and is an optional part of the modular stack. In an analogy to the U.S. court system, think of the Settlement layer as the U.S. Supreme Court, providing final arbitration on disputes.


#### Links

See: [Modular Blockchains: A Deep Dive](https://volt.capital/blog/modular-blockchains)

### Blockspace market

* Demand side: tx supplied by users via dapps
* Supply side: validators proposing and voting on blocks

Two sides are mediated by congestion and fees.

Related features: 

- MEV: Maximal extractable value (MEV) refers to the maximum value that can be extracted from block production in excess of the standard block reward and gas fees by including, excluding, and changing the order of transactions in a block. 

- ASIC development: An application-specific integrated circuit (ASIC) is an integrated circuit (IC) chip customized for a particular use.

### Consensus of Etehreum

Proof-of-work and proof-of-stake alone are not consensus protocols, but they are often referred to as such for simplicity. 

They are actually Sybil resistance mechanisms and block author selectors; they are a way to decide who is the author of the latest block. 

It is this Sybil resistance mechanism combined with a chain selection rule that makes up a true consensus mechanism

Def: Sybil Resistance Mechanism and Block Authors Selectors

Two parts: 

* 1st - block producer selector
* 2nd - block acceptance

See: [Sybil attack](https://en.wikipedia.org/wiki/Sybil_attack)

#### Consensus Mechanisms Families

The term consensus mechanism refers to the entire stack of protocols, incentives and ideas that allow a network of nodes to agree on the state of a blockchain.

- a) nakamoto style = Bitcoin, Ethereum pre-merge
- b) bft style = Ethereum post-merge
- c) avalanche snow

See: [Consensus Mechanism](https://ethereum.org/en/developers/docs/consensus-mechanisms/)

### The Merge

- replaceed proof-of-work to proof-of-stake
- the Merge maintaned the state of accounts, smart contracts and txs
- current Eth 1.0 clients continue to handle execution. They process blocks, maintain mempools, and manage and sync state. The PoW stuff has been
taken out.
- consensus client – current Beacon Chain clients continue to handle PoS consensus. They track the chainʼs head, gossip and attest to blocks, and receive validator rewards

### Execution clients

The execution client (also known as the Execution Engine, EL client or formerly the Eth1 client) listens to new transactions broadcasted in the network, executes them in EVM, and holds the latest state and database of all current Ethereum data.

The execution client is responsible for transaction handling, transaction gossip, state management and supporting the Ethereum Virtual Machine (EVM). However, it is not responsible for block building, block gossiping or handling consensus logic. These are in the remit of the consensus client.

The execution client creates execution payloads - the list of transactions, updated state trie, and other execution-related data. 

Consensus clients include the execution payload in every block. The execution client is also responsible for re-executing transactions in new blocks to ensure they are valid. Executing transactions is done on the execution client's embedded computer, known as the Ethereum Virtual Machine (EVM).

- Geth
- Nethermind
- Besu
- Erigon
- Akula

### Consenus clients

The consensus client (also known as the Beacon Node, CL client or formerly the Eth2 client) implements the proof-of-stake consensus algorithm, which enables the network to achieve agreement based on validated data from the execution client.

The consensus client deals with all the logic that enables a node to stay in sync with the Ethereum network. This includes receiving blocks from peers and running a fork choice algorithm to ensure the node always follows the chain with the greatest accumulation of attestations (weighted by validator effective balances). 

Similar to the execution client, consensus clients have their own P2P network through which they share blocks and attestations.

The consensus client does not participate in attesting to or proposing blocks - this is done by a validator, an optional add-on to a consensus client. A consensus client without a validator only keeps up with the head of the chain, allowing the node to stay synced. This enables a user to transact with Ethereum using their execution client, confident that they are on the correct chain.

- Lighthouse
- Lodestar
- Nimbus
- Prysm
- Teku

#### Validators

Node operators can add a validator to their consensus clients by depositing 32 ETH in the deposit contract. 

The validator client comes bundled with the consensus client and can be added to a node at any time. 

The validator handles attestations and block proposals. 

They enable a node to accrue rewards or lose ETH via penalties or slashing. 

Running the validator software also makes a node eligible to be selected to propose a new block.

### Consensus after merge

Moved to GASPER (Casper FFG + LMD GHOST)

```
follow the chain containing the justified checkpoint that has the greatest height
```

Def: Gasper is a combination of Casper the Friendly Finality Gadget (Casper-FFG) and the LMD-GHOST fork choice algorithm. Together these components form the consensus mechanism securing proof-of-stake Ethereum. 

Consensus relies on both LMD-GHOST – which adds new blocks and decides what the head of the chain is – and Casper FFG which makes the final decision on which blocks are and are not a part of the chain.

Importance: Because finality requires a two-thirds agreement that a block is canonical, an attacker cannot possibly create an alternative finalized chain without:

- Owning or manipulating two-thirds of the total staked ether.
- Destroying at least one-third of the total staked ether.

#### Casper FFG

Def: Casper is the mechanism that upgrades certain blocks to "finalized" so that new entrants into the network can be confident that they are syncing the canonical chain. 

Goal: final decision witch blocks are and are not part of chain

#### LMD Ghost

Def: stands for "latest message-driven greedy heaviest observed sub-tree". This is a jargon-heavy way to define an algorithm that selects the fork with the greatest accumulated weight of attestations as the canonical one (greedy heaviest subtree).

Goal: decides the head of chain

#### Notes

[Combining GHOST and Casper](https://arxiv.org/pdf/2003.03052.pdf)

[Casper the Friendly Finality Gadget](https://arxiv.org/pdf/1710.09437.pdf)

Important: with this arch the network always know how to proceed, will never be a case without solution (REESCREVER)

### Epochs and checkpoints

Epochs of about 6 mins have 32 slots with all validators attesting to one slot (~12K attestations per block).

The fork-choice rule LMD GHOST then determines the current head of chain based on these attestations.

Finality is achieved when sufficient votes are reached, generally after 2 epochs.

### Validator Selection

A slot ocurrus every 12 sec and one validator is chosen to submit a block within that slot.

If fails the slot is empty.

The first block within an epoch (~6.4 mins) is a checkpoint block.

If a validator is not chosen to produce a block, it will instead vote on what it
regards as the current head of the chain and the checkpoint block.

Within an epoch a validator will only vote once.

They are grouped in random committees to vote and their votes are aggregated and published in the block header.

See: [Rewards](https://pintail.xyz/posts/validator-rewards-in-practice/)

#### Finalisation

Validators vote to indicate the block is valid. Once a checkpoint get sufficient votes it is regarded justified

### Staking rewards and penalties

Validators get rewarded for honestly proposing and validating blocks. Ether is rewarded and added to their stake. On the other hand, validators that are absent and fail to act when called upon miss out on these rewards and sometimes lose a small portion of their existing stake.

### Fork choice rule

A chain selection rule is used to decide which chain is the "correct" chain. 

Past: Bitcoin uses the "longest chain" rule, which means that whichever blockchain is the longest will be the one the rest of the nodes accept as valid and work with. For proof-of-work chains, the longest chain is determined by the chain's total cumulative proof-of-work difficulty. Ethereum used to use the longest chain rule too; however.

Present: now that Ethereum runs on proof-of-stake it adopted an updated fork-choice algorithm that measures the 'weight' of the chain. The weight is the accumulated sum of validator votes, weighted by validator staked-ether balances.

How: When faced with a potential fork, we choose the fork that has the most votes,
but when counting the votes, we only include the last one from any validator. The validator must vote for the chain they consider to be correct. The validator cannot vote for 2 blocks in any one time slot.

## TLDR

The following provides an end-to-end explanation of how a transaction gets executed in Ethereum proof-of-stake.

1 - A user creates and signs a transaction with their private key. This is usually handled by a wallet or a library such as ether.js but under the hood the user is making a request to a node using the Ethereum JSON-RPC API. The user defines the amount of gas that they are prepared to pay as a tip to a validator to encourage them to include the transaction in a block. The tips get paid to the validator while the base fee gets burned.

2 - The transaction is submitted to an Ethereum execution client which verifies its validity. This means ensuring that the sender has enough ETH to fulfill the transaction and they have signed it with the correct key.

3 - If the transaction is valid, the execution client adds it to its local mempool (list of pending transactions) and also broadcasts it to other nodes over the execution layer gossip network. When other nodes hear about the transaction they add it to their local mempool too. Advanced users might refrain from broadcasting their transaction and instead forward it to specialized block builders such as Flashbots Auction(opens in a new tab)↗. This allows them to organize the transactions in upcoming blocks for maximum profit (MEV).

4 - One of the nodes on the network is the block proposer for the current slot, having previously been selected pseudo-randomly using RANDAO. This node is responsible for building and broadcasting the next block to be added to the Ethereum blockchain and updating the global state. The node is made up of three parts: an execution client, a consensus client and a validator client. The execution client bundles transactions from the local mempool into an "execution payload" and executes them locally to generate a state change. This information is passed to the consensus client where the execution payload is wrapped as part of a "beacon block" that also contains information about rewards, penalties, slashings, attestations etc. that enable the network to agree on the sequence of blocks at the head of the chain. The communication between the execution and consensus clients is described in more detail in Connecting the Consensus and Execution Clients.

5 - Other nodes receive the new beacon block on the consensus layer gossip network. They pass it to their execution client where the transactions are re-executed locally to ensure the proposed state change is valid. The validator client then attests that the block is valid and is the logical next block in their view of the chain (meaning it builds on the chain with the greatest weight of attestations as defined in the fork choice rules). The block is added to the local database in each node that attests to it.

6 - The transaction can be considered "finalized", i.e., that it cannot be reverted, if it has become part of a chain with a "supermajority link" between two checkpoints. Checkpoints occur at the start of each epoch and to have a supermajority link they must both be attested to by 66% of the total staked ETH on the network.


## Ethereum State, Transactions and Blocks

World State. The world state is a mapping between addresses (160-bit identifiers) and account states

Though not stored on the blockchain, it is assumed that the implementation will maintain this mapping in a modified Merkle Patricia tree.

### Account

An account is made up of a cryptographic pair of keys: public and private. They help prove that a transaction was actually signed by the sender and prevent forgeries. Your private key is what you use to sign transactions, so it grants you custody over the funds associated with your account. You never really hold cryptocurrency, you hold private keys – the funds are always on Ethereum's ledger.

### Account types

- Externally-owned account (EOA) – controlled by anyone with the private keys

- Contract account – a smart contract deployed to the network, controlled by code. Contract accounts don't have private keys. Instead, they are controlled by the logic of the smart contract code.

### Account state

- Nonce: the number of transactions sent from this address or, in the case of accounts with associated code, the number of contract-creations made by this account. Only one transaction with a given nonce can be executed for each account, protecting against replay attacks where signed transactions are repeatedly broadcast and re-executed.

- Balance: the number of wei owned by address.

- Storage root (storage hash): A 256-bit hash of the root node of a Merkle Patricia trie that encodes the storage contents of the account (a mapping between 256-bit integer values), encoded into the trie as a mapping from the Keccak 256-bit hash of the 256-bit integer keys to the RLP-encoded 256-bit integer values. This trie encodes the hash of the storage contents of this account, and is empty by default. (MUTABLE)

- Code hash: This hash refers to the code of an account on the Ethereum virtual machine (EVM). Contract accounts have code fragments programmed in that can perform different operations. This EVM code gets executed if the account gets a message call. It cannot be changed, unlike the other account fields. All such code fragments are contained in the state database under their corresponding hashes for later retrieval. This hash value is known as a codeHash. For externally owned accounts, the codeHash field is the hash of an empty string. (IMMUTABLE)

#### EIP-2930

Def: Adds a transaction type which contains an access list, a list of addresses and storage keys that the transaction plans to access.

Explanation: Generally, the main function of gas costs of opcodes is to be an estimate of the time needed to process that opcode, the goal being for the gas limit to correspond to a limit on the time needed to process a block. However, storage-accessing opcodes ( SLOAD , as well as the CALL , BALANCE and EXT opcodes) have historically been underpriced.

Objective: mitigation to contract breakage risks introduced by [EIP-2929](https://eips.ethereum.org/EIPS/eip-2929)

Some context: 2016 Shanghai DoS attacks

### Tranasctions

Def: A transaction is a single cryptographically-signed instruction constructed by an actor externally to the scope of Ethereum. The sender of a transaction cannot be a contract.

As of the Berlin version of the protocol, there are two transaction types: 0
(legacy) and 1 (EIP-2930).

#### Transaction fields

A submitted transaction includes the following information:

- from – the address of the sender, that will be signing the transaction. This will be an externally-owned account as contract accounts cannot send transactions.

- to – the receiving address (if an externally-owned account, the transaction will transfer value. If a contract account, the transaction will execute the contract code).

- signature – the identifier of the sender. This is generated when the sender's private key signs the transaction and confirms the sender has authorized this transaction.

- nonce - a sequentially incrementing counter which indicates the transaction number from the account.

- value – amount of ETH to transfer from sender to recipient (denominated in WEI, where 1ETH equals 1e+18wei)

- input data – optional field to include arbitrary data.

- gasLimit – the maximum amount of gas units that can be consumed by the transaction. The EVM specifies the units of gas required by each computational step.

- maxPriorityFeePerGas - the maximum price of the consumed gas to be included as a tip to the validator.

- maxFeePerGas - the maximum fee per unit of gas willing to be paid for the transaction (inclusive of baseFeePerGas and maxPriorityFeePerGas).

Ex:

```
{
  from: "0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8",
  to: "0xac03bb73b6a9e108530aff4df5077c2b3d481e5a",
  gasLimit: "21000",
  maxFeePerGas: "300",
  maxPriorityFeePerGas: "10",
  nonce: "0",
  value: "10000000000"
}

```

### Transaction lifecycle

Once the transaction has been submitted the following happens:

1 - A transaction hash is cryptographically generated: x97d99bc7729211111a21b12c933c949d4f31684f1d6954ff477d0477538ff017 

2 - The transaction is then broadcasted to the network and added to a transaction pool consisting of all other pending network transactions.

3 - A validator must pick your transaction and include it in a block in order to verify the transaction and consider it "successful".

4 - As time passes the block containing your transaction will be upgraded to "justified" then "finalized". These upgrades make it much more certain that your transaction was successful and will never be altered. Once a block is "finalized" it could only ever be changed by a network level attack that would cost many billions of dollars.

See: [TRANSACTIONS](https://ethereum.org/en/developers/docs/transactions/)

### Bloom Filters

Def: probabilistc, space-efficient daat structure use for fast checks. Bloom filters are NO and MAYBE, they have an inverse behaivor of cache:

```
miss ==  definitely not present; hit == probably present;
```

How: hash each new element that goes into the data set, take certain bits of this hash and then use those bits to fill in parts of a fixed-size array.

Goal: Bloom filters are used with logs (events) Instead of storing events from a transaction, we store the bloom filter, We store a bloom filter for each transaction (if needed) for each block (for all transactions) Thus a light client can check for an event in the block bloom filter, and if it probably exists, then check the transaction bloom filters.

Why: The Bloom filter principle: Wherever a list or set is used, and space is at a premium, consider using a Bloom filter if the effect of false positives can be
mitigated. So we might have false positives, but weʼll never have false negatives. This can greatly reduce the number of database queries we have to make.

See: [Bloom Filters by Example](https://llimllib.github.io/bloomfilter-tutorial/)

### Account Abstraction

The shift from EOAs to smart contract wallets with arbitrary verification logic paves the way for a series of improvements to wallet designs, as well as reducing complexity for end users. Improvements list:

- Paying for transactions in currencies other than ETH
- The ability for third parties to cover transaction fees
- Support for more efficient signature schemes (Schnorr, BLS) as well as quantum-safe ones (Lamport, Winternitz)
- Support for multisig transations
- Support for social recovery

To add these features you need to build on top, is not default.

See: [Nethermind docs](https://nethermind.io/account-abstraction/)

See: [Binance blog](https://academy.binance.com/en/articles/what-is-erc-4337-or-account-abstraction-for-ethereum)

See: [More detailed blog text](https://our.status.im/account-abstraction-eip-2938/)

## Cryptograph Review

### Hash functions

Def: A hash function is a mathematical function that converts a numerical input value into another compressed numerical value. The input to the hash function is of arbitrary length but output is always of fixed length. Hashing is generally a one-way function, which means that it is easy to convert a message into a hash but very difficult to “reverse hash” a hash value back to its original message as it requires a massive amount of computing power.

- Fixed Length Output (Hash Value)
- Deterministic: meaning that every time you put in the same input, it will always create the same output.
- Irreversible: Meaning that while it is quick and easy to compute the hash if you know the input message for any given hash function, it is very difficult to go through the process in reverse to compute the input message if you only know the hash value.

Ethereum uses the Keccak-256 cryptographic hash function in many places. Keccak-256 was designed as a candidate for the SHA-3 Cryptographic Hash Function Competition held in 2007 by the National Institute of Science and Technology. Keccak was the winning algorithm, which became standardized as Federal Information Processing Standard (FIPS) 202 in 2015

See: [Hash Functions](https://cryptobook.nakov.com/cryptographic-hash-functions)

See: [Hashing](https://www.ime.usp.br/~pf/algorithms/chapters/hashing.html)

#### Ethereum Addresses

Ethereum addresses are unique identifiers that are derived from public keys or contracts using the Keccak-256 one-way hash function.

In our previous examples, we started with a private key and used elliptic curve multiplication to derive a public key:

Private key k:

```
k = f8f8a2f43c8376ccb0871305060d7b27b0554d2cc72bccf41b2705608452f315
```

Public key K (x and y coordinates concatenated and shown as hex):

```
K = 6e145ccef1033dea239875dd00dfb4fee6e3348b84985c92f103444683bae07b83b5c38e5e...
```

It is worth noting that the public key is not formatted with the prefix (hex) 04 when the address is calculated. We use Keccak-256 to calculate the hash of this public key:

```
Keccak256(K) = 2a5bc342ed616b5ba5732269001d3f1ef827552ae1114027bd3ecf1f086ba0f9
```

Then we keep only the last 20 bytes (least significant bytes), which is our Ethereum address:
```
001d3f1ef827552ae1114027bd3ecf1f086ba0f9
```

Most often you will see Ethereum addresses with the prefix 0x that indicates they are hexadecimal-encoded, like this:

```
0x001d3f1ef827552ae1114027bd3ecf1f086ba0f9
```

### Encryption

Def: Encryption is the practice of taking data and creating a scrambled message in a way that only someone with a corresponding key, called a cipher, can unscramble and decode it. Encryption is a two-way function, designed to be reversible by anyone who holds a cipher. So when someone encrypts something, it is done with the intention of decrypting it later.

See: [Encryption: Symmetric and Asymmetric](https://cryptobook.nakov.com/encryption-symmetric-and-asymmetric)

#### Symmetric Encryption

Def: Symmetric encryption schemes use the same symmetric key (or password) to encrypt data and decrypt the encrypted data back to its original form.

#### Asymmetric Encryption

Def: Asymmetric encryption schemes use a pair of cryptographically related public and private keys to encrypt the data (by the public key) and decrypt the encrypted data back to its original forms (by the private key). Data encrypted by a public key is decrypted by the corresponding private key.

### Elliptic Curve Cryptography

Def: ECC is the next generation of public key cryptography and, based on currently understood mathematics, provides a significantly more secure foundation than first generation public key cryptography systems like RSA. 

Ethereum, like bitcoin, uses secp256k1 – an elliptic curve primitive – for the encryption used in this process.

see: [Elliptic Curve Cryptography Basics | Cryptography & Blockchain](https://infosecwriteups.com/elliptic-curve-cryptography-basics-cryptography-blockchain-7797ba1021ed)

see: [A (Relatively Easy To Understand) Primer on Elliptic Curve Cryptography](https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/)

#### Cryptograph Signatures with ECDSA

Inputs: message, pv key, secret

Output: digital signature (that can be checked)

Ethereum uses ECDSA algorithm to create and verify signature.

Recovery: produces a public key that can be used to compare with account public key (the address is part of public key).

See: [The Magic of Digital Signatures on Ethereum](https://medium.com/mycrypto/the-magic-of-digital-signatures-on-ethereum-98fe184dc9c7)

#### Javascript example code to create and verify signature

```js
// hashMessage.js
const { keccak256 } = require("ethereum-cryptography/keccak");
const { utf8ToBytes, toHex } = require("ethereum-cryptography/utils");

function hashMessage(message) {
    const bytes = utf8ToBytes(message);
    return keccak256(bytes)
}

module.exports = hashMessage;

// signMessage.js
const secp = require("ethereum-cryptography/secp256k1");
const hashMessage = require('./hashMessage');

const PRIVATE_KEY = "";

async function signMessage(msg) {
    const hashedMessage = hashMessage(msg)
    const signature = secp.sign(hashedMessage, PRIVATE_KEY, {recovered: true})
    return signature
    
}

module.exports = signMessage;

// recoverKey.js
const secp = require("ethereum-cryptography/secp256k1");
const hashMessage = require("./hashMessage");

async function recoverKey(message, signature, recoveryBit) {
    const hash = hashMessage(message)
    return secp.recoverPublicKey(hash, signature, recoveryBit)
}

module.exports = recoverKey;
```
