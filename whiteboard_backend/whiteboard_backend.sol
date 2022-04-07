// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Whiteboard {

  string message = "";
  event print_message(string _message);

  function setMessage(string memory new_message) public {
    message = new_message;
  }

  function returnMessage() public view returns(string memory) {
    return message;
  }

  function printMessage() public {
    emit print_message(message);
  }
}