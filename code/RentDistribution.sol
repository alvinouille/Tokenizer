// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./RealEstateToken.sol";

contract RentDistribution is Ownable {
    RealEstate42 public token;
    uint256 public totalRentCollected;

    mapping(address => uint256) public rentBalance;

    constructor(address tokenAddress) Ownable(msg.sender) {
        token = RealEstate42(tokenAddress);
    }

    function collectRent() public payable onlyOwner {
        totalRentCollected += msg.value;
        sharingRent(msg.value);
    }

    function sharingRent(uint256 totalRent) internal {
        address[] memory holders = token.getHolders();
        uint256 totalTokens = token.totalSupply();
        for (uint i = 0; i < holders.length; i++) {
            address holder = holders[i];
            uint256 ownedTokens = token.getBalance(holder);
            rentBalance[holder] += totalRent * ownedTokens / totalTokens;
        }
    }

    function withdrawRent() public {
        require(token.isHolder(msg.sender), "Token holder only");
        uint256 amount = rentBalance[msg.sender];
        require(amount > 0, "No rent available for withdrawal");
        (bool s, ) = payable(msg.sender).call{ value: amount }("");
        require(s, "Failed to withdraw rent");
        rentBalance[msg.sender] = 0;
        totalRentCollected -= amount;
    }

    function rentDue(address holder) public view returns (uint256) {
        return rentBalance[holder];
    }
}