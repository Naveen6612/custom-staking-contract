// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IOrcaCoin {
    function mint(address to , uint256 amount) external ;
}

contract StakingContract {
    IOrcaCoin public orcaCoin;
    uint256 totalStake;
    uint REWARD_EVERY_SEC = 1;

    struct UserInfo {
        uint stakedAmount;
        uint totalReward;
        uint lastUpdatedTime;
    }
    mapping(address => UserInfo) public userInfo;

    constructor(IOrcaCoin _token)  {
        orcaCoin = _token;
    }

    function _updateRewards(address _user) internal {
            UserInfo storage user = userInfo[_user];

            if(user.lastUpdatedTime == 0){
                user.lastUpdatedTime = block.timestamp;
                return;
            }
            uint timeDiff = block.timestamp - user.lastUpdatedTime;
            if(timeDiff == 0) {
                return;
            }

            uint newReward = (user.stakedAmount * timeDiff * REWARD_EVERY_SEC);

            user.totalReward += newReward;
            user.lastUpdatedTime = block.timestamp;

    }

    function Stake(uint _amount) public payable{
        require(msg.value > 0);
        require(msg.value == _amount);

        _updateRewards(msg.sender);

        userInfo[msg.sender].stakedAmount += msg.value; 
        totalStake += _amount;
    }
    function unstake(uint256 _amount) public payable {
        require(_amount > 0);
        UserInfo storage user = userInfo[msg.sender];
        require(user.stakedAmount >= _amount);

        _updateRewards(msg.sender);
        totalStake -= _amount;
        user.stakedAmount -= _amount;

        payable(msg.sender).transfer(_amount);
    }
    function claimRerwards() public {
        _updateRewards(msg.sender);
        UserInfo storage user = userInfo[msg.sender];
        uint256 amount = user.stakedAmount;
        orcaCoin.mint(msg.sender, amount);

        amount = 0;
    }
    function getRewards() public returns(uint256){
        _updateRewards(msg.sender);
        UserInfo storage user = userInfo[msg.sender];

        return user.totalReward;
    }
    function balanceof(address _address) public view returns(uint) {
        return userInfo[_address].stakedAmount;
    } 

}