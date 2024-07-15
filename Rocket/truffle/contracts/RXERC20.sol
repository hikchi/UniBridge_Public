// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// 0x58E9E5dA59199F702683c0237da1822Be3940678: goerli
contract RXERC20 is ERC20, Ownable {
    constructor() ERC20("RXERC20", "RXT") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() public pure override returns(uint8) {
        return 6;
    }
}