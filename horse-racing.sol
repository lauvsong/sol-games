pragma solidity ^0.8.4;

contract Game {
    
    struct Voter {
        uint horse;
        uint val;
        bool isExist;
    }
    
    mapping(address => Voter) voters;
    uint winner;
    
    function bet(uint horse) external payable {
        voters[msg.sender].horse = horse;
        voters[msg.sender].val = msg.value;
        voters[msg.sender].isExist = true;
    }
    
    function play() external {
        winner = random();
    }
    
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