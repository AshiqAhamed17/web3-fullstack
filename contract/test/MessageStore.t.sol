// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MessageStore.sol";

contract MessageStoreTest is Test {
    MessageStore public store;

    function setUp() public {
        store = new MessageStore();
    }

    function test_storeAndRetrive() public {
        store.storeMessage("Hello");
        assertEq(store.retriveMessage(), "Hello", "Not equal");
    }

    function test_retrivefail() public {
        vm.prank(address(1));

        vm.expectRevert();
        store.retriveMessage();
        
    }
}