// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Vm } from "./interfaces/Vm.sol";
import { DSTest } from "../lib/ds-test/src/test.sol";
import { IERC20 } from "./interfaces/IERC20.sol";

error UnknownChain();

/**
* @dev VmExtended is a set of functions designed to make
*      token interactions on mainnet forks more seamless.
*      They provide a more efficient alternative
*      to creating token mocks by allowing developers to test
*      transactions using the mainnet token addresses themselves.
* @notice Any tests made using this contract must be ran on a fork of 
*         EVM compatible mainnets.
*/
abstract contract VmExtended is DSTest {

    /// Initialises vm_extended with HEVM address
    Vm public constant vm_extended = Vm(HEVM_ADDRESS);

    /// Uniswap v2 constants
    address public constant UNI_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public constant UNI_V2_FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    /// Uniswap v3 constants
    address public constant UNI_V3_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public constant UNI_V3_FACTORY = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

    // Initialises a user with 100 ether
    /// @param _id is used to set the private key of the user
    function initWithETH(uint256 _id) public returns (address) {
        address user = vm_extended.addr(_id);
        vm_extended.deal(user, 100 ether);

        return user;
    }

    /**
    * @param _id sets the private key for the user
    * @param _tokenAddress is used to mock a mainnet transfer of any ERC20 token
    *                      from the token contract itself to the user.
    * @param _amount of tokens to transfer
    */
    function initWithERC20(uint256 _id, address _tokenAddress, uint256 _amount) public returns(address) {
        IERC20 token = IERC20(_tokenAddress);
        address user = vm_extended.addr(_id);

        vm_extended.startPrank(_tokenAddress);
        token.approve(_tokenAddress, _amount);
        token.transferFrom(_tokenAddress, user, _amount);
        token.approve(user, _amount);
        vm_extended.stopPrank();

        return user;
    }

    /**
    * @param chain must be passed in as an all lowercase string
    * 1. "ethereum"
    * 2. "optimism"
    * 3. "arbitrum"
    * 3. "polygon"
    */
    function fetchWrapped(string calldata chain) public pure returns (address) {
        if (keccak256(abi.encodePacked(chain)) == keccak256(abi.encodePacked("ethereum"))) {
            return 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        } else if (keccak256(abi.encodePacked(chain)) == keccak256(abi.encodePacked("optimism"))) {
            return 0x4200000000000000000000000000000000000006;
        } else if (keccak256(abi.encodePacked(chain)) == keccak256(abi.encodePacked("arbitrum"))) {
            return 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
        } else if (keccak256(abi.encodePacked(chain)) == keccak256(abi.encodePacked("polygon"))) {
            return 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;
        } else revert UnknownChain();
    }

}
