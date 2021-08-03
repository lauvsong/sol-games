pragma solidity ^0.8.4;

contract Game {
    
    struct Voter {
        uint horse;
        uint val;
        bool isExist;
    }
    
    mapping(address => Voter) voters;
    uint winner;
    
    // betting
    // input : horse to vote
    function bet(uint horse) external payable {
        require(horse >= 1 && horse <= 3, "only 1~3 available");
        
        voters[msg.sender].horse = horse;
        voters[msg.sender].val = msg.value;
        voters[msg.sender].isExist = true;
    }
    
    // set winner horse
    function play() external {
        winner = random();
    }
    
    // get result :: success or fail
    function getResult(address user) external returns (string memory){
        require(voters[user].isExist, "User not exists");
        if (voters[user].horse == winner){
            return "Success";
        } else return "Fail";
    }

    // get random value
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 3 + 1;
    }
}