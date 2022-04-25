// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { VmExtended } from "../VmExtended.sol";
import { IERC20 } from "../interfaces/IERC20.sol";
import { IERC721 } from "../interfaces/IERC721.sol";

contract ContractTest is VmExtended {
    function setUp() public {}

    function testEthFunding() public {
        address annie = initWithETH(123);
        
        uint256 expected = 100 ether;
        uint256 balance = address(annie).balance;

        assertEq(expected, balance);
    }

    function testERCFunding() public {
        /// Ethereum ChainID: 1
        address wethAddress = fetchWETH(ETHEREUM);
        uint256 tokenVal = 50000;
        (address bob, IERC20 weth) = initWithERC20(2, wethAddress, tokenVal);

        uint256 balance = weth.balanceOf(bob);

        assertEq(tokenVal, balance);
    } 

    function testWrappedToken() public {
        /// Polygon ChainID: 137
        address wMatic = fetchWETH(POLYGON);
        address wMaticAddress = 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;

        assertEq(wMatic, wMaticAddress);
    }

    function testNFTinitAccount() public {
        /// @notice tested with babydoge army nft and one of their owners
        uint256 tokenId = 860;
        address nftAddress = 0xd9F092BdF2b6eaF303fc09cc952e94253AE32fae;
        address nftOwner = 0xE9B2A9EEAB0Be19980eB6B7e1bceA4A8Ce7789b0;

        (address charlie, IERC721 nft) = initWithNFT(45, nftAddress, tokenId, nftOwner);

        address newOwner = nft.ownerOf(tokenId);

        assertEq(charlie, newOwner);
    }

    function testFullFunding() public {
        /// Ethereum ChainID: 1
        address wethAddress = fetchWETH(ETHEREUM);
        uint256 tokenVal = 50000;
        (address dave, IERC20 weth) = fullyFunded(69, wethAddress, tokenVal);

        uint256 balanceEth = address(dave).balance;
        uint256 expectEth = 100 ether;
        uint256 balanceERC20 = weth.balanceOf(dave);

        assertEq(balanceEth, expectEth);
        assertEq(balanceERC20, tokenVal);
    }
}
