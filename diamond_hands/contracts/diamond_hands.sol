// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

pragma solidity ^0.8.0;

contract Diamond_Hands {

  uint num_of_holds = 0;

  event print_num_of_holds(uint _num_of_holds);

  struct Hold_Struct {
    uint hold_id;
    address addy;
    uint seconds_to_hold;
    uint wei_stored;
    uint date_hold_created;
    address nft_contract_addres;
    uint nft_token_id;
    address erc_20_contract_address;
    uint erc_20_tokens_stored;
  }

  mapping(uint => Hold_Struct) holds;

  function make_eth_hold(uint _seconds_to_hold) public payable returns(uint) {
    Hold_Struct memory new_hold;
    new_hold.hold_id = num_of_holds;
    new_hold.addy = msg.sender;
    new_hold.seconds_to_hold = _seconds_to_hold;
    new_hold.date_hold_created = block.timestamp;
    new_hold.wei_stored = msg.value;
    num_of_holds += 1;
    return num_of_holds - 1;
  }

  function make_erc_20_hold(uint _seconds_to_hold, uint _num_of_tokens, address _erc_20_contract_address) public returns(uint) {
    IERC20 erc20_contract = IERC20(_erc_20_contract_address);
    erc20_contract.transferFrom(msg.sender, address(this), _num_of_tokens);
    Hold_Struct memory new_hold;
    new_hold.hold_id = num_of_holds;
    new_hold.addy = msg.sender;
    new_hold.seconds_to_hold = _seconds_to_hold;
    new_hold.date_hold_created = block.timestamp;
    new_hold.erc_20_contract_address = _erc_20_contract_address;
    num_of_holds += 1;
    return num_of_holds - 1;
  }

  function make_erc721_hold(address _contract_address, uint _token_id, uint _seconds_to_hold) public returns(uint) {
    Hold_Struct memory new_hold;
    IERC721 nft_contract = IERC721(_contract_address);
    nft_contract.transferFrom(address(msg.sender), address(this), uint256(_token_id));
    new_hold.hold_id = num_of_holds;
    new_hold.addy = msg.sender;
    new_hold.seconds_to_hold = _seconds_to_hold;
    new_hold.date_hold_created = block.timestamp;

    new_hold.nft_contract_addres = _contract_address;
    new_hold.nft_token_id = _token_id;

    holds[num_of_holds] = new_hold;
    num_of_holds += 1;
    return num_of_holds - 1;
  }

  function see_time_left(uint _hold_id) public view returns (uint) {
    return holds[_hold_id].date_hold_created + holds[_hold_id].seconds_to_hold - block.timestamp;
  }

  function collect_hold(uint _hold_id) public {
    Hold_Struct memory hold = holds[_hold_id];
    IERC721 nft_contract = IERC721(hold.nft_contract_addres);
    nft_contract.transferFrom(address(this), address(hold.addy), uint256(hold.nft_token_id));
  }

  function show_num_of_holds() public {
      emit print_num_of_holds(num_of_holds);
  }

}