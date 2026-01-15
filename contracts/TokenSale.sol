// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenSale is ReentrancyGuard, Ownable {
    IERC20 public token;
    uint256 public rate; // tokens per ETH
    uint256 public tokensSold;
    uint256 public endTime;
    
    // Sale phases with different rates
    enum Phase { Seed, General, Open }
    Phase public currentPhase;
    mapping(Phase => uint256) public phaseRates;
    mapping(Phase => uint256) public phaseCaps;

    event TokensPurchased(address buyer, uint256 amountETH, uint256 amountTokens);
    event PhaseAdvanced(Phase newPhase);

    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Token address cannot be zero");
        token = IERC20(_tokenAddress);
        
        // Initialize phase rates (tokens/ETH)
        phaseRates[Phase.Seed] = 1000;
        phaseRates[Phase.General] = 500;
        phaseRates[Phase.Open] = 250;
        
        // Initialize phase caps (max tokens sellable)
        phaseCaps[Phase.Seed] = 100000 * 10**18;
        phaseCaps[Phase.General] = 500000 * 10**18;
        phaseCaps[Phase.Open] = type(uint256).max;
        
        currentPhase = Phase.Seed;
        rate = phaseRates[Phase.Seed];
        endTime = block.timestamp + 30 days;
    }

    function buyTokens() external payable nonReentrant {
        require(block.timestamp < endTime, "Sale ended");
        require(msg.value > 0, "Send ETH to buy tokens");
        
        uint256 tokenAmount = msg.value * rate;
        uint256 phaseCap = phaseCaps[currentPhase];
        
        require(tokensSold + tokenAmount <= phaseCap, "Exceeds phase cap");
        require(token.balanceOf(address(this)) >= tokenAmount, "Insufficient tokens in sale contract");

        tokensSold += tokenAmount;
        token.transfer(msg.sender, tokenAmount);
        
        emit TokensPurchased(msg.sender, msg.value, tokenAmount);
    }

    function advancePhase() external onlyOwner {
        require(currentPhase != Phase.Open, "Already in final phase");
        
        if (currentPhase == Phase.Seed) {
            currentPhase = Phase.General;
        } else if (currentPhase == Phase.General) {
            currentPhase = Phase.Open;
        }
        
        rate = phaseRates[currentPhase];
        emit PhaseAdvanced(currentPhase);
    }

    function withdrawETH() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH to withdraw");
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "ETH transfer failed");
    }

    function remainingTokens() external view returns (uint256) {
        return token.balanceOf(address(this));
    }
}