var Lottery = artifacts.require("./Lottery.sol");

contract('Lottery', function(accounts) {
  it("Print balances", function() {
    console.log("Printing balances:");
    for (i=0;i<accounts.length;i++)
    {
       console.log("Account "+i+": " + web3.fromWei(web3.eth.getBalance(accounts[i]).toNumber())+ "ether");
    }
  });

  it("Contribute with 1 eth from 10 addresses", function() {
    var contract;
    return Lottery.deployed().then(function(instance){
        contract = instance;
    }).then(function(){
        for (i=0;i<accounts.length;i++)
        {
            var tx = {
                from: accounts[i], 
                to: contract.address, 
                value: web3.toWei(1, "ether")
            };
            contract.sendTransaction(tx);
            
        }        
    });
  });

    it("Print balances again", function() {
        console.log("Printing balances:");
        for (i=0;i<accounts.length;i++)
        {
           console.log("Account "+i+": " + web3.fromWei(web3.eth.getBalance(accounts[i]).toNumber())+ "ether");
        }
    });

});
