pragma solidity ^0.8.4;

contract Game {
    
    struct Gamer {
        bool jackpot;
        bool isExist;
    }
    
    mapping(address => Gamer) public gamers;
    
    string[9] public items = ["CHERRY", "LEMON", "DIAMOND", "WATERMELON", "BELL", "HEART", "SEVEN", "BAR", "HORSE"]; // slot items
    string[2] public outputs = ["JACKPOT" , "Try again"]; // output strings
    
    // start slot machine
    function start() external payable {
        
        uint256 userBalance = msg.value;
        require(userBalance > 0, "Balance too low!");
        
        gamers[msg.sender].isExist = true;
        
        uint first = spin();
        uint second = spin();
        uint third = spin();
        
        // is jackpot
        if (first == 7 && (first == second) && (second == third)){
            gamers[msg.sender].jackpot = true;
        }
    }
    
    // spin wheel (get random value)
    function spin() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 10;
    }
    
    // print result
    function getResult() external returns (string memory) {
        
        require(gamers[msg.sender].isExist, "User not exists");
        
        if (gamers[msg.sender].jackpot) return outputs[0];
        else return outputs[1];
    }
}