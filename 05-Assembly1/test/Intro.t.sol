// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Intro.sol";

contract IntroTest is Test {
    Intro public intro;

    function setUp() public {
        intro = new Intro();
    }

    function testIntro() public {
        uint16 result = intro.intro();
        assertEq(result, 420);
    }
}
