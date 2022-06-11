//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Good {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setOwner(address newOwner) public {
        require(tx.origin == owner, "Not owner");
        owner = newOwner;
    }
}
/*
Real Life Example
While this may seem obvious to most of you, as tx.origin isn't something you see being used at all, some developers do make this mistake. You can read about the THORChain Hack #2 here where users lost millions in $RUNE due to an attacker being able to get approvals on $RUNE token by sending a fake token to user's wallets, and approving that token for sale on Uniswap would transfer $RUNE from the user's wallet to the attacker's wallet because THORChain used tx.origin for transfer checks instead of msg.sender.

Prevention
You should use msg.sender instead of tx.origin to not let this happen
*/
