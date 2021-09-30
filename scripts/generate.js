const hre = require("hardhat");
const Web3 = require("web3");

async function main() {
  [deployer, otherSigner] = await hre.ethers.getSigners();
  const Floot = await ethers.getContractFactory("Floot", {
    libraries: {
      FlootConstants: '0xc6e7DF5E7b4f2A278906862b61205850344D4e7d',
    },
  });

  const floot = Floot.attach('0x6DDAb8578fDa4F900EC463E1966Bd3061BAf5A89');
  let txn;
  let res;

  // const claim1 = await floot.claim();
  // const receipt1 = await claim1.wait();
  // console.log("First mint gas used:", receipt1.gasUsed.toString());
  // const claim2 = await floot.connect(otherSigner).claim();
  // const receipt2 = await claim2.wait();
  // console.log("Second mint gas used:", receipt2.gasUsed.toString());
  // const claim3 = await floot.connect(otherSigner).claim();
  // const receipt3 = await claim3.wait();
  // console.log("Third mint gas used:", receipt3.gasUsed.toString());

  // await floot.claim();
  // await floot.claim();
  // await floot.claim();

  // NOTE: Each step needs to be verified on the blockchain before proceeding
  
  //txn = await floot.setAutomaticSeedBlockNumber();
  // res = await txn.wait();
  // console.log(res);
  // await ethers.provider.send("evm_mine", []);

  // const txn = await floot.setAutomaticSeed();
  // res = await txn.wait();
  // console.log(res);


  // await floot.setGuardianSeed(Web3.utils.soliditySha3("test-seed"));
  // res = await txn.wait();
  // console.log(res);

  // await floot.setFinalSeed();
  // res = await txn.wait();
  // console.log(res);
  const TOKEN_URI_PREFIX = "data:application/json;base64,";

  const uri = await floot.tokenURI(1);
  const jsonBase64 = uri.slice(TOKEN_URI_PREFIX.length);
  const json = Buffer.from(jsonBase64, "base64").toString();
  const metadata = JSON.parse(json);
  console.log(metadata);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
