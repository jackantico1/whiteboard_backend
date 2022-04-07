// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.9;

contract hodl {

  uint num_of_hodls = 0;
  address payable addy_of_creator = payable(0x6f8C0b4bC4b50e5f688F9DD35F2E222c04CF15bC);

  struct Hodl_Struct {
    uint hodl_id;
    address payable addy;
    uint days_to_hodl;
    uint wei_stored;
    uint date_hodl_created;
  }

  mapping(uint => Hodl_Struct) hodls;

  function make_holding(uint _days_to_hodl) payable public returns(uint) {
    uint hodl_id = num_of_hodls;
    require(msg.value < 0.1 ether, "HODL was not created, insufficent funds");
    Hodl_Struct memory new_hodl;
    new_hodl.hodlID = num_of_hodls;
    new_hodl.addy = payable(msg.sender);
    new_hodl.seconds_to_hodl = _seconds_to_hodl;
    new_hodl.wei_stored = msg.value; 
    new_hodl.date_hodl_created = block.timestamp;
    hodls[num_of_hodls] = new_hodl;
    num_of_hodls += 1;
    return num_of_hodls - 1;
  }

  function collect_hodl(uint id) public {
    hodlStruct memory userHodl = hodls[id];
    require(block.timestamp > userHodl.dateHodlCreated + userHodl.secondsToHodl, 'HODL has not completed yet');
    addyOfCreator.transfer(0.001 ether);
    userHodl.addy.transfer(userHodl.weiStored - 0.001 ether);
  }

  function show_num_of_hodls() public view returns(uint _num_of_hodls){
    return num_of_hodls;
  }

  function show_time_left(uint id) public view returns(uint _time_left){
    require(id < num_of_hodls, 'Hodl not found');
    Hodl_Struct memory user_hodl = hodls[id];
    if (block.timestamp >= userHodl.date_hodl_created + user_hodl.seconds_to_hodl) {
      return 0;
    } else {
      return userHodl.dateHodlCreated + userHodl.secondsToHodl) - block.timestamp;
    }
  }
}