module.exports = {
  networks: {
    // for development
    develop: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      accounts: 5,
      defaultEtherBalance: 500,
      blockTime: 0
    },
  },
  compilers: {
    solc: {
      version: "0.5.17",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200,
        },
      },
    },
  },
};
