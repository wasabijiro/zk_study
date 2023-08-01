const hre = require("hardhat");

async function main() {
  const PlonkVerifier = await hre.ethers.getContractFactory("PlonkVerifier");
  const plonkVerifier = await PlonkVerifier.deploy();
  await plonkVerifier.deployed();
  console.log("PlonkVerifier deployed to:", plonkVerifier.address);

  const SimpleMultiplier = await hre.ethers.getContractFactory("SimpleMultiplier");
  const simpleMultiplier = await SimpleMultiplier.deploy(plonkVerifier.address);
  await simpleMultiplier.deployed();
  console.log("SimpleMultiplier deployed to:", simpleMultiplier.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });