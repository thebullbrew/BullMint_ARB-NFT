// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BREW_ARB is ERC721URIStorage, ERC2981, Ownable {

    uint256 public constant MAX_SUPPLY = 1000;
    uint256 public totalMinted;

    uint256 public mintPrice = 0.001 ether;

    bool public publicMintEnabled = true;

    string public baseTokenURI;

    constructor(
        string memory _baseURI,
        address royaltyReceiver
    )
        ERC721("BRW-COLLECTION-ARB", "BRW-ARB")
        Ownable(msg.sender)
    {
        baseTokenURI = _baseURI;

        // 5% royalty
        _setDefaultRoyalty(
            royaltyReceiver,
            500
        );
    }

    modifier mintCompliance(uint256 quantity) {
        require(quantity > 0, "Quantity must be greater than 0");
        require(
            totalMinted + quantity <= MAX_SUPPLY,
            "Max supply exceeded"
        );
        _;
    }

    function publicMint(
        uint256 quantity
    )
        external
        payable
        mintCompliance(quantity)
    {
        require(
            publicMintEnabled,
            "Public mint is disabled"
        );

        require(
            msg.value >= mintPrice * quantity,
            "Insufficient payment"
        );

        for (uint256 i = 0; i < quantity; i++) {
            totalMinted++;

            _safeMint(
                msg.sender,
                totalMinted
            );
        }
    }

    function ownerMint(
        address recipient,
        uint256 quantity
    )
        external
        onlyOwner
        mintCompliance(quantity)
    {
        for (uint256 i = 0; i < quantity; i++) {
            totalMinted++;

            _safeMint(
                recipient,
                totalMinted
            );
        }
    }

    function setMintPrice(
        uint256 newPrice
    )
        external
        onlyOwner
    {
        mintPrice = newPrice;
    }

    function setBaseURI(
        string calldata newBaseURI
    )
        external
        onlyOwner
    {
        baseTokenURI = newBaseURI;
    }

    function setPublicMintEnabled(
        bool enabled
    )
        external
        onlyOwner
    {
        publicMintEnabled = enabled;
    }

    function withdraw()
        external
        onlyOwner
    {
        (bool success, ) = payable(owner()).call{
            value: address(this).balance
        }("");

        require(success, "Withdrawal failed");
    }

    function _baseURI()
        internal
        view
        override
        returns (string memory)
    {
        return baseTokenURI;
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721URIStorage, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}


