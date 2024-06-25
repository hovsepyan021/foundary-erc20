// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {OpenZeppelinToken} from "../src/OpenZeppelinToken.sol";

contract DeployOpenZeppelinToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function setUp() public {}

    function run() public returns(OpenZeppelinToken) {
        vm.startBroadcast();
        OpenZeppelinToken ourToken = new OpenZeppelinToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ourToken;
    }
}
