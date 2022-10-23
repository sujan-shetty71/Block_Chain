// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
 
contract MultiSigWallet {
 
    struct transaction {
        bool executed;
        uint8 approvals;
        address to;
        uint256 value;
        bytes data;
    }
 
    uint8 public approvalcount;
    address[] owners;
    uint256 transactionId;
    mapping(uint256 => transaction) public transactions;
    mapping( uint256 => mapping(address=>bool)) public ownerApprovals;
 
    constructor(address[] memory _owners,  uint8 count) {
        owners = _owners;
        approvalcount = count;
    }
 
    receive() external payable {}
 
    function isOwner (address o) private view returns (bool){
        bool flag = false;
        for(uint8 i =0; i < owners.length ; i++){
            if( o == owners[i]){
                flag = true;
                break;
            }
        }
        return flag;
    }
 
    modifier onlyOwner()  {
        require(isOwner(msg.sender),"No Owner");
        _;
    }
 
    modifier isTransaction(uint256 tId)  {
        require(transactions[tId].to != address(0x00), "No Owner");
        _;
    }
 
    function getOwners() external view returns (address[] memory) {
        return owners;
    }
 
    function submitTransaction(address to, uint256 value, bytes calldata data) external onlyOwner {
        //check
        require(to != address(0x00),"Zero address");
        transaction memory t = transaction(false, 0, to, value, data);
        transactions[transactionId] = t;
        ++transactionId;
    }
 
    function approveTransaction( uint256 tID) external onlyOwner isTransaction(tID) {
        require(ownerApprovals[tID][msg.sender] == false, "already approved");
 
        // logic
        ownerApprovals[tID][msg.sender] = true;
        transactions[tID].approvals = transactions[tID].approvals + 1;
    }
 
    function executeTransaction( uint256 tID) external onlyOwner isTransaction(tID) {
        //check
        require( transactions[tID].executed == false, "already executed");
        require(transactions[tID].approvals >= approvalcount, "cannot execute");
 
        // update state
        transactions[tID].executed =true;
 
        // go out of the contract
        (bool status, ) = transactions[tID].to.call{value: transactions[tID].value}( transactions[tID].data);
 
        require(status,"transaction failed");
 
    }
   
    function revertApproval(uint256 tID) external onlyOwner {
        require(transactions[tID].executed != true, "Can't be revert");

        require(ownerApprovals[tID][msg.sender] != false, "No need to revert");
        
        ownerApprovals[tID][msg.sender] = false;

        transactions[tID].approvals = transactions[tID].approvals - 1;
     }
     uint public balance;
    function contribute() public payable
    {
        // msg.value is the value of Ether sent in a transaction
        balance += msg.value;
    }
}

//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]