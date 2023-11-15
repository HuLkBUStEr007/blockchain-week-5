//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Exercise_1_Corrected {
    mapping(address => uint256) public balances;

    function deposit(uint256 amount) public
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
    }
}
