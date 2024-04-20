// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const m3m3 = await hre.ethers.deployContract("M3M3NFT");
  await m3m3.waitForDeployment();

  console.log(`m3m3 address: ${await m3m3.getAddress()}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// m3m3 address: 0x10cDed9E35b83fb47d9091005079F5f03408Bdc9
