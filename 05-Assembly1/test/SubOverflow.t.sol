// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/SubOverflow.sol";

contract SubOverflowTest is Test {
    SubOverflow public subOverflow;

    function setUp() public {
      subOverflow = new SubOverflow();
    }

    function testSubtractSuccess() public {
      uint256 result = subOverflow.subtract(5,2);
      assertEq(result, 3);
    }

    function testSubtractOverflow() public {
      uint256 result = subOverflow.subtract(2,5);
      assertEq(result, 0);
  }
}
