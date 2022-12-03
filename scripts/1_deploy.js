const hre = require("hardhat");

async function main() {
  console.log("deploying...");
  const XAMPLEFixedStaking = await hre.ethers.getContractFactory("XAMPLEFixedStaking");
  const xAMPLEFixedStaking = await XAMPLEFixedStaking.deploy();

  await xAMPLEFixedStaking.deployed();

  console.log("Single Swap contract deployed: ", xAMPLEFixedStaking.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});