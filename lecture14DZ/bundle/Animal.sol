 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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