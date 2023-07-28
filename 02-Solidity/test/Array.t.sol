// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Vm.sol";

import {ArrayContract} from "../src/Array.sol";

contract ArrayTest is Test {
    ArrayContract public arrayContract;

    function setUp() public {
        arrayContract = new ArrayContract();
    }

    function test_Remove() public {
        uint[] memory arrTest = new uint[](12);
        arrTest[0] = 0;
        arrTest[1] = 1;
        arrTest[2] = 2;
        arrTest[3] = 3;
        arrTest[4] = 4;
        arrTest[5] = 5;
        arrTest[6] = 6;
        arrTest[7] = 7;
        arrTest[8] = 8;
        arrTest[9] = 9;
        arrTest[10] = 10;
        arrTest[11] = 11;

        uint[] memory indexesTest =  new uint[](3);
        indexesTest[0] = 10;
        indexesTest[1] = 7;
        indexesTest[2] = 3;

        arrayContract.remove(arrTest, indexesTest);
        // assertEq(arrayContract.lastResult, [0,1,2,4,5,6,8,9,11]);
    }
}
