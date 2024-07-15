// SPDX-License-Identifier: MIT
pragma solidity >=0.8.6;

import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721ReceiverUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/IERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/IERC1155ReceiverUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol";

import "./IUniBridgeResolverUpgradeable.sol";

interface IUniBridgeCollateralized is IERC721ReceiverUpgradeable, IERC1155ReceiverUpgradeable {
    event Lent(
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint8 lentAmount,
        uint256 lendingId,
        address indexed lenderAddress,
        uint8 maxRentDuration,
        bytes4 dailyRentPrice,
        bytes4 nftPrice,
        bool isERC721,
        uint8 paymentToken
    );

    event Rented(
        uint256 lendingId,
        address indexed renterAddress,
        uint8 rentDuration,
        uint32 rentedAt
    );

    event Returned(uint256 indexed lendingId, uint32 returnedAt);

    event Claimed(uint256 indexed lendingId, uint32 claimedAt);

    event LendingStopped(uint256 indexed lendingId, uint32 stoppedAt);

    /**
     * @dev sends your NFT to UniBridge contract, which acts;
     * between the lender and the renter
     */
    function lend(
        address[] memory _nft,
        uint256[] memory _tokenId,
        uint256[] memory _lendAmounts,
        uint8[] memory _maxRentDuration,
        bytes4[] memory _dailyRentPrice,
        bytes4[] memory _nftPrice,
        uint8[] memory _paymentToken
    ) external;

    /**
     * @dev renter sends rentDuration * dailyRentPrice
     * to cover for the potentially full cost of renting. They also
     * must send the collateral (nft price set by the lender in lend)
     */
    function rent(
        address[] memory _nft,
        uint256[] memory _tokenId,
        uint256[] memory _lendingIds,
        uint8[] memory _rentDurations
    ) external payable;

    /**
     * @dev renters call this to return the rented NFT before the
     * deadline. If they fail to do so, they will lose the posted
     * collateral
     */
    function returnIt(
        address[] memory _nft,
        uint256[] memory _tokenId,
        uint256[] memory _lendingIds
    ) external;

    /**
     * @dev claim collateral on rentals that are ;
     */
    function claimCollateral(
        address[] memory _nfts,
        uint256[] memory _tokenIds,
        uint256[] memory _lendingIds
    ) external;

    /**
     * @dev stop lending rel;
     * to the lender
     */
    function stopLending(
        address[] memory _nft,
        uint256[] memory _tokenId,
        uint256[] memory _lendingIds
    ) external;
}
