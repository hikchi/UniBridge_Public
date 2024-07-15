// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

import "./ERC4907.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WNFT is ERC4907, Ownable {
    address public UB;

    constructor(string memory name_, string memory symbol_)
        ERC4907(name_, symbol_)
    {}

    function mint(uint256 tokenId, address to) public {
        _mint(to, tokenId);
    }

    function returnNFT(address _renter, uint256 _tokenId)
        public
        returns (uint256)
    {
        require(msg.sender == UB, "not the UB contract");
        require(userOf(_tokenId) == _renter, "not the renter");

        delete _users[_tokenId];
        return _tokenId;
    }

    function setUBAddr(address _ub) public onlyOwner {
        UB = _ub;
    }

    function isApprovedForAll(address _owner, address _operator)
        public
        view
        override
        returns (bool isOperator)
    {
        if (_operator == UB) {
            return true;
        }
        // otherwise, use the default ERC721.isApprovedForAll()
        return super.isApprovedForAll(_owner, _operator);
    }
}
