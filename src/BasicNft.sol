// SPDX-License-Identifier:NFT
pragma solidity ^0.8.22;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) public tokenIdtoUri;

    constructor() ERC721("Kungfupanda", "KP") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenuri) public {
        tokenIdtoUri[s_tokenCounter] = tokenuri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return tokenIdtoUri[tokenId];
    }

    function getTokencounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
