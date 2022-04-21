// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import { Vm } from "./interfaces/Vm.sol";
import { DSTest } from "../lib/ds-test/src/test.sol";
import { IERC20 } from "./interfaces/IERC20.sol";

/**
@dev VmExtended is a set of functions designed to make
*    token interactions on mainnet forks more seamless.
*    They provide a more efficient alternative
*    to creating token mocks by allowing developers to test
*    transactions using the mainnet token addresses themselves.
*/
abstract contract VmExtended is DSTest {

    /// Initialises vm_extended with HEVM address
    Vm public constant vm_extended = Vm(HEVM_ADDRESS);

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

}
