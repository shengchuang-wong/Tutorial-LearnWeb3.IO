// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract GoodContract {
    mapping(address => uint256) public balances;

    // Update the `balances` mapping to include the new ETH deposited by msg.sender
    function addBalance() public payable {
        balances[msg.sender] += msg.value;
    }

    // Send ETH worth `balances[msg.sender]` back to msg.sender
    function withdraw() public {
        require(balances[msg.sender] > 0);
        (bool sent, ) = msg.sender.call{value: balances[msg.sender]}("");
        require(sent, "Failed to send ether");
        // This code becomes unreachable because the contract's balance is drained
        // before user's balance could have been set to 0
        balances[msg.sender] = 0;
    }
}

/*
Prevention
There are two things you can do.
Either, you could recognize that this function was vulnerable to re-entrancy, and make sure you update the user's balance in the withdraw function before you actually send them the ETH, so if they try to callback into withdraw it will fail.
Alternatively, OpenZeppelin has a ReentrancyGuard library that provides a modifier named nonReentrant which blocks re-entrancy in functions you apply it to. It basically works like the following:

modifier nonReentrant() {
    require(!locked, "No re-entrancy");
    locked = true;
    _;
    locked = false;
}

If you were to apply this on the withdraw function, the callbacks into withdraw would fail because locked will be equal to true until the first withdraw function finishes executing, thereby also preventing re-entrancy.
*/
