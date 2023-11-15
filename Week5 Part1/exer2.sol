//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Exercise_2 {
    mapping(address => uint256) public balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        (bool success, ) = payable (msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    function addBalances( uint256 amount) public onlyOwner {
        balances[msg.sender] += amount;
    }

    function subtractBalances( uint256 amount) public onlyOwner {
        balances[msg.sender] -= amount;
    }

    function destroyContract(address payable recipient) public onlyOwner {
        selfdestruct(recipient);
    }
}
