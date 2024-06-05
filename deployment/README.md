# Deploying a smart contract with Hardhat

## Step 1: Install Node.js and npm

1.1 Node.js and npm Installation
Download and install Node.js from the official website. npm is included with Node.js.

1.2 Verify Installation

node -v
npm -v

Step 2: Create and Fund a MetaMask Wallet

2.1 Create a MetaMask Wallet
Download and install the MetaMask extension from the official website. Follow the instructions to create a new wallet.

2.2 Fund Your Wallet
Acquire 0.001 ETH to cover transaction fees. You can use faucets to get Sepolia testnet ETH:

    Sepolia Faucet

Step 3: Initialize a New Node.js Project

3.1 Create a New Directory

sh

mkdir my-project
cd my-project

3.2 Initialize a New Node.js Project

sh

npm init -y

Step 4: Install Hardhat

4.1 Install Hardhat

sh

npm install --save-dev hardhat

4.2 Initialize Hardhat

sh

npx hardhat init

4.3 Select a JavaScript Project
Follow the prompts to set up your Hardhat project.
Step 5: Create an Alchemy Account and App

5.1 Create an Alchemy Account
Sign up for an account on the Alchemy website.

5.2 Create a New App
Log in to the Alchemy Dashboard and create a new project to get your Alchemy API key. Select the Sepolia testnet for your app.
Step 6: Compile and Test

6.1 Compile Contracts

sh

npx hardhat compile

6.2 Run Tests (Optional)

sh

npx hardhat test
npx hardhat test tests/contract.sol

6.3 Generate New Artifacts (Optional)

sh

npx hardhat clean
npx hardhat compile

Step 7: Install OpenZeppelin Libraries

7.1 Install OpenZeppelin Contracts

sh

npm install @openzeppelin/contracts

7.2 Install OpenZeppelin Upgradeable Contracts (Optional)

sh

npm install @openzeppelin/contracts-upgradeable @openzeppelin/contracts

Step 8: Update Hardhat Configuration

8.1 Configure Hardhat for OpenZeppelin
Edit hardhat.config.js to include OpenZeppelin Hardhat plugin and specify Solidity compiler version.

8.2 Install dotenv

sh

npm i dotenv
npm install dotenv --save

Create a .env file in the root of your project and add it to .gitignore.

8.3 Configure Networks in hardhat.config.js
Add your Alchemy RPC URL and secret keys to .env and configure networks in hardhat.config.js.
Step 9: Contract Deployment

9.1 Start a Local Node

sh

npx hardhat node

9.2 Deploy Your Contracts

sh

npx hardhat ignition deploy ./ignition/modules/deploy.js --network sepolia

Step 10: Verify Your Contracts

Get an API key from Etherscan and add it to your hardhat.config.js.

sh

npx hardhat verify --network sepolia <address> <arg 1> <arg 2> … <arg n>

Congratulations! You've set up a Hardhat project, installed Node.js, integrated OpenZeppelin libraries, created a MetaMask wallet, funded it, created an Alchemy account, and written a simple config file. Now, customize and expand your Hardhat project as needed.
