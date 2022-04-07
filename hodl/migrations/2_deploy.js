const hodl = artifacts.require("hodl.sol");

module.exports = function (deployer) {
  deployer.deploy(hodl);
};