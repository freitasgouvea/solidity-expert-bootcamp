// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Store.sol";

contract StoreTest is Test {
    Store public store;

    function setUp() public {
        store = new Store();
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
