// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Math { 
    // max _size 25
    function fibonacci16(uint8 _size) public pure returns (uint16[] memory _result) {
        uint16[] memory result = new uint16[](_size);
        result[0] = 0;
        if (_size >= 2) {
            result[1] = 1;
            for (uint i = 2; i < _size; i++) {
                uint16 next = result[i - 1] + result[i - 2];
                result[i] = next;
            }
        }
        return result;
    }

    // max _size 48
    function fibonacci32(uint8 _size) public pure returns (uint32[] memory _result) {
        uint32[] memory result = new uint32[](_size);
        result[0] = 0;
        if (_size >= 2) {
            result[1] = 1;
            for (uint i = 2; i < _size; i++) {
                uint32 next = result[i - 1] + result[i - 2];
                result[i] = next;
            }
        }
        return result;
    }
}
