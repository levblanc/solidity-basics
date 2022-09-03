// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import './PriceConverter.sol';

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        // Want to be able to set a minimum fund amount in USD
        // 1. How to we send ETH to this contract?
        require(msg.value.getConversionRate() >= minimumUsd, "Did'nt send enough!");

        // What is reverting?
        // Undo any actions before, and send remaining gas back

        // keep track of funders of the contract
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; 
        }

        // reset the array
        funders = new address[](0);

        // actually withdraw the funds
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}('');
        require(callSuccess, 'Call failed');
    }
}

