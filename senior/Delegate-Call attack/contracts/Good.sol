//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Good {
    address public helper;
    address public owner;
    uint256 public num;

    constructor(address _helper) {
        helper = _helper;
        owner = msg.sender;
    }

    function setNum(uint256 _num) public {
        helper.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num));
    }
}

// Prevention
// Use stateless library contracts which means that the contracts to which you deletegate the call should only be used for execution of logic and should not maintain state.
