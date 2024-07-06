# The RealEstate42 Token (RET)

## Overview
**The RealEstate Token** project aims to tokenize real estate property, enabling fractional ownership. The goal is to make real estate investment more accessible and liquid by allowing investors to buy and sell fractions of properties in the form of tokens. 

## Blockchain : Ethereum
Ethereum was chosen as the blockchain for this project due to its robustness, extensive ecosystem, and compatibility with smart contracts, especially ERC-20 contracts. Ethereum offers the security and decentralization essential for financial transactions and real estate ownership management.

## Development environment and tools : Hardhat
For the development and deployment of smart contracts, the Hardhat development environment was used. Hardhat enables efficient and reliable creation, testing, and deployment of smart contracts. It also provides tools for integration with Ethereum and libraries like OpenZeppelin.

## The ERC-20 Token standard
This is the standard for fungible tokens : each token is identical and interchangeable with any other token of the same type. The ERC-20 standard was chosen for the RealEstate Token because it is widely adopted and offers a common interface for tokens. This ensures easy integration with exchanges, wallets, and other decentralized applications. ERC-20 also provides enhanced security features for token transfers and balance management, which is crucial for asset tokenization.

## Multi-signature wallet
In this project, a multi-signature wallet is utilized to enhance security and governance. Multi-sig wallets are typically used in scenarios where multiple approvals are required to authorize a transaction, thereby reducing the risk of unauthorized or fraudulent withdrawals. Within this project, the multi-sig wallet ensures that any withdrawal of funds from the contract requires approval from a predefined number of approvers. This mechanism not only secures the funds but also promotes transparent and collective decision-making.

## Project Directory Structure

### `code/`
Contains all the source code files for the smart contracts. The source code includes the main contract `RealEstate42.sol`, which defines the token's functionality and user interactions, and the `MultiSigWallet.sol` contract.

### `deployment/`
This section explains how to set up a full hardhat project, from basically writing the smart contract to its full deployment on the Ethereum blockchain.

### `documentation/`
This section helps developers and users understand how the RealEstate Token works and how to interact with it.

**RealEstate42 Token (RET) Contract :** https://sepolia.etherscan.io/address/0x267fD2B734F0161f3A402E60A780a943E80585c0
**MultiSigWallet Contract :** https://sepolia.etherscan.io/address/0xBB390139002a23643A4Fb7796e588387E235CdA2
