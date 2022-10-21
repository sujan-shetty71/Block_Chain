const buyer = artifacts.require("buyer");

module.exports = function (deployer) {
  deployer.deploy(buyer);
};
