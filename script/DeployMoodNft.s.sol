//SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {MoodNft} from "../src/MoodNft.sol";
import {Script, console} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft public moodnft;

    function run() public returns (MoodNft) {
        string memory happymood = vm.readFile("./img/Happy.svg");
        string memory sadmood = vm.readFile("./img/Sad.svg");

        vm.startBroadcast();
        moodnft = new MoodNft(svgtoBase64(happymood), svgtoBase64(sadmood));
        vm.stopBroadcast();
        console.log(svgtoBase64(happymood));
        console.log(svgtoBase64(sadmood));
        return moodnft;
    }

    function svgtoBase64(
        string memory svg
    ) public pure returns (string memory) {
        string memory _baseUrl = "data:image/svg+xml;base64,";
        string memory svgbase = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return (string(abi.encodePacked(_baseUrl, svgbase)));
    }
}
