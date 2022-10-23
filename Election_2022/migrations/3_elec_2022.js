const Election2022 = artifacts.require("Election2022");

module.exports = function (deployer) {
  deployer.deploy(Election2022,"0x3ba579cEBb9F8C1342E6773593a58A0e7921bB13");
};