pragma solidity ^0.5.0;

contract Election {
    //Model a candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }
    //store accounts that have voted
    mapping(address => bool) public voters;
    //store candidates
    mapping(uint256 => Candidate) public candidates;
    //Store the candidates count because there is no function in solidity for counting the mapping elements 
    uint256 public candidatesCount;

    //voted event
    event votedEvent(uint256 indexed _candidateId);

    constructor() public {//whenever our projects is migrated and deployed only this code will execute
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
//this will add the candidate and it is private because we only want the contract to do this not any other
    function addCandidate(string memory _name) private {
        //counting the candidates manually
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);//0 is the votecount
    } 

    function vote(uint256 _candidateId) public {
        //require that they havent voted before
        require(!voters[msg.sender]);
        //require a valid candidate to
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        //record that voter has voted
        voters[msg.sender] = true;
        //update candidate vote count
        candidates[_candidateId].voteCount++;

        //trigger voted event
        emit votedEvent(_candidateId);
    }
}
