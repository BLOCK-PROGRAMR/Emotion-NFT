// SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNft is ERC721 {
    //errors
    error Not_owner();
    uint256 private s_tokenCounter;
    string private s_happyimageUri;
    string private s_sadimageUri;

    enum Mood {
        Sad,
        Happy
    }
    mapping(uint256 => Mood) public s_tokenIduri;

    constructor(
        string memory happyuri,
        string memory saduri
    ) ERC721("MoodNft", "MN") {
        s_happyimageUri = happyuri;
        s_sadimageUri = saduri;
        s_tokenCounter = 0;
    }

    function flipMood(uint256 tokenId) public {
        //here owner only flip the mode no one can do that
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert Not_owner();
        }
        if (s_tokenIduri[tokenId] == Mood.Happy) {
            s_tokenIduri[tokenId] = Mood.Sad;
        } else {
            s_tokenIduri[tokenId] = Mood.Happy;
        }
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);

        s_tokenIduri[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:/application/json/;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory Image_URI;
        if (s_tokenIduri[tokenId] == Mood.Happy) {
            Image_URI = s_happyimageUri;
        } else {
            Image_URI = s_sadimageUri;
        }
        return (
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '",',
                                '"description":"An nft it will decide the owner mood",',
                                '"attributes":[{"trait_type":"moodness","value":"100"}],',
                                '"image":"',
                                Image_URI,
                                '"}'
                            )
                        )
                    )
                )
            )
        );
    }
}
