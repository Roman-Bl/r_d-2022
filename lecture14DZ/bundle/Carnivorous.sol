 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './Animal.sol';
import './StringCompare.sol';

contract Carnivorous is Animal {

    function eat(string memory food) override pure public onlyMeat(food) returns(string memory) {
         return super.eat(food); // calling parent implementation 
     }

    modifier onlyMeat(string memory food) {
         require(StringCompare.compare(food, MEAT), "This animal can`t eat that!(only meat)");
         _;
     }
}