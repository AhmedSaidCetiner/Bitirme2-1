// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract drawapps {

  address owner;

  constructor() {
    owner = msg.sender;
  }

  struct Player {
    address player;
    uint amount;
  }

  Player[] public players;
  uint public     totalAmount;
  uint public     totalInvest;
  uint public     limit = 5;
  uint public     depositLimit = 0.0001*10**18;
  uint public     adminPay;

  event eDeposit(address indexed adres, uint amount);
  event eWinner(address indexed  addre, uint amount);

  fallback() external payable onlyOwner{
    require(msg.value != 0, "Yetkisiz Kullanim");
  }

  receive() external payable  onlyOwner {
    require(msg.value != 0, "Yetkisiz Kullanim");
  }

  modifier onlyOwner() {
    require(msg.sender == owner,"Sadece yetkili islem yapabilir");
    _;
  }

  function random(uint number) private view returns (uint){
    return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty, msg.sender))) % number;
  }

  function deposit () payable public {

    require(msg.value >= depositLimit, "Minumum 2 Ethereum veya BNB");
    require(msg.sender != address(0));

    uint adminGain = calculatePercentage(msg.value, 200);

    Player memory p = Player({
      player : msg.sender,
      amount : msg.value
    });

    players.push(p);
    totalAmount += msg.value - adminGain;
    adminPay += adminGain;
    totalInvest++;

    emit eDeposit(msg.sender, msg.value);

    if (totalInvest == limit){
      address winnerUserAdress = players[random(limit)].player;
      uint    winnerAmount     = totalAmount;
      winner(winnerUserAdress, winnerAmount);
      delete players;
      totalAmount = 0;
      totalInvest = 0;

    }
  }

  function winner (address _address, uint _amount) internal {
    payable(_address).transfer(_amount);

    address defaultAdminAddress = 0x2A3CC03b9303324557Ecc5a6BbE79e505faCf0c2;
    payable(defaultAdminAddress).transfer(adminPay);

    emit eWinner(_address, _amount);
  }

  function setLimit (uint _limit)  public onlyOwner{
    limit = _limit;
  }

  function setDepositLimit(uint _limit) public onlyOwner {
    depositLimit = _limit;
  }

  function getLimit() public view returns(uint){
    return limit;
  }

  function getTotalAmount() public view returns(uint){
    return totalAmount;
  }

  function getTotalInvest() public view returns(uint){
    return totalInvest;
  }

  function getDepositLimit() public view returns(uint){
    return depositLimit;
  }

  function calculatePercentage(uint _amount, uint percentage) internal pure returns(uint){
    return _amount * percentage / 10000;
  }

  function getPlayers () public view returns(Player [] memory){
    return players;
  }
}