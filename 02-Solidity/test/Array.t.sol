// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Vm.sol";
import "../lib/forge-std/src/console.sol";

import {ArrayContract} from "../src/Array.sol";

contract ArrayTest is Test {
    ArrayContract public arrayContract;

    uint[] arrTest = [0,1,2,3,4,5,6,7,8,9,10,11];
    uint[] indexesTest = [8,2,7];
    uint[] expectedResult = [0,1,3,4,5,6,9,10,11];

    function setUp() public {
        arrayContract = new ArrayContract();
    }

    function test_Remove() public {
        uint[] memory result  = arrayContract.remove(arrTest, indexesTest);
        assertEq(result, expectedResult);
    }
}
