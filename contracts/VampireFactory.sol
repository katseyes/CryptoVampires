pragma solidity >=0.5.0 <0.6.0;

contract VampireFactory {

     event NewVampire(uint vampireId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Vampire {
        string name;
        uint dna;
    }

    Vampire[] public vampires;
    // maps a vampire to its owner
    mapping (uint => address) public vampireToOwner;
    // how many vampires an address has
    mapping (address => uint) ownerVampireCount;


    function _createVampire(string memory _name, uint _dna) internal {
        uint id = vampires.push(Zombie(_name, _dna)) - 1;
        vampireToOwner[id] = msg.sender;
        ownerVampireCount[msg.sender]++;
        emit NewVampire(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomVampire(string memory _name) public {
         require(ownerVampireCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createVampire(_name, randDna);
    }

}
