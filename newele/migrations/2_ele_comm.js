const ElectionCommision = artifacts.require("ElectionCommision");

module.exports = async function (deployer){
   await deployer.deploy(ElectionCommision);
};