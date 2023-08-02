// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Amount {
    function deposit() payable public returns(uint256) {
        // solidity
        // return msg.value;

        // assembly
        assembly {
            let a := callvalue()
            mstore(0x1, a)
            return(0x1, 32)
        }
    }
}
