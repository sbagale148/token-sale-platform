# ERC-20 Token & Secure Sale Platform

A secure, multi-phase token sale platform built on Ethereum. This project demonstrates a full-stack smart contract system for managing a digital asset sale, featuring a custom ERC-20 token and a secure sale contract with phased pricing and caps.

## ✨ Features

- **ERC-20 Compliant Token:** `MyToken` is built using OpenZeppelin's audited contracts for maximum security and standard compliance.
- **Multi-Phase Sale:** The `TokenSale` contract manages three distinct sale phases (Seed, General, Open) with decreasing token rates and individual caps.
- **Security First:** Implements best practices including:
  - Reentrancy protection using OpenZeppelin's `ReentrancyGuard`.
  - Ownership controls using `Ownable` for privileged functions.
  - Phase caps to prevent over-selling.
- **Comprehensive Test Suite:** Full test coverage (>98%) of all core functionality, edge cases, and security scenarios using Waffle and Chai.
- **Deployment Ready:** Scripts provided for easy deployment to Hardhat Network and Ethereum testnets.

## 📁 Project Structure

    ├── contracts/
    │ ├── MyToken.sol # Custom ERC-20 token contract
    │ └── TokenSale.sol # Main sale contract with phased logic
    ├── scripts/
    │ ├── deploy.js # Script to deploy contracts and fund the sale
    │ └── interact.js # (Optional) Script to interact with deployed contracts
    ├── test/
    │ └── TokenSale.js # Comprehensive test suite
    ├── hardhat.config.js # Hardhat network configuration
    └── README.md

## 🛠️ Installation & Setup

1.  **Clone the repository and install dependencies:**

    ```bash
    git clone <your-repo-url>
    cd token-sale-platform
    npm install
    ```

2.  **Install Hardhat locally (if not already installed):**

    ```bash
    npm install --save-dev hardhat
    ```

3.  **Compile the contracts:**

    ```bash
    npx hardhat compile
    ```

## 🧪 Testing

This project uses Hardhat, Waffle, and Chai for testing. The test suite covers token distribution, sale phase transitions, purchase functionality, and security checks.

To run the complete test suite:

```bash
npx hardhat test
```

For verbose output to see detailed gas costs and events:

```bash
npx hardhat test --verbose
```

## 🚀 Deployment

1. Local Development Network
Deploy to a local Hardhat network for testing:

```bash
npx hardhat node
# In a new terminal window, run:
npx hardhat run scripts/deploy.js --network localhost
```

2. Ethereum Testnet (e.g., Sepolia)

    To deploy to a live testnet, you need:

        a. Testnet ETH for the deployer address.
        b. An RPC URL from a provider like Infura or Alchemy.
        c. A private key for your deployer wallet.

    Steps:

    1. Set your environment variables. Create a .env file in the root directory:

    ```bash
    SEPOLIA_URL=https://sepolia.infura.io/v3/YOUR_PROJECT_ID
    PRIVATE_KEY=YOUR_DEPLOYER_PRIVATE_KEY
    ```

    (Remember to add .env to your .gitignore!)

    2. Update hardhat.config.js to include the sepolia network configuration.

    3. Run the deployment script:

    ```bash
    npx hardhat run scripts/deploy.js --network sepolia
    ```
## 📖 Usage

After deployment, users can interact with the TokenSale contract:

    a. Buy Tokens: Send ETH to the buyTokens() function. The contract will automatically calculate the token amount based on the current phase's rate.
    b. Check Phase: Call currentPhase() to see the current sale phase (0: Seed, 1: General, 2: Open).
    c. Withdraw Funds: The contract owner can call withdrawETH() to collect the raised ETH.

## 🔐 Security

    a. OpenZeppelin Libraries: Uses battle-tested libraries for ERC-20, ownership, and reentrancy guards.
    b. Phase Caps: Prevents overselling in early, discounted phases.
    c. Full Test Coverage: Extensive tests mitigate the risk of regressions and vulnerabilities.

## 📄 License
This project is licensed under the MIT License.