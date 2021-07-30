pragma solidity >=0.5.0 <0.6.0;

import "./VampireHelper.sol";

contract VampireAttack is VampireHelper
{
  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  // unsafe random because a private node could play the transaction until random is ok and then include it in the blockchain
  function randMod(uint _modulus) internal returns (uint)
  {
     randNonce = randNonce.add(1);
   return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;

  }

  // 1. Add modifier here
  function attack(uint _vampireId, uint _targetId) external onlyOwnerOf(_vampireId){
    Vampire storage myVampire = vampires[_zombieId];
    Vampire storage enemyVampire = vampires[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability)
    {
      myVampire.winCount=myVampire.winCount.add(1);
       myVampire.level = myVampire.level.add(1);
      enemyVampire.lossCount =  enemyVampire.lossCount.add(1);
      feedAndMultiply(_vampireId, enemyVampire.dna, "vampire");
    }
     else
    {
       myVampire.lossCount =myVampire.lossCount.add(1);
      enemyVampire.winCount = enemyVampire.winCount.add(1);
       _triggerCooldown(myVampire);
    }
  }
} 