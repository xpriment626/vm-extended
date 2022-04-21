// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import { Vm } from "./Vm.sol";
contract VmExtended {

    // Initialises vm_extended with HEVM address
    Vm public constant vm_extended = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
}
