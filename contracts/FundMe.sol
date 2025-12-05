// get funds from users, withdraw funds, set min USD amount fundable
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract FundMe {

uint256 public minimumUsd = 5;

function fund() public payable  {
    require(msg.value >= minimumUsd, "didn't send enough!");
}

// function withdraw() public {}

}