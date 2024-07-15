// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "../RocketNFT.sol";

contract RocketNFTFactory is Ownable {
  address public master;

  event NewRocketNFT(address indexed contractAddress);

  using Clones for address;

  constructor(address _master) {
    master = _master;
  }

  function getRocketNFTAddress(bytes32 salt) external view returns (address) {
    require(master != address(0), "master must be set");
    return master.predictDeterministicAddress(salt);
  }

  function createNewRocketNFT(
    bytes32 salt,
    string memory name_,
    string memory symbol_,
    string memory baseURI_
  ) external onlyOwner {
    address newRocketNFT = master.cloneDeterministic(salt);
    emit NewRocketNFT(newRocketNFT);

    RocketNFT(newRocketNFT).initialize(name_, symbol_, baseURI_, owner());
  }
}
