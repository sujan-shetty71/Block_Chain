const Seller = artifacts.require("seller");
const Buyer = artifacts.require("buyer");
const Forwarder = artifacts.require("logistic");
const portclearence = artifacts.require("portclearence");
//const { BN, constants,expectEvent, expectRevert } = require('@openzeppelin/test-helpers');

contract("Testing buyer contract ", (accounts) => {
    

  const addr = "0x0000000000000000000000000000000000000000";

  it("buyer is deployed and instance can be created", async () => {
    const buyerInstance = await Buyer.deployed();

    assert.notEqual(buyerInstance, null, "buyer instance could not be created");
  });

  it("buyer choose seller", async () => {
    const buyerInstance = await Buyer.deployed();
     const owner = await buyerInstance.setSeller.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
    assert.notEqual(owner,addr, "seller not be null address");
  });


  it("buyer choose Freighter", async () => {
    const buyerInstance = await Buyer.deployed();
     const owner = await buyerInstance.setlogistic.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
    assert.notEqual(owner,addr , "Enter valid  address");
  });




});

contract("Testing seller contract ", (accounts) => {

  const addr = "0x0000000000000000000000000000000000000000";


    it("Seller is deployed and instance can be created", async () => {
      const sellerInstance = await Seller.deployed();
      assert.notEqual(sellerInstance, null, "seller instance could not be created");
    });

    it("seller choose Freighter", async () => {
      const sellerInstance = await Seller.deployed();
  
       const owner = await sellerInstance.set_logistic.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
  
      assert.notEqual(owner,addr , "Enter valid  address");
    });
  
    
  });

contract("Testing Forwarder contract ", (accounts) => {

  const addr = "0x0000000000000000000000000000000000000000";

     it("Forwarder is deployed and instance can be created", async () => {
    const ForwarderInstance = await Forwarder.deployed();

    assert.notEqual(ForwarderInstance, null, "Enter valid address");

    });

    it("ff choosing port clearence", async () => {
      const ForwarderInstance = await Forwarder.deployed();
      const owner = await ForwarderInstance.set_clearence.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
      assert.notEqual(ForwarderInstance, addr, "Enter valid addres");
  
      });

      it("FF choosing seller", async () => {
        const ForwarderInstance = await Forwarder.deployed();
        const owner = await ForwarderInstance.set_seller.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
        assert.notEqual(ForwarderInstance, addr, "Enter valid addres");
    
        });

        it("FF choosing buyer", async () => {
            const ForwarderInstance = await Forwarder.deployed();
            const owner = await ForwarderInstance.set_buyer.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
            assert.notEqual(ForwarderInstance, addr, "Enter valid addres");
        
            }); 
  });

  contract("port clearence contract ", (accounts) => {

    const addr = "0x0000000000000000000000000000000000000000";
  
       it("port clearence is deployed and instance can be created", async () => {
      const clearenceInstance = await portclearence.deployed();
  
      assert.notEqual(clearenceInstance, null, "Enter valid address");
  
      });

      it("port clearence choosing ff", async () => {
        const clearenceInstance = await portclearence.deployed();
        const owner = await portclearence.set_logistic.call("0x96F18282E0a8D37458fa676c4F77077A264e7204");
    
        assert.notEqual(clearenceInstance, owner, "Enter valid address");
    
        });
    });