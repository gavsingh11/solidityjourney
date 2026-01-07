// SPDX-License-Identifier: MIT

// Fund
// Withdraw

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_AMOUNT = 0.1 ether;

    function fundFundMe(address mostRecentlyDepolyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDepolyed)).fund{value: SEND_AMOUNT}();
        vm.stopBroadcast();
        console.log("Funded FundMe contract with %s ETH", SEND_AMOUNT);
    }

    function run() external {
        address mostRecentlyDepolyed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        // vm.startBroadcast();
        fundFundMe(mostRecentlyDepolyed);
        // vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    uint256 constant SEND_AMOUNT = 0.1 ether;

    function withdrawFundMe(address mostRecentlyDepolyed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDepolyed)).withdraw();
        vm.stopBroadcast();
        console.log("Withdrew from FundMe contract");
    }

    function run() external {
        address mostRecentlyDepolyed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        // vm.startBroadcast();
        withdrawFundMe(mostRecentlyDepolyed);
        // vm.stopBroadcast();
    }
}
