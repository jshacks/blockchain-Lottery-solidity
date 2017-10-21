pragma solidity ^0.4.14;

contract Lottery {

    address public owner;
    uint public participantsCounter;
    uint private constant participantsRequired = 10; //max 250
    uint private constant ticketPrice = 1 ether;
    
    mapping(uint => address) private participants;

    event NewParticipant(address indexed participant, uint256 value);
    event NewWinner(address indexed winner, uint256 amount);

   /**
   * @dev The constructor sets the original `owner` of the contract to the sender
   * account.
   */
    function Lottery() {
        owner = msg.sender;
        participantsCounter = 0;
     }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Throws if not paid at least the minimum ticket price
    */
    modifier hasPaidTicket() {  
        require(msg.value >= ticketPrice);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
    function transferOwnership(address newOwner) onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

    

    function () payable hasPaidTicket {
        participants[participantsCounter++]  = msg.sender;
        NewParticipant(msg.sender,msg.value);
        if ( participantsRequired == participantsCounter)
        {
            uint rand = (uint) (block.blockhash(block.number-1)[0]);
            address winner = participants[rand % participantsRequired];
            participantsCounter = 0;
            uint prize = this.balance;
            winner.transfer(this.balance);
            NewWinner(winner,prize);
        }
    }

}



