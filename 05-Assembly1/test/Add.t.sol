// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Add.sol";

contract AddTest is Test {
    Add public add;

    function setUp() public {
        add = new Add();
    }

    function testAddAssembly() public {
        uint256 result = add.addAssembly(5,7);
        assertEq(result, 12);
    }
}
