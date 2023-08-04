// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Erc20.sol";

contract Query {

    address erc20Address;
    constructor (address _erc20Address) {
        erc20Address = _erc20Address;
    }

    function query(
        uint _amount, 
        address _receiver, 
        string memory _functionSignature
    ) public {
        bytes memory encodedArgs = abi.encodeWithSignature(_functionSignature, _receiver, _amount);
        ( bool success, ) = address(erc20Address).delegatecall(encodedArgs);
        if(!success) {
            revert();
        }
    }
    
    // Not worked because msg.sender is this contract
    // function query(
    //     uint _amount, 
    //     address _receiver, 
    //     function(address, uint256) external returns (bool) _transfer
    // ) public {
    //     bool success = _transfer(_receiver,_amount);
    // }
}
