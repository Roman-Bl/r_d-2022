// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './Carnivorous.sol';
import './Herbivore.sol';


 contract Cow is Herbivore {

    function speak() override pure public returns(string memory) {
         return "Mooo";
     }
 }

 contract Horse is Herbivore {
     
     function speak() override pure public returns(string memory) {
         return "Igogo";
     }
 }
contract Wolf is Carnivorous {
     
     function speak() override pure public returns(string memory) {
         return "Awooo";
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

