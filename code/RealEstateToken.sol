// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RealEstate42 is ERC20 {
    address owner;
    uint256 public tokenPrice;
    address[] public holders;
    address public multiSigWallet;
    
    mapping(address => uint256) public holdersIndex;
    mapping(address => bool) private allowedTransfer;
    
    constructor(uint256 initialSupply, uint256 initialPrice, address _multiSigWallet) ERC20("RealEstate42", "RET") {
        owner = msg.sender;
        tokenPrice = initialPrice;
        holders.push(msg.sender);
        holdersIndex[msg.sender] = 1;
        multiSigWallet = _multiSigWallet;
        _mint(msg.sender, initialSupply);
    }


    function isHolder(address holder) public view returns (bool) {
        return holdersIndex[holder] != 0;
    }

    function removeHolder(address holder) internal {
        uint index = holdersIndex[holder] -1;
        uint lastIndex = holders.length -1;
        if (index != lastIndex) {
            address lastHolder = holders[lastIndex];
            holders[index] = lastHolder;
            holdersIndex[lastHolder] = index + 1;
        }
        holders.pop();
        delete holdersIndex[holder];
    }

    function buyTokens(uint256 amount) external payable {
        require(msg.value == amount * tokenPrice, "Insufficient payment");
        allowedTransfer[msg.sender] = true;
        _transfer(owner, msg.sender, amount);
        allowedTransfer[msg.sender] = false;
    }

    function _update(address from, address to, uint256 amount) internal virtual override {
        if (from == owner && to != address(0)) {
            require(allowedTransfer[to], "Owner cannot transfer tokens directly without payment");
        }

        super._update(from, to, amount);

        if (from == address(0) || to == address(0))
            return;
        if (balanceOf(from) == 0 && isHolder(from)) {
            removeHolder(from);
        }
        if (balanceOf(to) > 0 && !isHolder(to)) {
            holders.push(to);
            holdersIndex[to] = holders.length;
        }
    }

    function getHolders() external view returns (address[] memory) {
        return holders;
    }

    function withdrawFunds() external {
        require(msg.sender == owner, "Only owner allowed");
        (bool success, ) = payable(multiSigWallet).call{ value: address(this).balance }("");
        require(success, "Transfer failed");
    }
}
