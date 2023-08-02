// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Amount.sol";

contract AmountTest is Test {
    Amount public amount;

    function setUp() public {
        amount = new Amount();
    }

    function testDepositReturn() public {
        uint256 result = amount.deposit{value: 1 ether}();
        assertEq(result, 1 ether);
    }

    function testDepositBalance() public {
        uint256 balanceBefore = address(amount).balance;
        amount.deposit{value: 1 ether}();
        uint256 balanceAfter = address(amount).balance;
        assertEq(balanceAfter - balanceBefore, 1 ether);
    }
}
