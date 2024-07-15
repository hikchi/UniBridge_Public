// SPDX-License-Identifier: MIT
pragma solidity >=0.8.6;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import "./interfaces/IUniBridgeResolverUpgradeable.sol";

contract UniBridgeResolverUpgradeable is
    IUniBridgeResolverUpgradeable,
    Initializable,
    OwnableUpgradeable
{
    mapping(uint8 => address) private addresses;

    function initialize() public initializer {
        __Ownable_init();
    }

    function getPaymentToken(uint8 _paymentToken)
        external
        view
        override
        returns (address)
    {
        return addresses[_paymentToken];
    }

    function setPaymentToken(uint8 _paymentToken, address _addr)
        external
        override
        onlyOwner
    {
        require(_paymentToken != 0, "cant set sentinel");
        require(
            addresses[_paymentToken] == address(0),
            "cannot reset the address"
        );
        addresses[_paymentToken] = _addr;
    }
}
