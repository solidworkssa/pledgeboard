// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PledgeBoard {
    struct Pledge {
        address pledger;
        string commitment;
        uint256 timestamp;
        uint256 deadline;
        bool completed;
        bool verified;
    }

    mapping(uint256 => Pledge) public pledges;
    uint256 public pledgeCounter;

    event PledgeCreated(uint256 indexed pledgeId, address indexed pledger, string commitment);
    event PledgeCompleted(uint256 indexed pledgeId);
    event PledgeVerified(uint256 indexed pledgeId);

    error Unauthorized();
    error InvalidPledge();

    function createPledge(string memory commitment, uint256 duration) external returns (uint256) {
        uint256 pledgeId = pledgeCounter++;
        pledges[pledgeId] = Pledge(
            msg.sender,
            commitment,
            block.timestamp,
            block.timestamp + duration,
            false,
            false
        );
        emit PledgeCreated(pledgeId, msg.sender, commitment);
        return pledgeId;
    }

    function completePledge(uint256 pledgeId) external {
        Pledge storage pledge = pledges[pledgeId];
        if (pledge.pledger != msg.sender) revert Unauthorized();
        pledge.completed = true;
        emit PledgeCompleted(pledgeId);
    }

    function verifyPledge(uint256 pledgeId) external {
        pledges[pledgeId].verified = true;
        emit PledgeVerified(pledgeId);
    }

    function getPledge(uint256 pledgeId) external view returns (Pledge memory) {
        return pledges[pledgeId];
    }
}
