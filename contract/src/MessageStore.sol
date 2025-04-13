// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessageStore {
    string private message;
    address public owner;

    event MessageStored(address indexed sender, string newMessage);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }

    function storeMessage(string calldata _message) external {
        require(bytes(_message).length > 0, "Empty Message cannot be stored!");
        message = _message;
        emit MessageStored(msg.sender, _message);
    }

    function retriveMessage() external view onlyOwner returns(string memory) {
        return message;
    }
}

