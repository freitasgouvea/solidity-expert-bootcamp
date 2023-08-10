// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Div.sol";

contract DivTest is Test {
    Div public div;

    function setUp() public {
        div = new Div();
    }

    function testSolidity() public {
        uint256 result = div.divSolidity(10,5);
        assertEq(result, 2);
    }

    function testAssembly() public {
        uint256 result = div.divAssembly(10,5);
        assertEq(result, 2);
    }
}
