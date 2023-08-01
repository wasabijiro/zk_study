require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

const RPC_URL = process.env.GOERLI_RPC_URL;
const DEPLOYER_PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.13",
  networks: {
    goerli: {
      url: RPC_URL,
      accounts: [`0x${DEPLOYER_PRIVATE_KEY}`]
    }
  }
};
