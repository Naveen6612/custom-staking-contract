// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/OrcaContract.sol";

contract TestContract is Test {
    OrcaContract orcaCoin;
    address owner = address(this);

    function setUp() public {
        orcaCoin = new OrcaContract(owner);
    }
    function testInitialSupply() public  {
        assertEq(orcaCoin.totalSupply(), 0);
    }
    
    function test_RevertWhen_MintFail() public {
        vm.expectRevert();
        vm.startPrank(0x0c0670fcb07D4ddD35cf9417AF2aF36F6F0F2156);
        orcaCoin.mint(address(this), 10);

    }
    function testMint() public {
        orcaCoin.mint(owner, 10);
        assert(orcaCoin.balanceOf(owner) == 10);
    }

    function testChangeStakingContact() public {
        orcaCoin.updateStakingAddress(0x0c0670fcb07D4ddD35cf9417AF2aF36F6F0F2156);
        vm.startPrank(0x0c0670fcb07D4ddD35cf9417AF2aF36F6F0F2156);
        orcaCoin.mint(0x0c0670fcb07D4ddD35cf9417AF2aF36F6F0F2156, 10);
        orcaCoin.balanceOf(0x0c0670fcb07D4ddD35cf9417AF2aF36F6F0F2156)==10;
    }
}
