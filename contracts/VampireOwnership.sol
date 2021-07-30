pragma solidity >=0.5.0 <0.6.0;

import "./VampireAttack.sol";
import "./erc721.sol";


contract VampireOwnership is VampireAttack,ERC721
 {

   mapping (uint => address) vampireApprovals;


function balanceOf(address _owner) external view returns (uint256) {
    return ownerVampireCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return vampireToOwner[_tokenId];
  }

  function _transfer(address _from,address _to,uint256 _tokenId) private
  {
    require(vampireToOwner[_tokenId] ==_from);
    ownerVampireCount[_to] = ownerVampireCount[_to].add(1);
    ownerVampireCount[_from] = ownerVampireCount[_from].sub(1);
    vampireToOwner[_tokenId] = _to;

    emit Transfer(_from,_to, _tokenId);
  }


// manque le test d'appartenance
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require((vampireToOwner[_tokenId] == msg.sender)||(vampireApprovals[_tokenId] == msg.sender));
    _transfer( _from,  _to,  _tokenId);
  }
    
  // 1. Add function modifier here
  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
    vampireApprovals[_tokenId] = _approved;
     emit Approval(msg.sender, _approved, _tokenId);
  }

  
}