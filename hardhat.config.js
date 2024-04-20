require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      }
    }
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      forking: {
        url: "https://arbitrum-sepolia.blockpi.network/v1/rpc/public",
      },
    },
    arbitrum: {
      url: "https://arbitrum-sepolia.blockpi.network/v1/rpc/public",
      accounts: [process.env.PK],
    }
  },
};
