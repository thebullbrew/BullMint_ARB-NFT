const hre = require("hardhat");

async function main() {

    const BREW_ARB =
        await hre.ethers.getContractFactory(
            "BREW_ARB"
        );

    const contract =
        await BREW_ARB.deploy(
            "ipfs://YOUR_CID/",
            "YOUR_WALLET_ADDRESS"
        );

    await contract.waitForDeployment();

    console.log(
        "BREW_ARB deployed to:",
        await contract.getAddress()
    );
}

main()
.catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
