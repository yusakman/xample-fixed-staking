// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract XAMPLEFixedStaking is ERC20 {
    mapping(address => uint256) public staked;
    mapping(address => uint256) private stakedFromTimestamp;
    
    constructor() ERC20("XAMPLE Fixed Staking", "XAMPLE") {
        _mint(msg.sender, 1000000000000000000000000);
    }

    function stake(uint256 amount) public {
        require(amount > 0, "amount is <= 0");
        require(balanceOf(msg.sender) >= amount, "balance is <= amount");

        _transfer(msg.sender, address(this), amount);

        if (staked[msg.sender] > 0) {
            claim();
        }

        stakedFromTimestamp[msg.sender] = block.timestamp;

        staked[msg.sender] += amount;
    }

    function unstaked(uint256 amount) external {
        require(amount > 0, "amount is <= 0");
        require(staked[msg.sender] >= amount, "amount is > staked");

        claim();

        staked[msg.sender] -= amount;

        _transfer(address(this), msg.sender, amount);
    }

    function claim() public {
        require(staked[msg.sender] > 0, "stake is <= 0");

        uint256 secondsStaked = block.timestamp - stakedFromTimestamp[msg.sender];

        uint256 secondsInYear = 31536000;

        uint256 rewards = staked[msg.sender] * secondsStaked / secondsInYear;

        _mint(msg.sender, rewards);

        stakedFromTimestamp[msg.sender] = block.timestamp;
    }
}