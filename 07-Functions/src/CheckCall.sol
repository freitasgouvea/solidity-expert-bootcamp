// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Erc20.sol";

contract CheckCall {
  event TransferOccurred(address indexed _to, uint256 _amount);

  bytes4 expectedFunctionSelector = ERC20.transfer.selector;

  function checkCall(bytes calldata data) external pure returns (bytes4, address, uint256) {
    require(data.length >= 68, "Input data is too short");

    bytes4 selector;
    address to;
    uint256 amount;
    
    (selector, to, amount) = abi.decode(data[4:], (bytes4, address, uint256));

    return (selector, to, amount);
  }
}