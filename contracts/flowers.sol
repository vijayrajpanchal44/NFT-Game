// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract flowers is ERC721{
        using Counters for Counters.Counter;
        Counters.Counter private _tokenIdCounter;

        // mapping(uint256 => uint256) private tokenIdToPetalsCount;
        mapping(address => mapping(uint256 => uint256)) private userOwnesPetals;       

        uint256 public fixedNFTAmount;
        constructor(uint256 _fixedNFTAmount) ERC20("Flower NFT", "Flower"){
                fixedNFTAmount = _fixedNFTAmount;
        }
        function safeMint(address to, uint256 id) public {
                uint256 tokenId = _tokenIdCounter.current();
                require(tokenId <= fixedNFTAmount,"Exceeds the fixed Nft amount");

                _tokenIdCounter.increment();
                _safeMint(to, tokenId);

                userOwnesPetals[to][id] += 1;
                // tokenIdToPetalsCount[id] += 1;
        } 

        function upgradePetals(address to, uint256 id, uint256 _amount) external {
                userOwnesPetals[to][id] += _amount;
        }

        function balanceOfPetals(address to, uint256 nftId) public view returns(uint256){
                return userOwnesPetals[to][nftId];
        }

        
}