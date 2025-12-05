// get funds from users, withdraw funds, set min USD amount fundable
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

uint256 public minimumUsd = 5 * 1e18;

address[] public funders;
mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

address public owner;

constructor() {
    owner = msg.sender;
}

function fund() public payable  {
    require(msg.value.getConversionRate() >= minimumUsd, "You need to spend more ETH!"); //18 decimal places
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value;
}

function withdraw() public onlyOwner {

// for loop
//for(starting index, ending index, step amount)
for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
    address funder = funders[funderIndex];
    addressToAmountFunded[funder] = 0;
}
    // reset the array
    funders = new address[](0);
    // actually withdraw the funds

    // // transfer
    // // msg.sender = address
    // // payable(msg.sender) = payable address
    // payable(msg.sender.transfer(address(this).balance);

    // // send
    // bool sendSuccess = payable(msg.sender.send(address(this).balance);
    // require(sendSuccess, "Send Failed");
    
    // call
    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

}

modifier onlyOwner() {
     require(msg.sender == owner, "Only owner can withdraw funds");
     _; // code executed after the modifier can be intertwined in positions depending on priority
}

}


