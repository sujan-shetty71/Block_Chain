const MultiSigWallet = artifacts.require("MultiSigWallet");

module.exports = function (deployer) {
  const owners = ["0x3ba579cEBb9F8C1342E6773593a58A0e7921bB13", "0x2aFCE35856aA345043Cba201c895d0ff744F8DeD", "0xa459b70f82a9858F381165665620Bf37012C2A41"];
  const approvalcount = 1;
  deployer.deploy(MultiSigWallet,owners,approvalcount);
};
