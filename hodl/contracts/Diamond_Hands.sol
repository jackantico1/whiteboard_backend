// SPDX-License-Identifier: MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.0;

contract Diamond_Hands_NFT {

  uint num_of_holds = 0;

  struct Hold_Struct {
    uint hold_id;
    address payable addy;
    uint seconds_to_hold;
    uint wei_stored;
    uint date_hold_created;
    address nft_contract_addres;
    uint nft_token_id;
    address erc_20_contract_address;
    uint erc_20_tokens_stored;
  }

  mapping(uint => Hold_Struct) holds;

  function make_nft_hold(address _contract_address, uint _token_id, uint _seconds_to_hold) public {
    ERC721 nft_contract = ERC721(_contract_address);
    Hold_Struct memory new_hold;
    new_hold.hold_id = num_of_holds;
    new_hold.addy = msg.sender;
    new_hold.seconds_to_hold = _seconds_to_hold;
    new_hold.date_hold_created = block.timestamp;

    new_hold.nft_contract_addres = _contract_address;
    new_hold.nft_token_id = _token_id;
    nft_contract.transferFrom(msg.sender, this, _token_id);

    holds[num_of_holds] = new_hold;
    num_of_holds += 1;
    return num_of_holds - 1;
  }

  function collect_hold(uint _hold_id) public {
    Hold_Struct memory hold = holds[_hold_id];
    ERC721 nft_contract = ERC721(hold.nft_contract_addres);
    nft_contract.transferFrom(this, msg.sender, hold.nft_token_id);
  }

}