pragma solidity ^0.4.18;

contract CarRental {

  struct Car {
    address owner;
    address renter;
    string carMake;
    string license;
    uint16 dailyRent;
    uint32 startDate;
  }

  Car[] public cars;

  mapping (uint => address) carToOwner;
  mapping (address => uint) carNum;
  

  function _createCarRental(address renter, string carMake, string license, uint16 dailyRent) internal {
    uint index = cars.push(Car(msg.sender, renter, carMake, license, dailyRent, uint32(now))) - 1;
    carToOwner[index] = msg.sender;
    carNum[msg.sender]++;
  }

  function deployCarRental(address renter, string carMake, string license, uint16 dailyRent) public {
    _createCarRental(renter, carMake,  license,  dailyRent);
  }

  function setRent(uint _value) public {
    value = _value;
  }

  function getRent(uint index) public constant returns (uint) {
    cars[index].dailyRent;
    return value;
  }

  function getPaymentDue(uint index) public constant returns (uint) {
    uint rate = cars[index].dailyRent;
    uint daysOwed = (now - cars[index].startDate)/(1 days);
    return rate*daysOwed;
  }

  function payRent(uint index) public payable returns (bool) { // TODO: scheduling Payable 
    require(msg.sender == cars[index].renter);
    uint owedPayment = getPaymentDue(index);
    if (msg.value == owedPayment) {
      return true; 
    }
    else if (msg.value > owedPayment) {
      msg.sender.transfer(msg.value - owedPayment);
    } else {
      return false;
    }
  }

  uint value;
}
