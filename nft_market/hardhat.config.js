require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  // Solidity compiler version
  // We use ^0.8.20 which is stable and has all modern features
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  
  // Network configurations
  // Hardhat network is local - runs on your machine for testing
  // Mumbai is Polygon testnet - free test MATIC
  // Polygon mainnet is production - real MATIC
  networks: {
    hardhat: {
      chainId: 1337,
    },
    // Polygon Amoy testnet (current Polygon PoS testnet)
    // Faucet + explorer: we’ll use this for testnet deployments.
    amoy: {
      url: process.env.AMOY_RPC_URL || "https://rpc-amoy.polygon.technology",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      chainId: 80002,
    },
    mumbai: {
      // Polygon Mumbai testnet RPC endpoint
      // You can use public RPCs or get your own from Alchemy/Infura
      url: process.env.MUMBAI_RPC_URL || "https://rpc-mumbai.maticvigil.com",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      chainId: 80001,
    },
    polygon: {
      url: process.env.POLYGON_RPC_URL || "https://polygon-rpc.com",
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
      chainId: 137,
    },
  },
  
  // Paths for contract sources, tests, and artifacts
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};