// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakingContract.sol";

contract TestStakingContract is Test {
       StakingContract c;
       address owner = address(this);

       receive() external payable {}
       function setUp() public {
        c = new StakingContract();
       }

       function testStake() public {
            c.Stake{value: 200}();
            assert(c.balanceof(owner) == 200);
       }

       function testUnstake() public {
        c.Stake{value:200}();
        c.unstake(200);
        assert(c.balanceof(owner) == 0);
       }

       function test_RevertWhen_UnstakeFail() public {
          c.stake{value:200}();
          vm.expectRevert();
          c.unstake(300);

       }
}
