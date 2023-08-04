// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/CheckCall.sol";
import "../src/Erc20.sol";

contract CheckCallTest is Test {
  event TransferOccurred(address indexed _to, uint256 _amount);
  
  CheckCall public checkCall;

  // mocked transfer data
  bytes _data = "0xa9059cbb000000000000000000000000a299c04eb002e667bcb6c0d38a024eb5022a5e1a000000000000000000000000000000000000000000000000000000000325d110";
  
  // expected results
  address _to = 0xa299c04Eb002e667BCb6c0d38A024Eb5022A5E1a;
  uint256 _value = 52810000;

  function setUp() public {
    checkCall = new CheckCall();
  }

  function testCheckCallEvent() public {
    vm.expectEmit(true, true, false, false);

    emit TransferOccurred(_to, _value);
    checkCall.checkCall(_data);
  }
}
