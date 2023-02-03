  // SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './Animal.sol';
import './StringCompare.sol';

 contract Herbivore is Animal{
    string constant PLANT = "plant";

     function eat(string memory food) override pure public onlyPlant(food) returns(string memory) {
         return super.eat(food); // calling parent implementation 
     }

     modifier onlyPlant(string memory food) {
         require(StringCompare.compare(food, PLANT), "This animal can`t eat that!(only plant)");
         _;
     }

 }