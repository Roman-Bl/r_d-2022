const Cow = artifacts.require("Cow");
const Horse = artifacts.require("Horse");
const Wolf = artifacts.require("Wolf");
const Dog = artifacts.require("Dog");
const Lib = artifacts.require("StringCompare");
const Farmer = artifacts.require("Farmer");
// const Animal = artifacts.require("Animal");
// const Herbivore = artifacts.require("Herbivore");
// console.log(Animals);

let cow;
let horse;
let wolf;
let farmer;
let dog;

module.exports = async (deployer) => {
  await deployer.deploy(Lib);
  await deployer.link(Lib, [Cow, Horse, Wolf, Dog]);
  await deployer.deploy(Cow, "Milka");
  await deployer.deploy(Horse, "Jack");
  await deployer.deploy(Wolf, "Onix");
  await deployer.deploy(Dog, "Nobu");
  await deployer.deploy(Farmer);
  cow = await Cow.deployed();
  horse = await Horse.deployed();
  wolf = await Wolf.deployed();
  dog = await Dog.deployed();
  farmer = await Farmer.deployed();

  //   console.log(cow.address);
  //   let result = await eat(cow, "plant");
  //   console.log(`Cow eat result ${result}`);
  //   let sleapCow = await sleap(cow);
  //   console.log(sleapCow);
  console.log(`Farmer call Cow - ${await call(cow.address)}`);
  console.log(`Farmer call Horse - ${await call(horse.address)}`);
  try {
    let farmerFeed = await feed(wolf.address, "plant");
    console.log(`Farmer feed wolf - ${farmerFeed}`);
  } catch (e) {
    console.log(e.message);
  }
  try {
    farmerFeed = await feed(wolf.address, "meat");
    console.log(`Farmer feed wolf - ${farmerFeed}`);
  } catch (e) {
    console.log(e.message);
  }
};

async function feed(animalAddr, food) {
  return await farmer.feed(animalAddr, food);
}
async function call(animalAddr) {
  return await farmer.call(animalAddr);
}
async function eat(animal, food) {
  return await animal.eat(food);
}
async function sleap(animal) {
  return await animal.sleap();
}
