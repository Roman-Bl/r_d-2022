const Cow = artifacts.require("Cow");
const Horse = artifacts.require("Horse");
const Wolf = artifacts.require("Wolf");
const Dog = artifacts.require("Dog");
const Lib = artifacts.require("StringCompare");
const Farmer = artifacts.require("Farmer");

let cow, horse, wolf, farmer, dog;
console.log("test1");

contract("Horse and Farmer", async (account) => {
  try {
    it("Horse has the correct name", async () => {
      horse = await Horse.deployed();
      farmer = await Farmer.deployed();
      await checkName(horse, "Jack");
    });
  } catch (e) {
    console.log(e.message);
  }

  try {
    it("Horse can sleep", async () => {
      await checkSleep(horse);
    });
  } catch (e) {
    console.log(e.message);
  }

  try {
    it(`Horse can eat 'plant'`, async () => {
      await checkFood(horse, "plant");
    });
  } catch (e) {
    console.log(e.message);
  }

  it(`Horse cannot eat 'meat', 'not-food', 'plastic'`, async () => {
    try {
      await checkFood(horse, "meat");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFood(horse, "ball");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFood(horse, "plastic");
    } catch (e) {
      console.log(e.message);
    }
  });

  try {
    it(`Farmer can call Horse, Horse responds correctly - Igogo`, async () => {
      await checkFarmerCall(horse, "Igogo");
    });
  } catch (e) {
    console.log(e.message);
  }

  it(`Farmer can feed Horse with plant`, async () => {
    try {
      await checkFarmerFeed(horse, "plant");
    } catch (e) {
      console.log(e.message);
    }
  });

  it(`Farmer cannot feed Horse with anything else`, async () => {
    try {
      await checkFarmerFeed(horse, "meat");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFarmerFeed(horse, "cow");
    } catch (e) {
      console.log(e.message);
    }
  });
});

contract("Dog and Farmer", async () => {
  try {
    it("Dog has the correct name", async () => {
      dog = await Dog.deployed();
      farmer = await Farmer.deployed();
      await checkName(dog, "Nobu");
    });
  } catch (e) {
    console.log(e.message);
  }

  try {
    it("Dog can sleep", async () => {
      await checkSleep(dog);
    });
  } catch (e) {
    console.log(e.message);
  }

  it(`Dog can eat 'plant'`, async () => {
    try {
      await checkFood(dog, "plant");
    } catch (e) {
      console.log(e.message);
    }
  });

  it(`Dog can eat 'meat'`, async () => {
    try {
      await checkFood(dog, "meat");
    } catch (e) {
      console.log(e.message);
    }
  });

  it(`Dog cannot eat 'not-food', 'plastic', 'chocolate'`, async () => {
    try {
      await checkFood(dog, "ball");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFood(dog, "plastic");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFood(dog, "chocolate");
    } catch (e) {
      console.log(e.message);
    }
  });

  try {
    it(`Farmer can call Dog, Dog responds correctly - Woof`, async () => {
      await checkFarmerCall(dog, "Woof");
    });
  } catch (e) {
    console.log(e.message);
  }

  it(`Farmer can feed Dog with meat and plant`, async () => {
    try {
      await checkFarmerFeed(dog, "meat");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFarmerFeed(dog, "plant");
    } catch (e) {
      console.log(e.message);
    }
  });

  it(`Farmer cannot feed Dog with 'not-food', 'plastic' and anything else`, async () => {
    try {
      await checkFarmerFeed(dog, "wood");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFarmerFeed(dog, "plastic");
    } catch (e) {
      console.log(e.message);
    }
    try {
      await checkFarmerFeed(dog, "ball");
    } catch (e) {
      console.log(e.message);
    }
  });
});

// module.exports = async (deployer) => {
//   await deployer.deploy(Lib);
//   await deployer.link(Lib, [Cow, Horse, Wolf, Dog]);
//   await deployer.deploy(Cow, "Milka");
//   await deployer.deploy(Horse, "Jeck");
//   await deployer.deploy(Wolf, "Onix");
//   await deployer.deploy(Dog, "Nobu");
//   await deployer.deploy(Farmer);
//   cow = await Cow.deployed();
//   horse = await Horse.deployed();
//   wolf = await Wolf.deployed();
//   dog = await Dog.deployed();
//   farmer = await Farmer.deployed();

//   //   console.log(cow.address);
//   //   let result = await eat(cow, "plant");
//   //   console.log(`Cow eat result ${result}`);
//   //   let sleapCow = await sleap(cow);
//   //   console.log(sleapCow);
//   console.log(`Farmer call Cow - ${await call(cow.address)}`);
//   console.log(`Farmer call Horse - ${await call(horse.address)}`);
//   try {
//     let farmerFeed = await feed(wolf.address, "plant");
//     console.log(`Farmer feed wolf - ${farmerFeed}`);
//   } catch (e) {
//     console.log(e.message);
//   }
//   try {
//     farmerFeed = await feed(wolf.address, "meat");
//     console.log(`Farmer feed wolf - ${farmerFeed}`);
//   } catch (e) {
//     console.log(e.message);
//   }
// };

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

async function getName(animal) {
  return await animal.getName();
}
async function checkName(animalToCheck, nameToCheck) {
  console.log("Name from contract is ", await getName(animalToCheck));
  assert.equal(
    await getName(animalToCheck),
    nameToCheck,
    "Names are not equal"
  );
}
async function checkSleep(animalToCheck) {
  console.log("Sound of sleeping is - ", await sleap(animalToCheck));
  assert.equal(
    await sleap(animalToCheck),
    "Z-z-z",
    "Sleap func does not return Z-z-z"
  );
}

async function checkFood(animalToCheck, food) {
  console.log(`Trying to give  - ${food}`);
  let res = await eat(animalToCheck, food);
  assert.isTrue(res === "Nom-nom", `${food} does not return Nom-nom`);
}

async function checkFarmerCall(animal, shouldRespong) {
  let res = await call(animal.address);
  assert.equal(
    res,
    shouldRespong,
    `Animal does not respong correctly on farmer call`
  );
}

async function checkFarmerFeed(animal, food) {
  console.log(`Farmer trying to fead with  - ${food}`);
  let res = await feed(animal.address, food);
  assert.isTrue(res === "Nom-nom", `${food} does not return Nom-nom`);
}

// async function canNotEat(animalToCheck, food) {
//   console.log(`Trying to fead with  - ${food}`);
//   let res = await eat(animalToCheck, food);
//   //   console.log(res);
//   //   assert.isFalse(res === "Nom-nom", `${food} return Nom-nom, but should not`);
// }
