// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract M3M3NFT is ERC721("M3M3 NFT", "M3M3"), Ownable(msg.sender) {
    uint256 public tokenIdLength;

    constructor() {}

    // External Functions

    function mint(uint256 amount) external payable {
        require(msg.value == amount * 10 ** 15, "mint error.");

        for (uint i = 0; i < amount; i++) {
            _mint(_msgSender(), tokenIdLength);
            tokenIdLength ++;
        }
    }

    function withdraw() external onlyOwner {
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "withdraw error.");
    }
}
