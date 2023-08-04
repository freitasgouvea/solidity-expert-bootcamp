// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/Query.sol";
import "../src/Erc20.sol";

contract QueryTest is Test {
    Query public query;
    Erc20 public erc20;

    address owner = vm.addr(1);
    address sender = vm.addr(2);
    address receiver = vm.addr(3);

    function setUp() public {
        vm.startPrank(owner);


        erc20 = new Erc20();
        erc20.mint(sender, 1000);

        query = new Query(address(erc20));

        vm.stopPrank();
    }

    function testInitialBalance() public {
        assertEq(erc20.balanceOf(sender), 1000); 
        assertEq(erc20.balanceOf(receiver), 0); 
    }

    function testQuery() public {
        vm.prank(sender);
        query.query(500, receiver, "transfer(address,uint256)");

        assertEq(erc20.balanceOf(sender), 500);        
        assertEq(erc20.balanceOf(receiver), 500);
    }

    function testRevert() public {
        vm.prank(sender);
        vm.expectRevert();
        query.query(10000, receiver, "transfer(address,uint256)");
    }
}
