// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Color {
    function uintToHex(uint256 number) public pure returns (string memory) {
        // Convert uint to hexadecimal string
        return toHexString(number);
    }

    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        
        uint256 temp = value;
        uint256 length = 0;
        
        while (temp > 0) {
            length++;
            temp /= 16;
        }

        bytes memory buffer = new bytes(length);
        while (value > 0) {
            length--;
            uint8 remainder = uint8(value % 16);
            bytes1 byteValue = toAsciiChar(remainder);
            buffer[length] = byteValue;
            value /= 16;
        }

        return string(buffer);
    }

    function toAsciiChar(uint8 value) internal pure returns (bytes1) {
        if (value < 10) {
            return bytes1(uint8(48 + value));
        } else {
            return bytes1(uint8(87 + value)); // ASCII for 'a' is 97, so 87 + 10 = 97
        }
    }
}