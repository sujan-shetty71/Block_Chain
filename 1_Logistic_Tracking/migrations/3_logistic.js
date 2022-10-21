const logistic = artifacts.require("logistic");

module.exports = function (deployer) {
  deployer.deploy(logistic,"0xb0F60f305e2C13EC7a5DBB14f15eB67443fd3a39");
};
