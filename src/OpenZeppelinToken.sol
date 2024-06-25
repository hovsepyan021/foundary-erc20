// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OpenZeppelinToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("OpenZeppelinToken", "OZT") {
        _mint(msg.sender, initialSupply);
    }
}
