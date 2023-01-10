/**
 *Submitted for verification at BscScan.com on 2023-01-01
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;


interface IBEP20 {
    
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        return c;
    }
}


contract Ownable   {
    address public _owner;
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor()  {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }
    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
       return _owner;
    }
    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }
    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Crypto_TENCARD  is Ownable{
    
    using SafeMath for uint256;
    IBEP20 public Token;
    constructor(IBEP20 _Token) 
    {
        Token = _Token;
        cardPrice[1]=5000000000000000000;
        cardPrice[2]=6000000000000000000;
        cardPrice[3]=7000000000000000000;
        cardPrice[4]=7500000000000000000;
        cardPrice[5]=8000000000000000000;
        cardPrice[6]=9000000000000000000;
        cardPrice[7]=10000000000000000000;
        cardPrice[8]=20000000000000000000;
        cardPrice[9]=50000000000000000000;
       cardPrice[10]=100000000000000000000;
    }
    uint256 [100] card_probability= [1,1,1,1,1,1,1,1,1,1,
    2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,
    4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,
    6,6,6,6,6,6,6,6,6,6,
    7,7,7,7,7,7,7,7,7,7, 8,8,8,8,8,8,8,8,8,8,
    9,9,9,9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,10,10];
    
    uint256 minimumBet = 1E18;
    uint256 maximumBet = 40000E18;

    mapping (address => uint256 []) public amount;
    mapping (address => uint256 []) public Card_No;
    mapping (address => uint256 []) public _card_Price;
    mapping (uint256 => uint256 ) public cardPrice;
    
    event Withdraw(address  user, uint256 amount,uint256 time);    
    event BetAmount(address indexed user, uint256 amount, uint256 card,uint256 time);
    
    function Bet_Amount(uint256 _amount) public {
        
        require(_amount >= minimumBet, "minimumBet 100 ");
        require(_amount <= maximumBet, "maximumBet 4000");
        uint256 cardprice; 
        uint256 card_No = (uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, card_probability.length))))%card_probability.length;
        Token.transferFrom(msg.sender,address(this), _amount);
        
        if(card_probability[card_No] == 1){
            
           cardprice = ((_amount*cardPrice[1]).div(100))/1E18;

        }
        else if(card_probability[card_No] == 2){
            
            cardprice = ((_amount*cardPrice[2]).div(100))/1E18;
        }
        else if(card_probability[card_No] == 3){
            
            cardprice = ((_amount*cardPrice[3]).div(100))/1E18;
        }
        else if(card_probability[card_No] == 4){
            
            cardprice = ((_amount*cardPrice[4]).div(100))/1E18;
        }
        else if(card_probability[card_No] == 5){
            
            cardprice = ((_amount*cardPrice[5]).div(100))/1E18;
        }
        else if(card_probability[card_No] == 6){
            
            cardprice = ((_amount*cardPrice[6]).div(100))/1E18;
        }
         else if(card_probability[card_No] == 7){
            
            cardprice = ((_amount*cardPrice[7]).div(100))/1E18;
        }
         else if(card_probability[card_No] == 8){
            
            cardprice = ((_amount*cardPrice[8]).div(100))/1E18;
        }
         else if(card_probability[card_No] == 9){
            
            cardprice = ((_amount*cardPrice[9]).div(100))/1E18;
        }
         else if(card_probability[card_No] == 10){
            
            cardprice = ((_amount*cardPrice[10]).div(100))/1E18;
        }
        
        
        
        
        

        amount[msg.sender].push(_amount);
        Card_No[msg.sender].push(card_probability[card_No]);
        _card_Price[msg.sender].push(cardprice);
        
        emit BetAmount(msg.sender,_amount,card_probability[card_No],uint40(block.timestamp));
    }

    
    function withdraw(uint256[] memory _index) public {
    uint256 TotalAmount;
    for (uint256 z; z < _index.length; z++) {   
       
    TotalAmount +=_card_Price[msg.sender][_index[z]];
   }
   
    for (uint256 z; z < _index.length; z++) { 
    for(uint i = _index[z]; i <  amount[msg.sender].length - 1; i++) {
      amount[msg.sender][i] = amount[msg.sender][i + 1];
      Card_No[msg.sender][i] = Card_No[msg.sender][i + 1];
      _card_Price[msg.sender][i] = _card_Price[msg.sender][i + 1];
    }
     
    amount[msg.sender].pop();
    Card_No[msg.sender].pop();
    _card_Price[msg.sender].pop();
  }
  
    Token.transfer(msg.sender,TotalAmount);  
    emit Withdraw(msg.sender,TotalAmount,block.timestamp);
    }
  
    
         function UserInfo (address _add) public view returns (uint256[] memory usersAmount,uint256[] memory usersCardNo,uint256[] memory usersCardPrice)
    {
        uint lengthAmount = amount[_add].length;
        uint lengthCardNo = Card_No[_add].length;   
        uint lengthCardPrice = _card_Price[_add].length;
        
        usersAmount = new uint256[](lengthAmount);
        usersCardNo = new uint256[](lengthCardNo);
        usersCardPrice = new uint256[](lengthCardPrice);        
        
        for(uint i = 0; i < lengthAmount; i++)
        {
            usersAmount[i] = amount[_add][i];
            usersCardNo[i] = Card_No[_add][i];
            usersCardPrice[i] = _card_Price[_add][i];
        }   
    }
        function emergencyWithdraw(uint256 SMSAmount) public onlyOwner {
        Token.transfer(msg.sender, SMSAmount);
    }
        function emergencyWithdrawBNB(uint256 Amount) public onlyOwner {
        payable(msg.sender).transfer(Amount);
    }
        function SetPercentage(uint256 _id,uint256 _percentage) public onlyOwner {
        cardPrice[_id]=_percentage;
    }

    function setMinBet(uint256 _amount) external onlyOwner{
        minimumBet=_amount;
    }
    function setMaxBet(uint256 _amount) external onlyOwner{
        maximumBet=_amount;
    }
}