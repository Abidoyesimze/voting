// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    
    string public proposalTitle;
    bool public voteEnded;
    address public owner;

    
    uint public votesForA;
    uint public votesForB;

    
    mapping(address => bool) public hasVoted;

    
    constructor() {
        owner = msg.sender;
    }

    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner has access to this");
        _;
    }

    
    function createVote(string memory _title) external onlyOwner {
        proposalTitle = _title;
        votesForA = 0;
        votesForB = 0;
        voteEnded = false;
    }

    
    function vote(uint option) external {
        require(!hasVoted[msg.sender], "You can only vote once");
        require(!voteEnded, "Voting has ended");
        require(option == 1 || option == 2, "Invalid option");

        if (option == 1) {
            votesForA++;
        } else {
            votesForB++;
        }

        hasVoted[msg.sender] = true;
    }

    
    function endVote() external onlyOwner {
        voteEnded = true;
    }

    
    function winner() external view returns (string memory) {
        require(voteEnded, "Voting has not ended yet");

        if (votesForA > votesForB) {
            return "Option A is the winner!";
        } else if (votesForB > votesForA) {
            return "Option B is the winner!";
        } else {
            return "It's a tie!";
        }
    }
}
