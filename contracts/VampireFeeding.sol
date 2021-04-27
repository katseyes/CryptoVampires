pragma solidity >=0.5.0 <0.6.0;

import "./VampireFactory.sol"

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}


contract VampireFeeding is VampireFactory 
{
    // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // KittyInterface kittyContract = KittyInterface(ckAddress);


  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }




    // pb: peut etre appelée plusieurs fois?
    // pb on peut l'appeler avec un dna bidon (car public)
    function feedAndMultiply(uint _vampId, uint _targetDna,string memory _species) public 
    {
      // user must be used vampire owner
        require(msg.sender == vampireToOwner[_vampId]);
        // pourquoi storage ici? sachant qu'on ne va pas la modifier, ce serait peut-être mieux memory?
        Vampire storage myVamp = vampires[_vampId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myVamp.dna + _targetDna) / 2;

        // for kitty species we add 99 in dna
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            // replace the 2 last numbers by "99"
            newDna = newDna - newDna % 100 + 99;
        }
        _createVampire("NoName", newDna);
    }

    // pb peut etre appelée plusieurs fois avec le même kittyid
    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        // And modify function call here:
        feedAndMultiply(_zombieId, kittyDna,"kitty");
  }

}
