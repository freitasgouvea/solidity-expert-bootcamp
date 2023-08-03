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

        query = new Query();
        erc20 = new Erc20();
        erc20.mint(sender, 1000);

        vm.stopPrank();
    }

    function testInitialBalance() public {
        assertEq(erc20.balanceOf(sender), 1000); 
        assertEq(erc20.balanceOf(receiver), 0); 
    }

    function testQuery() public {
        function(address, uint256) external returns (bool) transferFunction = erc20.transferWrapper;

        vm.prank(sender);
        query.query(500, receiver, transferFunction);

        assertEq(erc20.balanceOf(sender), 500);        
        assertEq(erc20.balanceOf(receiver), 500);
    }

    function testRevert() public {
        function(address, uint256) external returns (bool) transferFunction = erc20.transferWrapper;

        vm.prank(sender);
        vm.expectRevert(bytes("ERC20: transfer amount exceeds balance"));
        query.query(10000, receiver, transferFunction);
    }
}
