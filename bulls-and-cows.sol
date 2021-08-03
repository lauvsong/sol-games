pragma solidity ^0.8.4;

contract Game {
    
    struct Gamer {
        uint strike;
        uint ball;
        bool isExist;
    }
    
    mapping(address => Gamer) public gamers;
    uint[3] public answer;
    
    // play bulls and cows
    // input ex : [2,8,9]
    function play(uint[3] memory num) external payable {
        clearAnswer();
        setAnswer();
        
        gamers[msg.sender].isExist = true;
        
        // count strike, ball
        for (uint i=0;i<3;i++) {
            if (num[i] == answer[i]) {
                gamers[msg.sender].strike += 1;
            } else {
                for (uint j=0;j<3;j++) {
                    if (num[i] == answer[j]) {
                        gamers[msg.sender].ball += 1;
                    }
                }
            }
        }
    }
    
    // set correct answer
    function setAnswer() private {
        for (uint i=0; i<3; i++) {
            answer[i] = random();
        }
    }
    
    // set answer 0
    function clearAnswer() private {
        answer[0] = 0;
        answer[1] = 0;
        answer[2]= 0;
    }
    
    // get game result :: strike & ball
    function getResult() external payable {
        require(gamers[msg.sender].isExist, "User not exists");
        emit Strike(gamers[msg.sender].strike);
        emit Ball(gamers[msg.sender].ball);
    }
    
    // get random value
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp))) % 10;
    }
    
    event Strike(uint strike);
    event Ball(uint ball);
}