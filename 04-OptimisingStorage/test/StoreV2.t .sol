// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/StoreV2.sol";

contract StoreV2Test is Test {
    StoreV2 public store;

    function setUp() public {
        store = new StoreV2();
        store.setNumber(0);
    }

    function testIncrement() public {
        store.increment();
        assertEq(store.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        store.setNumber(x);
        assertEq(store.number(), x);
    }
}
