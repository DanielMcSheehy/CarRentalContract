pragma solidity ^0.4.18;

contract CarRental {

  struct Car {
    address owner;
    address renter;
    string carMake;
    string license;
    uint16 monthlyRent;
    uint32 startDate;
    uint32 nextPaymentDate; //
  }

  Car[] public cars;

  mapping (uint => address) carToOwner;
  mapping (address => uint) carNum;
  

  function _createCarRental(address renter, string carMake, string license, uint16 monthlyRent) internal {
    uint index = cars.push(Car(msg.sender, renter, carMake, license, monthlyRent, uint32(now), uint32(now + 1 days))) - 1;
    carToOwner[index] = msg.sender;
    carNum[msg.sender]++;
  }

  function deployCarRental(address renter, string carMake, string license, uint16 monthlyRent) public {
    _createCarRental(renter, carMake,  license,  monthlyRent);
  }

  function setRent(uint _value) public {
    value = _value;
  }

  function getRent(uint index) public constant returns (uint) {
    cars[index].monthlyRent;
    return value;
  }

  function payRent(uint index) public view { // TODO: scheduling Payable 
    require(msg.sender == cars[index].renter);
    //uint day = cars[index].nextPaymentDate;
    //day++;
  }

  uint value;
}
