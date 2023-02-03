// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './Carnivorous.sol';
import './Herbivore.sol';
import './Omnivores.sol';
import './Animal.sol'; // for farmer


abstract contract HasName {
    string name;
    constructor(string memory _name) {
        name = _name;
    }
    function getName() view public returns(string memory) {
        return name;
    }
}

 contract Cow is Herbivore, HasName {
     constructor(string memory name) HasName(name) {
     }

    function speak() override pure public returns(string memory) {
         return "Mooo";
     }
 }

 contract Horse is Herbivore, HasName {
     constructor(string memory name) HasName(name) {}
     
     function speak() override pure public returns(string memory) {
         return "Igogo";
     }
 }
contract Wolf is Carnivorous, HasName {
     constructor(string memory name) HasName(name) {}
     
     function speak() override pure public returns(string memory) {
         return "Awooo";
     }
 }

 contract Dog is Omnivores, HasName {
    // string constant FOOD_RESTRICTED = "chocolate";
     constructor(string memory name) HasName(name) {}

    function speak() override pure public returns(string memory) {
         return "Woof";
     }
     
 } 


 contract Farmer {
     function feed(address animal,string memory food) pure public returns(string memory) {
         return Animal(animal).eat(food);
     }
     
     function call(address animal) pure public returns(string memory) {
         return Animal(animal).speak();
        
     }
 }

