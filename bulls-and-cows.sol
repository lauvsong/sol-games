pragma solidity ^0.6.0;

contract Game {
    
    struct Gamer {
        bool result;
        bool isExist;
    }
    
    mapping(address => Gamer) public gamers;
    string[3] public outputs = ["S", "B", "OUT"];
    uint answer;
    
    // play bulls and cows
    function play(uint num) external payable {
        clearAnswer();
        setAnswer();
        
        gamers[msg.sender].isExist = true;
        
        if (num == answer) {
            gamers[msg.sender].result = true;
        }
    }
    
    // set correct answer
    function setAnswer() private {
        for (uint i=0; i<3; i++) {
            answer = answer*10 + random();
        }
    }
    
    // set answer 0
    function clearAnswer() private {
        answer = 0;
    }
    
    // get game result
    function getResult(address user) external returns (string memory) {
        require(gamers[user].isExist, "User not exists");
        return answer;
    }
    
    // get random value
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 10;
    }
}