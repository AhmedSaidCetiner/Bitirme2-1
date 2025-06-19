const drawapps = artifacts.require("drawapps");

contract("drawapps", function (accounts) {

  it("Limit Degisikligi", async function () {
    let instance = await drawapps.deployed();
    let result = await instance.setLimit(10, {from: accounts[0]});
    return assert.isTrue(true);
  });

  it("Limit Gor", async function () {
    let instance = await drawapps.deployed();
    let result = await instance.getLimit({from: accounts[0]});
    assert.equal(result.toString(), 10, "Limit 10 olmalı");
  });

  it("Toplam Miktar", async function () {
    let instance = await drawapps.deployed();
    let result = await instance.getTotalAmount({from:accounts[0]});
    assert.equal(result.toString(), 0, "Miktar 0 olmalı");
  });

  it("Toplam Katılımcı", async function () {
    let instance = await drawapps.deployed();
    let result = await instance.getTotalInvest({from:accounts[0]});
    assert.equal(result.toString(), 0, "Katılımcı 10 olmalı");
  });

  it("Yatırma Limiti Degisti", async function (){
    let instance = await drawapps.deployed();
    let result = await instance.setDepositLimit(web3.utils.toBN(2), {from: accounts[0]});
  });

  it("Cekilise Katilma Limiti", async function() {
    let instance = await drawapps.deployed();
    let result = await instance.getDepositLimit({from: accounts[0]});
  });

  it("Cekilise Katil", async function () {
    let instance = await drawapps.deployed();
    for (let i=0; i < 5; i++) {
      await instance.deposit({from: accounts[i], value: 2*10**18});
      web3.eth.getBalance(instance.address).then(console.log);
    }
  })


});
