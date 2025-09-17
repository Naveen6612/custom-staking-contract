// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import { ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract OrcaContract is ERC20 {
    address owner;
    address stakingAddress;
    constructor(address _stakingAddress)ERC20("Orca", "Orc"){
        stakingAddress = _stakingAddress;
        owner = msg.sender;
    }

    function mint(address _stakingAddress , uint256 _value) public {
        require(msg.sender == _stakingAddress);
        _mint(stakingAddress, _value);
    }

    function updateStakingAddress(address _stakingAddress) public {
        require(msg.sender == owner);
        stakingAddress = _stakingAddress;
    }
 }
