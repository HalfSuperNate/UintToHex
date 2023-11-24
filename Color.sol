// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract Color {
    // Color & Alpha/Opacity
    // 4 Channels (Red, Green, Blue, Alpha)
    // Each channel is equal to a uint slider 0 - 255
    // If Alpha channel is omitted color will default to full Alpha
    // 255 = ff (full channel)

    function uintToColorHex(bool prependHash, uint256 red, uint256 green, uint256 blue, uint256 alpha) public pure returns (string memory) {
        string memory _alpha = "";
        if (!compareHexStrings(bytes(toHexString(alpha)), bytes("ff"))) {
            // set alpha if not full
            _alpha = toHexString(alpha);
        }
        
        if(prependHash){
            return string(abi.encodePacked("#", toHexString(red), toHexString(green), toHexString(blue), _alpha));
        } else{
            return string(abi.encodePacked(toHexString(red), toHexString(green), toHexString(blue), _alpha));
        }
    } 

    function uintToHex(uint256 number) public pure returns (string memory) {
        // Convert uint to hexadecimal string
        return toHexString(number);
    }

    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "00";  // Special case for zero
        }
        
        uint256 temp = value;
        uint256 length = 0;
        
        while (temp > 0) {
            length++;
            temp /= 16;
        }

        // Ensure even length
        if (length % 2 != 0) {
            length++;
        }

        bytes memory buffer = new bytes(length);
        while (value > 0) {
            length--;
            uint8 remainder = uint8(value % 16);
            bytes1 byteValue = toAsciiChar(remainder);
            buffer[length] = byteValue;
            value /= 16;
        }

        // Prepend "0" if the length is one
        if (length == 1) {
            return string(abi.encodePacked("0", buffer));
        } else {
            return string(buffer);
        }
    }

    function toAsciiChar(uint8 value) internal pure returns (bytes1) {
        if (value < 10) {
            return bytes1(uint8(48 + value));
        } else {
            return bytes1(uint8(87 + value)); // ASCII for 'a' is 97, so 87 + 10 = 97
        }
    }

    function compareHexStrings(bytes memory a, bytes memory b) internal pure returns (bool) {
        if (a.length != b.length) {
            return false;
        }

        for (uint i = 0; i < a.length; i++) {
            if (a[i] != b[i]) {
                return false;
            }
        }

        return true;
    }
}
