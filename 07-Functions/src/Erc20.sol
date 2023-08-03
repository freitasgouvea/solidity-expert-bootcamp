// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Erc20 is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("Erc20", "MTK") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transferWrapper(address _recipient, uint256 _amount) external returns (bool) {
        return transfer(_recipient, _amount);
    }
}
