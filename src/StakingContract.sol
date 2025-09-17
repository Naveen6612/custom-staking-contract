// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract StakingContract is ERC20 {

    uint256 totalStake;
    mapping(address => uint) stakes;
    constructor() ERC20("Orca", "Orc") {

    }
    function Stake() public payable{
        require(msg.value > 0);
        stakes[msg.sender] += msg.value;
        totalStake += msg.value;
        
    }
    function unstake(uint256 _amount) public payable {
        require(_amount > 0);
        require(stakes[msg.sender] >= _amount);
        payable(msg.sender).transfer(_amount);
        stakes[msg.sender] -= _amount;
        totalStake -= _amount;
    }
    function claimRerwards() public {

    }
    function balanceof(address _address) public view returns(uint) {
        return stakes[_address];
    } 

}