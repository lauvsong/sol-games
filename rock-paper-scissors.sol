pragma solidity ^0.8.4;

contract Game {
    uint8 constant ROCK = 0;
    uint8 constant PAPER = 1;
    uint8 constant SCISSORS = 2;
    
    mapping(address => uint8) public choices;
    
    function play(uint8 choice) payable external {
        require(choice == ROCK || choice == PAPER || choice == SCISSORS); // check the move is valid
        require(choices[msg.sender] == 0); // check the player hasnt played the move
        
        //set choice
        choices[msg.sender] = choice;
    }
    
    // get result
    function getResult(address alice, address bob) external view returns (address) {
        //  if draw
        if (choices[alice] == choices[bob]) {
            return address(0);
        }
        
        // set winning case
        if (choices[alice] == ROCK && choices[bob] == PAPER) {
            return bob;
        } else if (choices[alice] == ROCK && choices[bob] == SCISSORS) {
            return alice;
        } else if (choices[alice] == PAPER && choices[bob] == ROCK) {
            return alice;
        } else if (choices[alice] == PAPER && choices[bob] == SCISSORS) {
            return bob;
        } else if (choices[alice] == SCISSORS && choices[bob] == ROCK) {
            return bob;
        } else if (choices[alice] == SCISSORS && choices[bob] == PAPER) {
            return alice;
        }
        
    }
}