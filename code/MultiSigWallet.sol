// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiSigWallet is Ownable {
    address[] public approvers;
    uint256 public approvalThreshold;
    mapping(address => bool) public isApprover;
    mapping(uint256 => WithdrawalRequest) public withdrawalRequests;
    uint256 public withdrawalRequestCount;

    struct WithdrawalRequest {
        uint256 amount;
        address to;
        uint256 approvals;
        mapping(address => bool) approvedBy;
    }

    event WithdrawalRequested(uint256 indexed requestId, uint256 amount, address indexed to);
    event WithdrawalApproved(uint256 indexed requestId, uint256 amount, address indexed to);
    event WithdrawalExecuted(uint256 indexed requestId, uint256 amount, address indexed to);

    constructor(address[] memory _approvers, uint256 _approvalThreshold) Ownable(msg.sender) {
        approvers = _approvers;
        approvers.push(msg.sender);
        for (uint i = 0; i < approvers.length ; i++) {
            isApprover[approvers[i]] = true;
        }
        approvalThreshold = _approvalThreshold;
    }

    function addApprover(address approver) external onlyOwner {
        require(!isApprover[approver], "Already an approver");
        approvers.push(approver);
        isApprover[approver] = true;
    }

    function removeApprover(address approver) external onlyOwner {
        require(isApprover[approver], "Not an approver");
        require(approvers.length > 2, "Cannot have less than 2 approvers");

        _removeApprover(approver);
    }

    function _removeApprover(address approver) internal {
        for (uint i = 0; i < approvers.length; i++) {
            if (approvers[i] == approver) {
                approvers[i] = approvers[approvers.length - 1];
                approvers.pop();
                break;
            }
        }
        isApprover[approver] = false;
    }

    function submitWithdraw(uint256 amount, address to) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        require(amount > 0, "Amount must be greater than 0");
        uint256 requestId = withdrawalRequestCount++;
        WithdrawalRequest storage request = withdrawalRequests[requestId];
        request.amount = amount;
        request.to = to;
        request.approvals = 0;
        emit WithdrawalRequested(requestId, amount, to);
        approveWithdraw(requestId);
    }

    function approveWithdraw(uint256 requestId) public {
        require(isApprover[msg.sender], "Approver only");
        WithdrawalRequest storage request = withdrawalRequests[requestId];
        require(request.amount > 0, "Request does not exist");
        require(!request.approvedBy[msg.sender], "Already approved");
        request.approvedBy[msg.sender] = true;
        request.approvals++;
        emit WithdrawalApproved(requestId, request.amount, request.to);

        if (request.approvals >= approvalThreshold) {
            executeWithdraw(requestId);
        }
    }

    function executeWithdraw(uint256 requestId) internal {
        WithdrawalRequest storage request = withdrawalRequests[requestId];
        (bool success, ) = payable(request.to).call{ value: request.amount }("");
        require(success, "Transfer failed");
        emit WithdrawalExecuted(requestId, request.amount, request.to);
        delete withdrawalRequests[requestId];
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        address oldOwner = owner();
        super.transferOwnership(newOwner);
        if (!isApprover[newOwner]) {
            approvers.push(newOwner);
            isApprover[newOwner] = true;
        }
        if (isApprover[oldOwner]) {
            _removeApprover(oldOwner);
        }
    }

    function renounceOwnership() public override onlyOwner {
        require(approvers.length > 2, "Cannot renounce ownership with less than 3 approvers");
        super.renounceOwnership();
    }

    receive() external payable {}
}
