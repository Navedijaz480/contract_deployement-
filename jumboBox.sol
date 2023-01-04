//SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 contract jumboBox{

 address  owner; 
 address[] private player;

  mapping (address => uint256) private boxValue; 
  
   constructor( )
      { 
         owner=msg.sender; 
      }
    modifier onlyOwner
      {
          require(owner ==msg.sender ,"only owner can run" );
          _;
       }

    function playGame() public payable
       {
             require(msg.value > 1000000000000000 , "please enter correct amount of box");
   
             boxValue[msg.sender] = msg.value;
             player.push(msg.sender);
              }
   

    function array_length() private view returns(uint256)
     {
        return player.length;
     }
   
    function random() private view returns(uint256 winAmpunt)
       {
          return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, player)));
      }
   function pickWinner() public  returns(address winner , uint256 amount )
       {
         require (player.length>=3 ,"please again open the box to win");
           uint index = random() % player.length;
            address a = player[index];
            uint256 b =boxValue[player[index]]+((boxValue[player[index]]*20)/100);
            payable(player[index]).transfer(b);
            delete player;  
            
            return (a , b);
        }  

     function withdrawBnb() public payable onlyOwner 
            {
                payable(msg.sender).transfer(address(this).balance);
            }  
    function transferOwnerShip( address addr ) public onlyOwner 
    {
       require(addr!=address(0) ,"enter correct address");
         owner =addr;
    }
   
}
