//SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import {OurToken} from "src/OurToken.sol";
import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";

contract OurTokenTest is Test{

    OurToken public ourT;
    DeployOurToken public deployOurToken;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    function setUp() public{      
        deployOurToken = new DeployOurToken();
        ourT = deployOurToken.run();

        vm.prank(msg.sender);
        ourT.transfer(bob, 10 ether);
    }

    function testbalanceof() public {
        assertEq(ourT.balanceOf(bob), 10 ether);
        assertEq(ourT.balanceOf(alice), 0);
    }

    function testAllowances() public {
        uint256 initialAllowance = 100;
        
        //Bob approves Alice to spend 100 tokens
        vm.prank(bob);
        ourT.approve(alice, initialAllowance);

        uint256 transferAmount = 50;
        vm.prank(alice);
        ourT.transferFrom(bob, alice, transferAmount);

        assertEq(ourT.balanceOf(bob), 10 ether - transferAmount);
        assertEq(ourT.balanceOf(alice), transferAmount);

    }

}