// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../src/PledgeBoard.sol";

contract PledgeBoardTest is Test {
    PledgeBoard public c;
    
    function setUp() public {
        c = new PledgeBoard();
    }

    function testDeployment() public {
        assertTrue(address(c) != address(0));
    }
}
