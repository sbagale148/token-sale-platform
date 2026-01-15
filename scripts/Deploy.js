async function main() {
  const [deployer] = await ethers.getSigners();
  
  console.log("Deploying contracts with account:", deployer.address);
  
  // Deploy Token
  const MyToken = await ethers.getContractFactory("MyToken");
  const token = await MyToken.deploy(1000000);
  await token.waitForDeployment();
  const tokenAddress = await token.getAddress();
  console.log("MyToken deployed to:", tokenAddress);
  
  // Deploy Token Sale
  const TokenSale = await ethers.getContractFactory("TokenSale");
  const tokenSale = await TokenSale.deploy(tokenAddress);
  await tokenSale.waitForDeployment();
  const tokenSaleAddress = await tokenSale.getAddress();
  console.log("TokenSale deployed to:", tokenSaleAddress);
  
  // Transfer tokens to sale contract
  await token.transfer(tokenSaleAddress, ethers.parseEther("500000"));
  console.log("Transferred 500,000 tokens to sale contract");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });