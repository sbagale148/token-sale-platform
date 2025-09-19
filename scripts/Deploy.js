async function main() {
  const [deployer] = await ethers.getSigners();
  
  console.log("Deploying contracts with account:", deployer.address);
  
  // Deploy Token
  const MyToken = await ethers.getContractFactory("MyToken");
  const token = await MyToken.deploy(1000000);
  await token.deployed();
  console.log("MyToken deployed to:", token.address);
  
  // Deploy Token Sale
  const TokenSale = await ethers.getContractFactory("TokenSale");
  const tokenSale = await TokenSale.deploy(token.address);
  await tokenSale.deployed();
  console.log("TokenSale deployed to:", tokenSale.address);
  
  // Transfer tokens to sale contract
  await token.transfer(tokenSale.address, ethers.utils.parseEther("500000"));
  console.log("Transferred 500,000 tokens to sale contract");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });