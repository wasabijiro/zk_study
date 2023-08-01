const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();

module.exports = {
  networks: {
    goerli: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, process.env.GOERLI_RPC_URL),
      network_id: 5, // Goerli's network id
      gas: 5500000,
    },
  },
  compilers: {
    solc: {
      version: "0.8.13", // solidity version
    }
  }
};
