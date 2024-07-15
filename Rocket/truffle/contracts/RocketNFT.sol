// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import 'erc721psi/contracts/ERC721PsiUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import "@openzeppelin/contracts-upgradeable/token/common/ERC2981Upgradeable.sol";

contract RocketNFT is ERC2981Upgradeable, ERC721PsiUpgradeable, OwnableUpgradeable {
  string private baseURI;
  string private constant TOKEN_URI_SUFFIX = '.json';

  string public contractURI;

  function initialize(
    string memory name_,
    string memory symbol_,
    string memory baseURI_,
    address owner
  ) public initializer {
    __ERC721Psi_init(name_, symbol_);
    __ERC2981_init();
    __Ownable_init();
    baseURI = baseURI_;
    _transferOwnership(owner);
  }

  function mint(address to, uint256 quantity) external payable onlyOwner {
    // _safeMint's second argument now takes in a quantity, not a tokenId. (same as ERC721A)
    _safeMint(to, quantity);
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
        : string(abi.encodePacked(_tokenURI, TOKEN_URI_SUFFIX));
  }

  function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC2981Upgradeable, ERC721PsiUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
