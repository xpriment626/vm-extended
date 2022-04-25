// SPDX-License-Identifier: APACHE-2.0
pragma solidity ^0.8.0;

error UnknownChain();
abstract contract Fetchers {
    /// chainid constants
    uint256 public constant ETHEREUM = 1;
    uint256 public constant OPTIMISM = 10;
    uint256 public constant ARBITRUM = 42161;
    uint256 public constant POLYGON = 137;

    /**
    * @param _chainId mainnet chain ids
    * 1 = "ethereum"
    * 10 = "optimism"
    * 42161 = "arbitrum"
    * 137 = "polygon"
    */
    function fetchWETH(uint256 _chainId) public pure returns (address) {
        if (_chainId== ETHEREUM) {
            return 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        } else if (_chainId== OPTIMISM) {
            return 0x4200000000000000000000000000000000000006;
        } else if (_chainId== ARBITRUM) {
            return 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1;
        } else if (_chainId== POLYGON) {
            return 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;
        } else revert UnknownChain();
    }

    function fetchDAI(uint256 _chainId) public pure returns (address) {
        if (_chainId== ETHEREUM) {
            return 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        } else if (_chainId== OPTIMISM || _chainId== ARBITRUM) {
            return 0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1;
        } else if (_chainId== POLYGON) {
            return 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
        } else revert UnknownChain();
    }

    function fetchUSDC(uint256 _chainId) public pure returns (address) {
        if (_chainId== ETHEREUM) {
            return 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        } else if (_chainId== OPTIMISM) {
            return 0x7F5c764cBc14f9669B88837ca1490cCa17c31607;
        } else if (_chainId== ARBITRUM) {
            return 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8;
        } else if (_chainId== POLYGON) {
            return 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
        } else revert UnknownChain();
    }
}