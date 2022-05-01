// SPDX-License-Identifier: APACHE-2.0
pragma solidity ^0.8.0;

abstract contract Constants {
    /// chainid constants
    uint256 public constant ETHEREUM = 1;
    uint256 public constant OPTIMISM = 10;
    uint256 public constant ARBITRUM = 42161;
    uint256 public constant POLYGON = 137;

     /// Uniswap v2 constants
    address public constant UNI_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public constant UNI_V2_FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    /// Uniswap v3 constants
    address public constant UNI_V3_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public constant UNI_V3_FACTORY = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

    /// Kleros constants
    address public constant KLEROS_LIQ = 0x988b3A538b618C7A603e1c11Ab82Cd16dbE28069;
    address public constant KLEROS_PNK = 0x93ED3FBe21207Ec2E8f2d3c3de6e058Cb73Bc04d;

    /// Core Pricefeed IDs
    uint256 public constant ETH_USD = 1;
    uint256 public constant BTC_USD = 2;
    uint256 public constant LINK_USD = 3;
    uint256 public constant DAI_ETH = 4;
    uint256 public constant USDT_ETH = 5;
    uint256 public constant USDC_ETH = 6;

    /// Stablecoin Pricefeed IDs
    uint256 public constant DAI_USD = 7;
    uint256 public constant USDT_USD = 8;
    uint256 public constant USDC_USD = 9;

    /// DeFi Pricefeed IDs
    uint256 public constant COMP_USD = 10;
    uint256 public constant SNX_USD = 11;
    uint256 public constant AAVE_USD = 12;
    uint256 public constant UNI_USD = 13;
    uint256 public constant INCH_USD = 14;
    uint256 public constant YFI_USD = 15;
    uint256 public constant KNC_USD = 16;
}