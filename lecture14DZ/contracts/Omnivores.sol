 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './Animal.sol';
import './StringCompare.sol';

contract Omnivores is Animal {
    string constant MEAT = "meat";
    string constant PLANT = "plant";


    function eat(string memory food) virtual override pure public meatAndPlant(food) returns(string memory) {
         return super.eat(food); // calling parent implementation 
     }

    modifier meatAndPlant (string memory food) {
         require(StringCompare.compare(food, MEAT) || StringCompare.compare(food, PLANT), "This animal can`t eat that!(only meat and plant)");
         _;
     }
}