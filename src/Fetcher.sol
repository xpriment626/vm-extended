// SPDX-License-Identifier: APACHE-2.0
pragma solidity ^0.8.0;

import { Constants } from "./Constants.sol";
import { AggregatorV3Interface } from "./interfaces/AggregatorV3Interface.sol";

error PricefeedNotFound();
error UnknownChain();
abstract contract Fetcher is Constants {
    /***********************
         Core Pricefeeds
    ************************/
    function useCorePricefeed(uint256 _pricefeedId) public pure returns(AggregatorV3Interface _pricefeed) {
      if (_pricefeedId == ETH_USD) {
        (_pricefeed) = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
      } else if (_pricefeedId == BTC_USD) {
        (_pricefeed) = AggregatorV3Interface(0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c);
      } else if (_pricefeedId == LINK_USD) {
        (_pricefeed) = AggregatorV3Interface(0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c);
      } else if (_pricefeedId == DAI_ETH) {
        (_pricefeed) = AggregatorV3Interface(0x773616E4d11A78F511299002da57A0a94577F1f4);
      } else if (_pricefeedId == USDT_ETH) {
        (_pricefeed) = AggregatorV3Interface(0xEe9F2375b4bdF6387aa8265dD4FB8F16512A1d46);
      } else if (_pricefeedId == USDC_ETH) {
        (_pricefeed) = AggregatorV3Interface(0x986b5E1e1755e3C2440e960477f25201B0a8bbD4);
      } else revert PricefeedNotFound();
    }
    /***********************
      Stablecoin Pricefeeds
    ************************/
    function useStablecoinPricefeed(uint256 _pricefeedId) public pure returns(AggregatorV3Interface _pricefeed) {
      if(_pricefeedId == DAI_USD) {
        (_pricefeed) = AggregatorV3Interface(0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9);
      } else if (_pricefeedId == USDT_USD) {
        (_pricefeed) = AggregatorV3Interface(0x3E7d1eAB13ad0104d2750B8863b489D65364e32D);
      } else if (_pricefeedId == USDC_USD) {
        (_pricefeed) = AggregatorV3Interface(0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6);
      } else revert PricefeedNotFound();
    }
    /***********************
        De-Fi Pricefeeds
    ************************/
    function useDeFiPricefeed(uint256 _pricefeedId) public pure returns (AggregatorV3Interface _pricefeed) {
      if (_pricefeedId == COMP_USD) {
        (_pricefeed) = AggregatorV3Interface(0xdbd020CAeF83eFd542f4De03e3cF0C28A4428bd5);
      } else if (_pricefeedId == SNX_USD) {
        (_pricefeed) = AggregatorV3Interface(0xDC3EA94CD0AC27d9A86C180091e7f78C683d3699);
      } else if (_pricefeedId == AAVE_USD) {
        (_pricefeed) = AggregatorV3Interface(0x547a514d5e3769680Ce22B2361c10Ea13619e8a9);
      } else if (_pricefeedId == UNI_USD) {
        (_pricefeed) = AggregatorV3Interface(0x553303d460EE0afB37EdFf9bE42922D8FF63220e);
      } else if (_pricefeedId == INCH_USD) {
        (_pricefeed) = AggregatorV3Interface(0xc929ad75B72593967DE83E7F7Cda0493458261D9);
      } else if (_pricefeedId == YFI_USD) {
        (_pricefeed) = AggregatorV3Interface(0xA027702dbb89fbd58938e4324ac03B58d812b0E1);
      } else if (_pricefeedId == KNC_USD) {
        (_pricefeed) = AggregatorV3Interface(0x656c0544eF4C98A6a98491833A89204Abb045d6b);
      }  else revert PricefeedNotFound();
    }
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