pragma solidity >=0.5.0 <0.6.0;

import "./VampireFeeding.sol";

contract VampireHelper is VampireFeeding 
{

  modifier aboveLevel(uint _level, uint _vampId) 
  {
    require(vampires[_vampId].level >= _level);
    _;
  }

    uint levelUpFee = 0.001 ether;

   function changeName(uint _vampireId, string calldata _newName) external aboveLevel(2, _vampireId) onlyOwnerOf(_vampireId){
   // require(msg.sender == vampireToOwner[_vampireId]);
    vampires[_vampireId].name = _newName;
  }

  function changeDna(uint _vampireId, uint _newDna) external aboveLevel(20, _vampireId) onlyOwnerOf(_vampireId){
   // require(msg.sender == vampireToOwner[_vampireId]);
    vampires[_vampireId].dna = _newDna;
  }


function withdraw() external onlyOwner {

    // Casting any integer type like uint160 to address produces an address payable.
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  

  }

  function setLevelUpFee(uint _fee) external onlyOwner
  {
    levelUpFee = _fee;
  }



  function levelUp(uint _vampireId) external payable
  {
    require(msg.value == levelUpFee);
    vampires[_vampireId].level++;
  }


  // external view is gas free!!! 
  function getVampiresByOwner(address _owner) external view returns (uint[] memory)
  {
      uint nbvamps = vampireToOwner[_owner];
      // possible even if external view?
      require(nbvamps > 0);
      uint[] memory result = new uint[](nbvamps);
      
      uint counter = 0;

      for (uint i =0; i < vampires.length;i++)
      {
          if (vampireToOwner[i] == _owner)
          {
              result[counter] = i;
              counter++;
          }
      }

      return result;
    
    //mapping (uint => address) public vampireToOwner;

  }

}
