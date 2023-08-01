const PlonkVerifier = artifacts.require("PlonkVerifier");
const SimpleMultiplier = artifacts.require("SimpleMultiplier");

module.exports = async function(deployer) {
  await deployer.deploy(PlonkVerifier);
  const pv = await PlonkVerifier.deployed();

  await deployer.deploy(SimpleMultiplier, pv.address);
};
