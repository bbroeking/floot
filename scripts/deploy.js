const hre = require("hardhat");
const Web3 = require("web3");
const fs = require('fs');

async function main() {
  const GUARDIAN_TEST_SEED = Web3.utils.soliditySha3("test-seed");
  const GUARDIAN_WINDOW_DURATION_S = 24 * 60 * 60; // 1 day
  const MAX_DISTRIBUTION_DURATION_S = 24 * 60 * 60 * 10; // 10 days
  const MAX_SUPPLY = 3;
  
  const FlootConstants = await ethers.getContractFactory("FlootConstants");
  const flootConstants = await FlootConstants.deploy();
  const Floot = await ethers.getContractFactory("Floot", {
    libraries: {
      FlootConstants: flootConstants.address,
    },
  });
  const floot = await Floot.deploy(
    Web3.utils.soliditySha3(GUARDIAN_TEST_SEED),
    GUARDIAN_WINDOW_DURATION_S, // guardianWindowDurationSeconds = 1 day
    MAX_DISTRIBUTION_DURATION_S,
    MAX_SUPPLY
  );
  await floot.deployed();

  const arguments = `module.exports = [\n\t"${Web3.utils.soliditySha3(GUARDIAN_TEST_SEED)}",\n\t${GUARDIAN_WINDOW_DURATION_S},\n\t${MAX_DISTRIBUTION_DURATION_S},\n\t${MAX_SUPPLY}\n];`
  fs.writeFileSync('./arguments.js', arguments);

  const addresses = `${flootConstants.address}\n${floot.address}`
  fs.writeFileSync('./addresses.txt', addresses);
  console.log(`Floot deployed to: ${floot.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
