const seller = artifacts.require("seller");

module.exports = function (deployer) {
  deployer.deploy(seller,"0x96F18282E0a8D37458fa676c4F77077A264e7204");
};
