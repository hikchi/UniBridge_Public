// SPDX-License-Identifier: MIT
pragma solidity >=0.8.6;

interface IUniBridgeResolverUpgradeable {

    function getPaymentToken(uint8 _pt) external view returns (address);

    function setPaymentToken(uint8 _pt, address _v) external;
}
