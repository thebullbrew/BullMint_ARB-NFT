# BullMint_ARBITRUM-NOVA_Mainnet

Cute little description : This project is about deploying an NFT contract into the Arbitrum Nova main net (assuming you have all dependencies installed and your metamask wallet ready. If not get outta here.)
<img width="1280" height="640" alt="1" src="https://github.com/user-attachments/assets/2b1f104a-f98b-40e0-b919-3665f4d7098a" />



<img width="1280" height="640" alt="2" src="https://github.com/user-attachments/assets/d4ef943d-9d4a-4f7a-8adf-07ef12f88e93" />



# Instructions:

# 1. Create the project

mkdir arbitrum-nova-nft
cd arbitrum-nova-nft

npm init -y

npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
npm install @openzeppelin/contracts dotenv

# 2. Initialize Hardhat:

npx hardhat

Choose:
Create a JavaScript project

# 3. Create .env

PRIVATE_KEY=YOUR_WALLET_PRIVATE_KEY
NOVA_RPC=https://nova.arbitrum.io/rpc


# 4. NFT Contract

contracts/MyNovaNFT.sol

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNovaNFT is ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

  constructor()
        ERC721("My Nova NFT", "MNFT")
        Ownable(msg.sender)
    {}

  function mint(
        address to,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId;
    _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _nextTokenId++;
        return tokenId;
    }
} 


# 5. Configure Hardhat

Edit:


require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    arbitrumNova: {
      url: process.env.NOVA_RPC,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};


# 6. Deployment Script

Create:

scripts/deploy.js


async function main() {
  const NFT = await ethers.getContractFactory("MyNovaNFT");

  const nft = await NFT.deploy();

  await nft.waitForDeployment();

  console.log(
    "NFT deployed to:",
    await nft.getAddress()
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});



# 7. Deploy

Compile:

npx hardhat compile


Deploy to Nova:

npx hardhat run scripts/deploy.js --network arbitrumNova


You'll receive a contract address.


# 8. Mint an NFT

Example metadata JSON:


{
  "name": "Genesis NFT",
  "description": "First NFT on Nova",
  "image": "ipfs://YOUR_IMAGE_CID"
}


Upload metadata to IPFS and obtain:

ipfs://YOUR_METADATA_CID


Create:

const contract = await ethers.getContractAt(
  "MyNovaNFT",
  "YOUR_CONTRACT_ADDRESS"
);

await contract.mint(
  "YOUR_WALLET_ADDRESS",
  "ipfs://YOUR_METADATA_CID"
);


IMPORTANT NOTES:

Arbitrum Nova uses chain ID 42170 and requires ETH on Nova to pay gas.



















