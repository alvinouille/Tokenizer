# Usage of MultiSigWallet and RealEstate42 smart contracts

## Introduction

This guide explains how to deploy and use the MultiSigWallet and RealEstate42 smart contracts. These contracts respectively allow the management of a multi-signature wallet and the creation of an ERC20 token representing shares in real estate.

## RealEstate42 Contract

### Description

The RealEstate42 contract is an ERC20 token representing shares in real estate. Tokens can be purchased at a price set by the owner, and the collected funds are managed by a multi-signature wallet.

### ERC20 Functionalities

Since RealEstate42 is based on the ERC20 standard, it inherits all the basic ERC20 functionalities, including :
   - `transfer` : Transfer tokens to another address.
   - `approve` : Approve another address to spend tokens on your behalf.
   - `transferFrom` : Transfer tokens from one address to another using an allowance mechanism.
   - `balanceOf` : Check the token balance of an address.
   - `totalSupply` : Get the total supply of tokens.

### Initialization

Initialize the contract with an initial supply of tokens, the initial price and the multi-signature wallet address.

    uint256 initialSupply = 1000000 * (10 ** 18);
    uint256 initialPrice = 1 ether;
    address multiSigWallet = 0x123...;
    RealEstate42 token = new RealEstate42(initialSupply, initialPrice, multiSigWallet);

### Main Functions
   - `buyTokens` : 
      - **Parameters:** `amount`: The number of tokens to purchase
      - **Return Values:** None
      - **Usage:** Purchase tokens by sending ether (any address can do this).
  
   - `withdrawFunds` :
      - **Parameters:** None
      - **Return Values:** None
      - **Usage:** Withdraw funds from the contract to the multi-signature wallet (owner only).

### Example Usage

    // Deploy the contract
    uint256 initialSupply = 1000000 * (10 ** 18);
    uint256 initialPrice = 1 ether;
    address multiSigWallet = 0x123...;
    RealEstate42 token = new RealEstate42(initialSupply, initialPrice, multiSigWallet);
    
    // Buy tokens
    token.buyTokens{value: 10 ether}(10);
    
    // Withdraw funds to the multi-signature wallet
    token.withdrawFunds();


## MultiSigWallet Contract

### Purpose

The purpose of the multi-signature wallet is to enhance the security of fund transfers by requiring multiple approvals before any transaction is executed. This prevents any single party from unilaterally transferring funds, thus reducing the risk of fraud or errors.

### Description

The MultiSigWallet contract allows multiple approvers to validate withdrawal requests before execution. This contract secures funds by requiring the approval of several parties for any transaction.

### Initialization

Initialize the contract with a list of approvers and an approval threshold.
    
    address[] memory approvers = [address1, address2, address3];
    uint256 approvalThreshold = 2;
    MultiSigWallet wallet = new MultiSigWallet(approvers, approvalThreshold);

### Main Functions
   - `Addapprover` / `removeApprover`: 
     - **Parameters:** `approver`: The address to be added / removed as an approver.
     - **Return Values:** None
     - **Usage:** Add / remove an address as an approver (owner only).
  
   - `submitWithdraw` : 
     - **Parameters:**
       - `amount`: The amount of ether to withdraw.
       - `to`: The address to send the ether to.
     - **Return Values:** None
     - **Usage:** Submit a new withdrawal request (owner only)
  
   - `approveWithdraw` :
     - **Parameters:** `requestId`: The ID of the withdrawal request.
     - **Return Values:** None
     - **Usage:** Approve an existing withdrawal request (approvers only).

### Example Usage

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

### Notes

Ensure the contract has enough funds before submitting a withdrawal request.
Always verify the recipient address before submitting a withdrawal request.
Approvers should be trusted entities as they have the power to approve or reject withdrawal requests.
