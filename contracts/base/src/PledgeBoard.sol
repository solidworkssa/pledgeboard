// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title PledgeBoard Contract
/// @author solidworkssa
/// @notice Community pledge tracker for crowdfunding.
contract PledgeBoard {
    string public constant VERSION = "1.0.0";


    mapping(address => uint256) public pledges;
    uint256 public goal;
    uint256 public totalPledged;
    
    constructor(uint256 _goal) {
        goal = _goal;
    }
    
    function pledge() external payable {
        pledges[msg.sender] += msg.value;
        totalPledged += msg.value;
    }
    
    function withdraw() external {
        require(totalPledged >= goal, "Goal not reached");
        // Logic to withdraw funds
    }

}
