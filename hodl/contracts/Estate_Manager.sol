// SPDX-License-Identifier: MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.0;

contract EstateManager {

    struct Estate {
      uint estate_id;
      mapping (uint => Estate_Holding) holdings;
    }

    struct Estate_Holding {
      uint estate_id;
      uint holding_id;
      uint time_to_inheritance;
      address payable giver_address;
      address payable inhereter_address;
    }

    function create_estate() public returns (uint){

    }

    function create_estate_holding(uint _estate_id) public returns (uint) {

    }

    function inherit_estate(uint _estate_id) public {

    }

    function inherit_holding(uint _estate_id, uint _holding_id) public {

    }

    function see_time_left_on_holding(uint _estate_id, uint _holding_id) public view returns(uint) {
      
    }

}