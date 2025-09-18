// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakingContract.sol";

contract TestStakingContract is Test {
       StakingContract c;
       address owner = address(this);

       receive() external payable {}



}
