pragma solidity ^0.8.4;

contract Game {
    
    struct Gamer {
        uint choice;
        bool isExist;
    }
    
    uint constant ROCK = 0;
    uint constant PAPER = 1;
    uint constant SCISSORS = 2;
    
    mapping(address => Gamer) public gamers;
    
    function play(uint choice) payable external {
        require(!gamers[msg.sender].isExist, "Already played"); // check the player hasnt played the move
        require(choice == ROCK || choice == PAPER || choice == SCISSORS, "Invalid choice :: only 0,1,2 available"); // check the move is valid
        
        gamers[msg.sender].isExist = true;
        
        //set choice
        gamers[msg.sender].choice = choice;
    }
    
    // get result
    function getResult(address a, address b) external view returns (address) {
        require(gamers[a].isExist && gamers[b].isExist, "User not exists");
        
        uint achoice = gamers[a].choice;
        uint bchoice = gamers[b].choice;
        
        //  if draw
        if (achoice == bchoice) {
            return address(0);
        }
        
        // set winning case
        if (achoice == ROCK && bchoice == PAPER) {
            return b;
        } else if (achoice == ROCK && bchoice == SCISSORS) {
            return a;
        } else if (achoice == PAPER && bchoice == ROCK) {
            return a;
        } else if (achoice == PAPER && bchoice == SCISSORS) {
            return b;
        } else if (achoice == SCISSORS && bchoice == ROCK) {
            return b;
        } else if (achoice == SCISSORS && bchoice == PAPER) {
            return a;
        }
        
    }
}