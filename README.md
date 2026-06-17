# BullMint_ARBITRUM-NOVA_Mainnet
Deploying an NFT contract into the Arbitrum Nova main net.

# Instructions:

1. Create the project

mkdir arbitrum-nova-nft
cd arbitrum-nova-nft

npm init -y

npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
npm install @openzeppelin/contracts dotenv

2. Initialize Hardhat:

npx hardhat

Choose:

Create a JavaScript project

3. Create .env

PRIVATE_KEY=YOUR_WALLET_PRIVATE_KEY
NOVA_RPC=https://nova.arbitrum.io/rpc


4. NFT Contract

