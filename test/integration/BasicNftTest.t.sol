//SPDX-License-Identifier:MIT
pragma solidity ^0.8.22;
import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {deployBasicNft} from "../../script/deployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    deployBasicNft public deployer;
    address public USER = makeAddr("user");
    string public constant NFTURL =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new deployBasicNft();
        basicNft = deployer.run();
    }

    function testNFTimageandSymbol() public view {
        string memory givenname = "Kungfupanda";
        string memory actualname = basicNft.name();
        string memory actualsymbol = "KP";
        string memory givensymbol = basicNft.symbol();
        assert(
            keccak256(abi.encodePacked(givenname)) ==
                keccak256(abi.encodePacked(actualname))
        );
        assert(
            keccak256(abi.encodePacked(actualsymbol)) ==
                keccak256(abi.encodePacked(givensymbol))
        );
    }

    function testMintandbalanceofcontract() public {
        vm.prank(USER);

        basicNft.mintNft(NFTURL);
        assertEq(1, basicNft.getTokencounter());
        assertEq(
            keccak256(abi.encodePacked(NFTURL)),
            keccak256(abi.encodePacked(basicNft.tokenIdtoUri(0)))
        );
    }
}
