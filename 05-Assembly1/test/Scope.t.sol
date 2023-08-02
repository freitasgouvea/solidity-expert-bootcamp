// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Scope.sol";

contract ScopeTest is Test {
    Scope public scope;

    function setUp() public {
      scope = new Scope();
    }

    function testIncrement() public {
      scope.increment(3);
      assertEq(scope.count(), 13);
    }
}
