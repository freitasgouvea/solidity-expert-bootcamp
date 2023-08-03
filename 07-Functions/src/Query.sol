// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Query {
    function query(
        uint _amount, 
        address _receiver, 
        function(address, uint256) external returns (bool) _transfer
    ) public {
        _transfer(_receiver,_amount);
    }
}
