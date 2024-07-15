// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// 0xed0a6619729E55C014952975C39eA6057e8f8364: goerli
contract RXNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    string private baseURI;

    constructor(string memory baseURI_) ERC721("RXToken", "RXNFT") {
        baseURI = baseURI_;
    }

    function safeMint(address to, uint256 amount) public onlyOwner {
        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            _safeMint(to, tokenId);
        }
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        string memory _tokenURI = super.tokenURI(tokenId);

        return
            bytes(_tokenURI).length == 0
                ? _tokenURI
                : string(abi.encodePacked(_tokenURI, ".jpeg"));
    }
}
