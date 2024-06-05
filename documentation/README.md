# MultiSigWallet & RealEstate42 Smart Contracts

## Introduction

This guide explains how to deploy and use the MultiSigWallet and RealEstate42 smart contracts. These contracts respectively allow the management of a multi-signature wallet and the creation of an ERC20 token representing shares in real estate.

## MultiSigWallet Contract

### Description

The MultiSigWallet contract allows multiple approvers to validate withdrawal requests before execution. This contract secures funds by requiring the approval of several parties for any transaction.
Purpose

The purpose of the multi-signature wallet is to enhance the security of fund transfers by requiring multiple approvals before any transaction is executed. This prevents any single party from unilaterally transferring funds, thus reducing the risk of fraud or errors.

#### Initialisation

Initialize the contract with a list of approvers and an approval threshold.

    solidity

    address[] memory approvers = [address1, address2, address3];
    uint256 approvalThreshold = 2;
    MultiSigWallet wallet = new MultiSigWallet(approvers, approvalThreshold);

Main Functions

    Add an Approver:
        Add a new address as an approver (owner only).

    solidity

wallet.addApprover(newApproverAddress);

Submit a Withdrawal Request:

    Submit a new withdrawal request (owner only).

solidity

wallet.submitWithdraw(amount, toAddress);

Approve a Withdrawal Request:

    Approve an existing withdrawal request (approvers only).

solidity

wallet.approveWithdraw(requestId);

Receive Payments:

    The contract can receive payments directly via the receive function.

solidity

    (bool success, ) = address(wallet).call{value: amount}("");

Example Usage

solidity

// Deploy the contract
address[] memory approvers = [0x123..., 0x456..., 0x789...];
uint256 approvalThreshold = 2;
MultiSigWallet wallet = new MultiSigWallet(approvers, approvalThreshold);

// Add an approver
wallet.addApprover(0xABC...);

// Submit a withdrawal request
wallet.submitWithdraw(100 ether, 0xDEF...);

// Approve a withdrawal request
wallet.approveWithdraw(0);

RealEstate42 Contract
Description

The RealEstate42 contract is an ERC20 token representing shares in real estate. Tokens can be purchased at a price set by the owner, and the collected funds are managed by a multi-signature wallet.
ERC20 Functionality

Since RealEstate42 is based on the ERC20 standard, it inherits all the basic ERC20 functionalities, including:

    transfer: Transfer tokens to another address.
    approve: Approve another address to spend tokens on your behalf.
    transferFrom: Transfer tokens from one address to another using an allowance mechanism.
    balanceOf: Check the token balance of an address.
    totalSupply: Get the total supply of tokens.

Deployment and Usage
Deployment

    Initialization:
        Initial supply: Number of tokens to create.
        Initial token price: Price in wei per token.
        Multi-signature wallet address.

    solidity

    uint256 initialSupply = 1000000 * (10 ** 18);
    uint256 initialPrice = 1 ether;
    address multiSigWallet = 0x123...;
    RealEstate42 token = new RealEstate42(initialSupply, initialPrice, multiSigWallet);

Main Functions

    Set Token Price:
        Update the token price (owner only).

    solidity

token.setTokenPrice(newPrice);

Set Multi-Signature Wallet Address:

    Update the multi-signature wallet address (owner only).

solidity

token.setMultiSigWallet(newMultiSigWallet);

Buy Tokens:

    Purchase tokens by sending ether (any address can do this).

solidity

token.buyTokens{value: amountInWei}(numberOfTokens);

Withdraw Funds:

    Withdraw funds from the contract to the multi-signature wallet (owner only).

solidity

    token.withdrawFunds();

Token Holder Management

    Token holders are automatically updated during transfers.
    Holders can check their balance and get the list of holders.

    solidity

    address[] memory holders = token.getHolders();
    uint256 balance = token.getBalance(holderAddress);

Example Usage

solidity

// Deploy the contract
uint256 initialSupply = 1000000 * (10 ** 18);
uint256 initialPrice = 1 ether;
address multiSigWallet = 0x123...;
RealEstate42 token = new RealEstate42(initialSupply, initialPrice, multiSigWallet);

// Update the token price
token.setTokenPrice(2 ether);

// Update the multi-signature wallet address
token.setMultiSigWallet(0x456...);

// Buy tokens
token.buyTokens{value: 10 ether}(10);

// Withdraw funds
token.withdrawFunds();

Notes

    Ensure the contract has enough funds before submitting a withdrawal request.
    Always verify the recipient address before submitting a withdrawal request.
    Approvers should be trusted entities as they have the power to approve or reject withdrawal requests.
