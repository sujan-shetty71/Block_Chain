// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Election {

    function approveCandidiate(uint256 num) external;

    function setStart(uint256 start) external;

    function setStop(uint256 stop) external;

    function getResults() external;

}

contract ElectionCommision {
    
    address public admin;
    
    constructor() {

        admin = msg.sender;

    }

    modifier adminOnly() {

        require(msg.sender == admin,"No admin");
        _;

    }

    function approveCandidate(address election, uint256 id) public adminOnly {
        
        require(election != address(0), "invalid address");

        assert(election != 0x0000000000000000000000000000000000000001);

        Election e = Election(election);

        e.approveCandidiate(id);

    }


    function setStart(address election, uint256 time) public adminOnly {

        require(block.timestamp < time,"must be (starttime > now)");

        require(election != address(0), "invalid address");

        assert(election != 0x0000000000000000000000000000000000000001);
        
        Election e= Election(election);

        e.setStart(time);
        
    }


    function setStop(address election, uint256 time) public adminOnly {

        Election e = Election(election);

        e.setStop(time);

    }


    event consolePrint(string,bool);


    function withdraw() public {

        uint amount = address(this).balance;

        (bool success, ) = admin.call{value: amount}("");

        require(success, "Failed to send Ether");

        //emits the below statement if ether withdrawal is successfull 
        emit consolePrint(" Ether withdrawn successfully :) ", success);

    }
    
}