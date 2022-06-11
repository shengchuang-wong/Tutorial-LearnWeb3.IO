//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./Helper.sol";

contract Good {
    Helper helper;

    constructor(address _helper) payable {
        helper = Helper(_helper);
    }

    function isUserEligible() public view returns (bool) {
        return helper.isUserEligible(msg.sender);
    }

    function addUserToList() public {
        helper.setUserEligible(msg.sender);
    }

    fallback() external {}
}

/*
Prevention
Make the address of the external contract public and also get your external contract verified so that all users can view the code

Create a new contract, instead of typecasting an address into a contract inside the contuctor. So instead of doing Helper(_helper) where you are typecasting _helper address into a contract which may or may not be the Helper contract, create an explicit new helper contract instance using new Helper().

Example

contract Good {
    Helper public helper;
    constructor() {
        helper = new Helper();
    }
*/
