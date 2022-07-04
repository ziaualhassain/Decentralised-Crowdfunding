// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

/*
    Things we need in fundrising
    1.Goal Amount
         -> Total amount needed to be raised.
    2.Time
        -> Time to reach goal amount
    3.From(Investors)
        -> Amount from investors
    4.To(Managers) 
        ->One who deployed the contract so it need to be execute once the contract is deployed(Constructor)
    5.Sent Amount



    Addons
    1.Revert back
       -> Once the goal hasn't reached.
    2.Nft Release
       -> Once the goal is reached.
*/

contract Fundrsining{
     uint public endtime;
     uint public goalAmount;
     uint public goaltime;
     uint public totalamount;
     uint public noOfInvestors;
     address manager;
     mapping(address => uint) investors;

// Constructor to intiate the owner of the contract,goal time and total goal amount at the time of deployement.
    constructor(uint _time,uint _goalAmount){
        goaltime = _time;
        endtime = (block.timestamp)+goaltime;
        goalAmount= _goalAmount;
        manager = payable(msg.sender);
    }

//To get funds from investors
    function getFundsfromInvestors() public payable{
        require(totalamount >= goalAmount,"Goal reached"); //Checking whether the goal is fullfilled or not
        require(msg.sender != manager,"You can't fund your own contract"); //owner can't be an investor.
        investors[msg.sender]=msg.value;
        totalamount += msg.value ;
        noOfInvestors += 1;   
    }



//To send funds to the raiser.
    /*function sendFundstoOwner(address owner,uint totalamount) public payable{
        require(address.this(goalAmount) >= totalamount);
        owner.transfer((this.totalamount));        
    }*/

    function transferFundstoManager() public payable{
        require(totalamount <= goalAmount,"Can't the action perform rightnow");
        payable(manager).transfer(address(this).balance);  
    }

// If the funding hasn't been sucessfull it has to revert back to the investors
    function revertBacktoInvestors() public payable{
        
    }

}
