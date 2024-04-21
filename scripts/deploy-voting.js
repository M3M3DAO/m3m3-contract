// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const m3m3Voting = await hre.ethers.deployContract("M3M3Voting");
  await m3m3Voting.waitForDeployment();

  console.log(`m3m3 voting address: ${await m3m3Voting.getAddress()}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// m3m3 voting address: 0xd0cF7C434bbA6Ae95e9580ea0dC3020255D2fBa1