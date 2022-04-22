<h1 align="center">🧪 VM Extended 🧪</h1>

# Overview

`vm-extended` is a set of functions designed specifically to work with mainnet forks with - eth, arbitrum, optimism, polygon currently supported.

The idea of these functions is to make testing token and nft interactions easy, without needing to write up any mocks of your own. This contract also comes with uniswap v2/v3 router and factory addresses out of the box, as well as a pure function that returns a WETH token address relative to the chain being tested on.

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

## Usage

Inhereting `VmExtended` gives you access to all functions in the [forge standard library](https://github.com/foundry-rs/forge-std)

Access cheatcodes with `vm_extended.`

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { VmExtended } from "../VmExtended.sol";
import { IERC20 } from "../interfaces/IERC20.sol";
import { IERC721 } from "../interfaces/IERC721.sol";

contract ContractTest is VmExtended {
    // ....
    // ....
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

# References

See [forge-std](https://github.com/foundry-rs/forge-std) for usage guide
