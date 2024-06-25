// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DeployOpenZeppelinToken} from "../script/DeployOpenZeppelinToken.s.sol";
import {OpenZeppelinToken} from "../src/OpenZeppelinToken.sol";

contract OpenZeppelinTokenTest is Test {
    OpenZeppelinToken private ourToken;
    DeployOpenZeppelinToken private deployer;
    uint256 bobStartingAmount = 1 ether;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    function setUp() public {
        deployer = new DeployOpenZeppelinToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, bobStartingAmount);
    }

    function test_BobBalance() public {
        assertEq(ourToken.balanceOf(bob), 1 ether);
    }

    function test_Allowance() public {
        uint256 initialAllowance = 1000;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), bobStartingAmount - transferAmount);
    }

    function test_TransferBetweenAccounts() public {
        uint256 transferAmount = 0.5 ether;

        vm.prank(bob);
        ourToken.transfer(alice, transferAmount);

        assertEq(ourToken.balanceOf(bob), bobStartingAmount - transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
    }

    function test_ApproveAndTransferFromMultipleTimes() public {
        uint256 initialAllowance = 1000;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 firstTransferAmount = 400;
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, firstTransferAmount);

        assertEq(ourToken.balanceOf(alice), firstTransferAmount);
        assertEq(ourToken.allowance(bob, alice), initialAllowance - firstTransferAmount);

        uint256 secondTransferAmount = 600;
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, secondTransferAmount);

        assertEq(ourToken.balanceOf(alice), firstTransferAmount + secondTransferAmount);
        assertEq(ourToken.balanceOf(bob), bobStartingAmount - (firstTransferAmount + secondTransferAmount));
    }
}
