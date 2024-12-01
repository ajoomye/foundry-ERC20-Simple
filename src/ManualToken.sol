//SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract ManualToken{

    mapping(address => uint256) private s_balances; // mapping to store the balances of the token holders
    
    function name() public pure returns(string memory){
        return "Manual Token";
    }
    
    function totalSupply() public pure returns(uint256){
        return 100 ether;
    }

    function decimals() public pure returns(uint8){
        return 18;
    }

    function balanceOf(address _owner) public view returns(uint256){
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns(bool){
        uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _value;
        s_balances[_to] += _value;
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalance);

    }



}