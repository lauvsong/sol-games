pragma solidity ^0.6.0;

contract Game {
    
    mapping(address => uint) public results;
    string[9] public items = ["CHERRY", "LEMON", "DIAMOND", "WATERMELON", "BELL", "HEART", "SEVEN", "BAR", "HORSE"];
    string[2] public outputs = ["JACKPOT" , "Try again"];
    
    // start slot machine
    function start() external payable {
        
        uint256 userBalance = msg.value;
        require(userBalance > 0, "Balance too low!");
        
        uint first = spin();
        uint second = spin();
        uint third = spin();
        
        if (first == 7 && (first == second) && (second == third)){
            results[msg.sender] = 1;
        } else {
            results[msg.sender] = 2;
        }
    }
    
    // spin wheel (get random value)
    function spin() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 10;
    }
    
    // print result
    function getResult(address user) external returns (string memory) {
        
        require(results[user] != 0, "User not exists");
        
        if (results[user] == 1) return outputs[0];
        else return outputs[1];
    }
}