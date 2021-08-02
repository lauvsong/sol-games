pragma solidity ^0.6.0;

contract Game {
    uint8 constant ROCK = 0;
    uint8 constant PAPER = 1;
    uint8 constant SCISSORS = 2;
    
    mapping(address => uint8) public choices;
    
    function play(uint8 choice) payable external {
        // check the move is valid
        require(choice == ROCK || choice == PAPER || choice == SCISSORS);
        // check the player hasnt played the move
        require(choices[msg.sender] == 0);
        
        //set choice
        choices[msg.sender] = choice;
    }
    
    function evaluate(address alice, address bob) external view returns (address) {
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