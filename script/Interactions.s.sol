//SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract InteractionsDeploy is Script {
    string public constant NFT_URL =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostrecentDeployedaddr = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintusingcontractaddr(mostrecentDeployedaddr);
    }

    function mintusingcontractaddr(address contractaddr) public {
        vm.startBroadcast();
        BasicNft(contractaddr).mintNft(NFT_URL);
        vm.stopBroadcast();
    }
}
