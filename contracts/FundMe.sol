// get funds from users, withdraw funds, set min USD amount fundable
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe {

uint256 public minimumUsd = 5 * 1e18;

function fund() public payable  {
    require(getConversionRate(msg.value) >= minimumUsd, "You need to spend more ETH!"); //18 decimal places
}

// function withdraw() public {}
function getPrice() public view returns(uint256) {
    // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
    // ABI done by importing
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 price,,,) = priceFeed.latestRoundData();
    // price of eth in terms of usd look like 2000.00000000 no decimals shown but at 8 decimal places
    return uint256(price * 1e10);
}   
function getConversionRate(uint256 ethAmount) public view returns(uint256) {
    uint256 ethPrice = getPrice();
    uint256 ethAmountInUSD = (ethPrice * ethAmount)/ 1e18;
    return ethAmountInUSD;
}



}
