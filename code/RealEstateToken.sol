// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RealEstate42 is ERC20 {
    address owner;
    uint256 public tokenPrice;
    address public multiSigWallet;
    
    mapping(address => bool) private allowedTransfer;
    
    constructor(uint256 initialSupply, uint256 initialPrice, address _multiSigWallet) ERC20("RealEstate42", "RET") {
        owner = msg.sender;
        tokenPrice = initialPrice;
        multiSigWallet = _multiSigWallet;
        _mint(msg.sender, initialSupply);
    }

    function buyTokens(uint256 amount) external payable {
        require(msg.value == amount * tokenPrice, "Insufficient payment");
        _transfer(owner, msg.sender, amount);
    }

    function withdrawFunds() external {
        require(msg.sender == owner, "Only owner allowed");
        (bool success, ) = payable(multiSigWallet).call{ value: address(this).balance }("");
        require(success, "Transfer failed");
    }
}