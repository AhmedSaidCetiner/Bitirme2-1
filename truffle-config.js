const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "5777"
    },

    sepolia: {
      provider: () =>
          new HDWalletProvider(
              "age crime sound dust valley oven love cover size boss surround noble",
              "https://sepolia.infura.io/v3/02375c73b692481598a66281c11c88f1"
          ),
      network_id: 11155111,
      gas: 4465030,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  },

  compilers: {
    solc: {
      version: "0.8.13"
    }
  }
};
