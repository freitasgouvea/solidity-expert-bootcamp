// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;

contract Div {

    function divSolidity(uint256 numerator, uint256 denominator) public pure returns (uint256 result){
        result = numerator / denominator; 
    }

    function divAssembly(uint256 numerator, uint256 denominator) public pure returns (uint256 result){
        assembly {
            result := div(numerator, denominator) 
        }
    }
}