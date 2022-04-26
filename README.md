<h1 align="center">🧪 VM Extended 🧪</h1>

# Overview

`vm-extended` is a set of functions built ontop of DSTest and designed specifically to work with mainnet forks with - eth, arbitrum, optimism, polygon currently supported.

The idea of these functions is to make testing token and nft interactions easy, without needing to write up any mocks of your own. Vm Extended also comes with `Fetcher`, a contract used to quickly initialise Chainlink pricefeeds and fetch common token addresses relative to chainid selected. The Fetcher contract inherits from a set of constants which can be accessed in any contract using vm-extended.

## Installation

Make sure you have [foundry](https://book.getfoundry.sh/getting-started/installation.html) installed

### Getting Started

Create new forge project

```shell
    forge init <your_project_name>
    cd <your_project_name>
```

### Installing vm-extended

```shell
    forge install xpriment626/vm-extended
```

## Usage & Examples

Access cheatcodes with `vm_extended.<function>`

On top of the main functionalities in VmExtended, you'll also get access to important constants such as Chainlink price feeds, Uniswap routers, and essential tokens like DAI, USDC, and wETH which are accessed through their respective fetch functions in the Fetcher contract.

Vm Extended's main usecase is in testing, but these extra helper contracts offer some convenience in development. Save time that you would've otherwise spent looking up the same deployment addresses over and over again.

### Everything in one line of code

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { VmExtended } from "../VmExtended.sol";
import { AggregatorV3Interface } from "../interfaces/AggregatorV3Interface.sol";

contract ContractTest is VmExtended {
    AggregatorV3Interface pricefeedEth = useCorePricefeed(ETH_USD);
    AggregatorV3Interface pricefeedDai = useStablecoinPricefeed(DAI_USD);
    AggregatorV3Interface pricefeedSnx = useDeFiPricefeed(SNX_USD);
}
```

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { VmExtended } from "../VmExtended.sol";
import { IERC20 } from "../interfaces/IERC20.sol";

contract ContractTest is VmExtended {

    (IERC20 weth,
     IERC20 dai,
     IERC20 usdc) = tokenMultiInit(fetchWETH(ETHEREUM), fetchDAI(ETHEREUM), fetchUSDC(ETHEREUM));

     // wETH DAI and USDC come with fetchers out of the box
     // other ERC20 tokens will need manual address inputs
}
```

### Example `initWithNFT()`

Initialises an account with any NFT deployed to mainnet

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { VmExtended } from "../VmExtended.sol";
import { IERC20 } from "../interfaces/IERC20.sol";
import { IERC721 } from "../interfaces/IERC721.sol";

contract ContractTest is VmExtended {

    function testNFTinitAccount() public {
        /// @notice tested with babydoge army nft and one of their owners
        uint256 tokenId = 860;
        address nftAddress = 0xd9F092BdF2b6eaF303fc09cc952e94253AE32fae;
        address nftOwner = 0xE9B2A9EEAB0Be19980eB6B7e1bceA4A8Ce7789b0;

        (address annie, IERC721 nft) = initWithNFT(45, nftAddress, tokenId, nftOwner);

        address newOwner = nft.ownerOf(tokenId);

        assertEq(annie, newOwner);
    }

}
```

### Example: `Init fullyFunded()`

```solidity
function testFullFunding() public {
        /// Ethereum ChainID: 1
        address wethAddress = fetchWrapped(1);
        uint256 tokenVal = 50000;
        (address bob, IERC20 weth) = fullyFunded(69, wethAddress, tokenVal);

        uint256 balanceEth = address(bob).balance;
        uint256 expectEth = 100 ether;
        uint256 balanceERC20 = weth.balanceOf(bob);

        assertEq(balanceEth, expectEth);
        assertEq(balanceERC20, tokenVal);
    }
```
