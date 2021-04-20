pragma solidity >=0.5.0 <0.6.0;

contract VampireFactory {

    // declare our event here

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Vampire {
        string name;
        uint dna;
    }

    Vampire[] public vampires;

    function _createVampire(string memory _name, uint _dna) private {
        vampires.push(Vampire(_name, _dna));
        // and fire it here
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomVampire(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createVampire(_name, randDna);
    }

}
