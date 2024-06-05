# Deploying a Smart Contract with Hardhat

## Introduction
Hardhat is a powerful development environment for Ethereum smart contracts. This guide walks you through the process of setting up a Hardhat project, installing necessary dependencies, and deploying a smart contract on the Sepolia test network.

## Steps

1. **Create and Fund a MetaMask Wallet:**
   - Download and install the MetaMask extension from the [official website](https://metamask.io/). Follow the instructions to create a new wallet.
   - Acquire 0.001 ETH to cover transaction fees. You can use faucets to get Sepolia testnet ETH:
     - [Sepolia Faucet](https://faucet.sepolia.dev/)

2. **Install Node.js and npm:**
   - Download and install Node.js from the [official website](https://nodejs.org/). npm is included with Node.js.

3. **Initialize a New Node.js Project:**
   - Create a new directory and navigate into it:
     ```sh
     mkdir my-project
     cd my-project
     ```
   - Initialize a new Node.js project:
     ```sh
     npm init -y
     ```

4. **Install Hardhat:**
   - Install Hardhat as a development dependency:
     ```sh
     npm install --save-dev hardhat
     ```
   - Initialize Hardhat:
     ```sh
     npx hardhat init
     ```
   - Follow the prompts to set up your Hardhat project and select a JavaScript project.

5. **Create an Alchemy Account and App:**
   - Sign up for an account on the [Alchemy website](https://alchemy.com/).
   - Log in to the Alchemy Dashboard and create a new project to get your Alchemy API key. Select the Sepolia testnet for your app.

6. **Compile and Test:**
   - Compile your smart contracts:
     ```sh
     npx hardhat compile
     ```
   - (Optional) Run tests:
     ```sh
     npx hardhat test
     npx hardhat test tests/contract.sol
     ```

7. **Install OpenZeppelin Libraries:**
   - Install OpenZeppelin Contracts:
     ```sh
     npm install @openzeppelin/contracts
     ```

8. **Update Hardhat Configuration:**
   - Configure Hardhat for OpenZeppelin:
     Edit `hardhat.config.js` to include the OpenZeppelin Hardhat plugin and specify the Solidity compiler version.
   - Install dotenv to manage environment variables:
     ```sh
     npm i dotenv
     npm install dotenv --save
     ```
   - Create a `.env` file in the root of your project and add it to `.gitignore`.
   - Add your Alchemy RPC URL and secret keys to `.env`.
   - Configure networks in `hardhat.config.js`.

9. **Contract Deployment:**
   - Start a local node:
     ```sh
     npx hardhat node
     ```
   - Deploy your contracts:
     ```sh
     npx hardhat ignition deploy ./ignition/modules/deploy.js --network sepolia
     ```
10. **Verify your contracts**
    - Get an API key from Etherscan and add it to your hardhat.config.js.
    ```sh
    npx hardhat verify --network sepolia <address> <arg 1> <arg 2> … <arg n>
    ```

## Conclusion
By following these steps, you've successfully set up a Hardhat project, installed necessary dependencies, and deployed a smart contract on the Sepolia test network. Now you can utilize the deployed contract's functionalities on the Sepolia Ethereum blockchain.

**Contract Address:** [Your Contract Address Here](https://sepolia.etherscan.io/address/YourContractAddressHere)
