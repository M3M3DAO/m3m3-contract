// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./M3M3NFT.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract M3M3Voting is Ownable(msg.sender) {
    M3M3NFT public constant m3m3nft =
        M3M3NFT(0x714eD56B2dA2f6CF4A583507bF3CF15313989E1B);

    struct MetaData {
        string name;
        string logo;
        string website;
        uint256 like;
        uint256 supply;
        uint256 allocation;
        uint256 participant;
    }

    mapping(uint256 projectId => MetaData) internal _metadatas;
    uint256 public projectIdLength;

    mapping(address holder => mapping(uint256 projectId => uint256 usedAmount))
        internal _usedAmounts;

    constructor() {}

    // External Functions

    function submit(MetaData memory _metadata) external {
        _metadatas[projectIdLength] = _metadata;
        _metadatas[projectIdLength].like = 0;
        _metadatas[projectIdLength].participant = 0;
        projectIdLength++;
    }

    function lfg(
        uint256 projectId,
        uint256 votingAmount
    ) external onlyNftHolder {
        uint256 senderUsedAmount = _usedAmounts[_msgSender()][projectId];
        uint256 nftBalance = m3m3nft.balanceOf(_msgSender());
        require(nftBalance > senderUsedAmount, "lfg error.");

        votingAmount = votingAmount > nftBalance - senderUsedAmount
            ? nftBalance - senderUsedAmount
            : votingAmount;
        _metadatas[projectId].like += votingAmount;
        _usedAmounts[_msgSender()][projectId] += votingAmount;
    }

    function buy(uint256 buyAmount) external {
        MetaData memory metadata = _metadatas[0];
        uint256 highestId;
        for (uint256 i = 0; i < projectIdLength; i++) {
            uint256 id = i;
            if (metadata.like < _metadatas[id].like) {
                metadata = _metadatas[id];
                highestId = id;
            }
        }

        uint256 remainAmount;
        uint256 tokenIdLength = m3m3nft.tokenIdLength();
        for (uint i = 0; i < tokenIdLength; i++) {
            if (m3m3nft.ownerOf(i) == _msgSender()) {
                m3m3nft.transferFrom(_msgSender(), address(this), i);
                remainAmount++;
                metadata.participant++;

                if (remainAmount == buyAmount) break;
            }
        }
    }

    // View Functions

    function getMetadata(
        uint256 projectId
    ) external view returns (MetaData memory metadata) {
        return _metadatas[projectId];
    }

    function getMetadataAll()
        external
        view
        returns (MetaData[] memory metadatas)
    {
        metadatas = new MetaData[](projectIdLength);
        for (uint256 i = 0; i < projectIdLength; i++) {
            uint256 id = i;
            MetaData memory metadata = _metadatas[id];
            metadatas[i] = metadata;
        }
    }

    function getHighestMetadata()
        external
        view
        returns (MetaData memory metadata)
    {
        metadata = _metadatas[0];
        uint256 highestId;
        for (uint256 i = 0; i < projectIdLength; i++) {
            uint256 id = i;
            if (metadata.like < _metadatas[id].like) {
                metadata = _metadatas[id];
                highestId = id;
            }
        }
    }

    // Modifier Functions

    modifier onlyNftHolder() {
        require(m3m3nft.balanceOf(_msgSender()) != 0, "onlyNftHolder error.");
        _;
    }
}
