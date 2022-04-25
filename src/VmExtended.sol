// SPDX-License-Identifier: APACHE-2.0
pragma solidity ^0.8.0;

import { IERC20 } from "./interfaces/IERC20.sol";
import { IERC721 } from "./interfaces/IERC721.sol";
import { Test } from "../lib/forge-std/src/Test.sol";
import { Constants } from "./Constants.sol";

/**
* @dev VmExtended is a set of functions designed to make
*      token interactions on mainnet forks more seamless.
*      They provide a more efficient alternative
*      to creating token mocks by allowing developers to test
*      transactions using the mainnet token addresses themselves.
* @notice Any tests made using this contract must be ran on a fork of 
*         EVM compatible mainnets.
*/

/// @dev VmExtended inherits from forge-std Test which itself inherits from DSTest
abstract contract VmExtended is Test, Constants {
    // Initialises a user with 100 ether
    /// @param _id is used to set the private key of the user
    /// @dev returns address funded with ETH
    function initWithETH(uint256 _id) public returns (address) {
        address user = vm.addr(_id);
        vm.deal(user, 100 ether);

        return user;
    }

    /**
    * @param _id sets the private key for the user
    * @param _tokenAddress is used to mock a mainnet transfer of any ERC20 token
    *                      from the token contract itself to the user.
    * @param _amount of tokens to transfer
    */
    /// @dev returns address funded with ERC20 token
    function initWithERC20(
        uint256 _id, 
        address _tokenAddress, 
        uint256 _amount) public returns(address _user, IERC20 _token) {
        IERC20 token = IERC20(_tokenAddress);
        address user = vm.addr(_id);

        vm.startPrank(_tokenAddress);
        token.approve(_tokenAddress, _amount);
        token.transferFrom(_tokenAddress, user, _amount);
        token.approve(user, _amount);
        vm.stopPrank();

        return (user, token);
    }

    /**
    * @param _id sets the private key for the user
    * @param _nftAddress any NFT address on mainnet
    * @param _tokenID mainnet tokenID
    * @param _owner current owner on mainnet 
    */
    /// @dev returns address with NFT
    function initWithNFT(
        uint256 _id, 
        address _nftAddress, 
        uint256 _tokenId, 
        address _owner) public returns (address _user, IERC721 _nft) {

        IERC721 nft = IERC721(_nftAddress);
        address user = vm.addr(_id);

        vm.startPrank(_owner);
        nft.approve(user, _tokenId);
        nft.transferFrom(_owner, user, _tokenId);
        vm.stopPrank();

        return (user, nft);
    }

    /// @dev returns an address funded with ETH and any ERC20 on mainnet
    function fullyFunded(
        uint256 _id, 
        address _tokenAddress, 
        uint256 _amount) public returns (address _user, IERC20 _token) {
    
        IERC20 token = IERC20(_tokenAddress);
        address user = vm.addr(_id);

        vm.startPrank(_tokenAddress);
        token.approve(_tokenAddress, _amount);
        token.transferFrom(_tokenAddress, user, _amount);
        token.approve(user, _amount);
        vm.stopPrank();

        vm.deal(user, 100 ether);

        return (user, token);
    }

    function tokenMultiInit(
        address _first, 
        address _second, 
        address _third) public pure returns (IERC20 _token1, IERC20 _token2, IERC20 _token3) {

            IERC20 token1 = IERC20(_first);
            IERC20 token2 = IERC20(_second);
            IERC20 token3 = IERC20(_third);

            return (token1, token2, token3);
    }

}