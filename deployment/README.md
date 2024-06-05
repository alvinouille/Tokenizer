# Deploying a Smart Contract (with Hardhat)

## Introduction
Hardhat is a powerful development environment for Ethereum smart contracts. This is how I deployed my smart contracts on the Sepolia test network.

## Steps

1. **Create and Fund a MetaMask Wallet:**
   - Download and install the MetaMask extension from the [official website](https://metamask.io/). Follow the instructions to create a new wallet.
   - Acquire 0.001 ETH to be able to get Sepolia testnet ETH from faucets like : [Sepolia Faucet](https://faucet.sepolia.dev/)


2. **Create an Alchemy Account and App:**
   - Sign up for an account on the [Alchemy website](https://alchemy.com/).
   - Log in to the Alchemy Dashboard and create a new project to get your Alchemy API key. Select the Sepolia testnet for your app.

   
3. **Install Node.js and npm:**
   - Download and install Node.js from the [official website](https://nodejs.org/). npm is included with Node.js.


4. **Initialize a New Node.js Project:**
   - Create a new directory and navigate into it:
     
     ```sh
     mkdir my-project
     cd my-project
     ```
     
   - Initialize a new Node.js project:
     
     ```sh
     npm init -y
     ```


5. **Install Hardhat:**
   - Install Hardhat as a development dependency:
     
     ```sh
     npm install --save-dev hardhat
     ```
     
   - Initialize a hardhat project:
     
     ```sh
     npx hardhat init
     ```
     
   - Follow the prompts to set up your Hardhat project and select a JavaScript project.


6. **Install OpenZeppelin Libraries:**
   - Install OpenZeppelin Contracts:
     
     ```sh
     npm install @openzeppelin/contracts
     ```

   
7. **Update Hardhat Configuration:**
   - Configure Hardhat for OpenZeppelin:
     Edit `hardhat.config.js` to include the OpenZeppelin Hardhat plugin and specify the Solidity compiler version.
   - Install dotenv to manage environment variables:
     
     ```sh
     npm i dotenv
     npm install dotenv --save
     ```
   
   - Create a `.env` file in the root of your project and add it to `.gitignore`.
   - Add your Alchemy RPC URL, a Etherscan API key and secret keys (from your metamask wallet) to `.env`. Example:
     
     ```sh
     ETHERSCAN_KEY="YOURETHERSCANKEY"
     SECRET_KEY="YOURSECRETKEYFROMYOURMETAMASKWALLET"
     SEPOLIA_URL="YOURSEPOLIAURL"
     ```
   
   - Configure networks in `hardhat.config.js` to use the Sepolia network and etherscan. Your `hardhat.config.js` should look like this :
     
     ```javascript
       require("@nomicfoundation/hardhat-toolbox");
       require("dotenv").config();

       /** @type import('hardhat/config').HardhatUserConfig */
       module.exports = {
         solidity: "0.8.24",
         networks: {
           sepolia: {
             url: process.env.SEPOLIA_URL || "",
             accounts: [ process.env.KEY1 ] || [],
           },
         },
         etherscan: {
           apiKey: {
             sepolia: process.env.ETHERSCAN_KEY || ""
           }
         }
       };
     ```


8. **Write your smart contract:**
    - Create your first contract:
      - As an exemple in `contracts/Rocket.sol`:
        
        ```solidity
        // SPDX-License-Identifier: UNLICENSED
        pragma solidity ^0.8.0;

        contract Rocket {
            string public name;
            string public status;

            constructor(string memory _name) {
                name = _name;
                status = "ignition";
            }

            function launch() public {
                status = "lift-off";
            }
        }
        ```

      
9. **Compile and Test:**
   - Compile your smart contracts:
     
     ```sh
     npx hardhat compile
     ```
     
   - Run tests:
     
     ```sh
     npx hardhat test
     npx hardhat test tests/contract.sol
     ```


10. **Contract Deployment:**
    - Create your first deployment script :
      - As an exemple in `ignition/modules/Apollo.js`:
        
        ```javascript
        const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

        module.exports = buildModule("Apollo", (m) => {
          const apollo = m.contract("Rocket", ["Saturn V"]);

          m.call(apollo, "launch", []);

          return { apollo };
        });
        ```
   - Start a local node:
     
     ```sh
     npx hardhat node
     ```
   
   - Deploy your contracts on local node (--network localhost) or sepolia network (--network sepolia) :
     
     ```sh
     npx hardhat ignition deploy ./ignition/modules/deploy.js --network sepolia
     ```


11. **Verify Your Contracts:**
    - Verify your contracts on the sepolia network :
      
    ```sh
    npx hardhat ignition verify chain-11155111
    ```


## Conclusion
By following these steps, you've successfully set up a Hardhat project, installed necessary dependencies, and deployed a smart contract on the Sepolia test network. Now you can utilize the deployed contract's functionalities on the Sepolia Ethereum blockchain.

**RealEstate42 Contract :** https://sepolia.etherscan.io/address/0xef420f12C84DA5A5dea411fEb73BF719f622a5a2  
**MultiSigWallet Contract :** https://sepolia.etherscan.io/address/0x99C7660d1BEaB8837acdc676b2049E5bdaDB343f

