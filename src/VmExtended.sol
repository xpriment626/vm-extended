// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import { Vm } from "./interfaces/Vm.sol";
import { DSTest } from "../lib/ds-test/src/test.sol";
import { IERC20 } from "./interfaces/IERC20.sol";
contract VmExtended is DSTest {

    // Initialises vm_extended with HEVM address
    Vm public constant vm_extended = Vm(HEVM_ADDRESS);

    function initWithETH(uint256 _id) public returns (address) {
        address user = vm_extended.addr(_id);
        vm_extended.deal(user, 100 ether);

        return user;
    }

}
