//SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract deployBasicNft is Script {
    BasicNft public basicNft;

    function run() public returns (BasicNft) {
        vm.startBroadcast();
        basicNft = new BasicNft();

        vm.stopBroadcast();
        return basicNft;
    }
}
