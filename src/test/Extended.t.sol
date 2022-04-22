// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { VmExtended } from "../VmExtended.sol";
import { IERC20 } from "../interfaces/IERC20.sol";

contract ContractTest is VmExtended {
    function setUp() public {}

    function testEthFunding() public {
        address annie = initWithETH(123);
        
        uint256 expected = 100 ether;
        uint256 balance = address(annie).balance;

        assertEq(expected, balance);
    }

    function testERCFunding() public {
        address wethAddress = fetchWrapped(1);
        (address bob, IERC20 weth) = initWithERC20(2, wethAddress, 50000);

        uint256 expected = 50000; 
        uint256 balance = weth.balanceOf(bob);

        assertEq(expected, balance);
    } 
}
