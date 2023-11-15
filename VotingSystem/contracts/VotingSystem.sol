
Certainly! Here's the provided Solidity code with added comments to explain each step:

solidity
Copy code
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// Contract to implement a simple voting system
contract VotingSystem {
    address public owner; // Address of the contract owner
    string[] public candidates; // Array to store candidate names
    mapping(address => bool) public Voters; // Mapping to track whether an address has voted
    mapping(uint256 => uint256) public VotesReceived; // Mapping to store vote count for each candidate

    event Voted(address indexed voter, uint256 candidateIndex); // Event to log a vote

    // Modifier to restrict access to functions to only the owner of the contract
    modifier OnlyOwner() {
        require(msg.sender == owner, "Only Owner Can Perform Add Or Remove Function");
        _;
    }

    // Constructor to initialize the contract with a list of candidates
    constructor(string[] memory _candidates) {
        owner = msg.sender; // Set the contract deployer as the owner
        candidates = _candidates; // Initialize the candidates array
    }

    // Function to allow the owner to add a new candidate
    function addCandidate(string memory candidate) public OnlyOwner {
        candidates.push(candidate); // Add a new candidate to the array
    }

    // Function to allow the owner to remove a candidate
    function removeCandidate(uint index) public OnlyOwner {
        require(index < candidates.length, "Candidate not found");
        candidates.pop(); // Remove the candidate from the array
    }

    // Function to allow a voter to cast a vote for a candidate
    function vote(uint256 candidateIndex) external {
        require(candidateIndex < candidates.length, "Invalid Candidate Index");
        require(!Voters[msg.sender], "Already voted");
        
        Voters[msg.sender] = true; // Mark the sender's address as having voted
        VotesReceived[candidateIndex] += 1; // Increment the vote count for the chosen candidate
        
        emit Voted(msg.sender, candidateIndex); // Emit the Voted event
    }

    // Function to check if a specific address has already voted
    function hasVoted(address Voter) public view returns (bool) {
        return Voters[Voter];
    }

    // Function to get the total number of votes received by a specific candidate
    function getTotalVotes(uint256 candidateIndex) public view returns (uint256) {
        require(candidateIndex < candidates.length, "Invalid candidate index");
        return VotesReceived[candidateIndex];
    }

    // Function to get the total number of candidates
    function getCandidatesCount() public view returns (uint256) {
        return candidates.length;
    }

    // Function to get the name of a candidate based on the index
    function getCandidateName(uint256 index) public view returns (string memory) {
        require(index < candidates.length, "Invalid candidate index");
        return candidates[index];
    }
}