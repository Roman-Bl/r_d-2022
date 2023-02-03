// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


/* OOP
* 1 - encapsulation
* 2 - inheritance
* 3 - abstraction
* 4 - polymorphism 
*/ 

library StringCompare {
    // functionality for comparing strings (copied wrom web)
    function compare(string memory str1, string memory str2) public pure returns (bool) {
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }
}


 abstract contract Animal {
    string constant PLANT = "plant";
    string constant MEAT = "meat";


     function eat(string memory) virtual pure public returns(string memory) {
         return "Nom-nom";
     }

     function speak() pure virtual public returns(string memory) {
         return "...";
     }

     function sleap() pure public returns(string memory) {
         return "Z-z-z";
     }

 }

 contract Herbivore is Animal{

     function eat(string memory food) override pure public onlyPlant(food) returns(string memory) {
         return super.eat(food); // calling parent implementation 
     }

     modifier onlyPlant(string memory food) {
         require(StringCompare.compare(food, PLANT), "This animal can`t eat that!(only plant)");
         _;
     }

 }

contract Carnivorous is Animal {

    function eat(string memory food) override pure public onlyMeat(food) returns(string memory) {
         return super.eat(food); // calling parent implementation 
     }

    modifier onlyMeat(string memory food) {
         require(StringCompare.compare(food, MEAT), "This animal can`t eat that!(only meat)");
         _;
     }
}


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

