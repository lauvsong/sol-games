pragma solidity ^0.8.4;

contract Game {
    
    struct Voter {
        uint horse;
        uint val;
        bool isExist;
    }
    
    mapping(address => Voter) voters;
    uint winner;
    bool raceFinish;
    
    // betting
    // input : horse to vote
    function bet(uint horse) external payable {
        require(!voters[msg.sender].isExist, "Already bet");
        require(horse == 1 || horse == 2 || horse == 3, "Invalid choice :: only 1,2,3 available");
        
        voters[msg.sender].horse = horse;
        voters[msg.sender].val = msg.value;
        voters[msg.sender].isExist = true;
    }
    
    // set winner horse
    function race() external {
        winner = random();
        raceFinish = true;
    }
    
    // get result :: success or fail
    function getResult() external returns (string memory){
        require(raceFinish, "Race first");
        require(voters[msg.sender].isExist, "User not exists");
        if (voters[msg.sender].horse == winner){
            return "Success";
        } else return "Fail";
    }

    // get random value
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 3 + 1;
    }
}