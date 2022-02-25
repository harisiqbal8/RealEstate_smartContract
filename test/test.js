const { expect } = require("chai");
const { ethers } = require("hardhat");
const { parseEther } = require("ethers/lib/utils");

function fromWei(n){
  return parseEther(n);
}

describe("Real Estate", function () {
  let owner, a1, a2, a3, a4, a5, a6, property;
  it("Deployment of Smart Contract: ", async function () {
    [owner, a1, a2, a3, a4, a5, a6] = await ethers.getSigners();
    const Property = await ethers.getContractFactory("RealEstate");
    property = await Property.deploy(2,3);  // constructor values
    await property.deployed();
    console.log('Real Estate contract address ', property.address);
  });
  it("Get Admin Value: ", async()=>{
    const [propertyNo ,commsion , fee, agency] = await property.getAdmin();
    expect(propertyNo).to.eq(1);
    expect(commsion).to.eq(2);
    expect(fee).to.eq(3);
    console.log(agency);
  });
  it("Set Values of Property: ", async()=>{
    const payment = {value: fromWei("12.0")};
    await property.AddProperty("Pics", "Haris", "Tax", "Clearance", "21/02/2022", payment);
  });
  it("Get Admin Value: ", async()=>{
    const [propertyNo] = await property.getAdmin();
    expect(propertyNo).to.eq(2);
  });
  it("Get Property Data: ", async()=>{
    const [pics, pprs, taxes, mortgage, date, pamount, owner, sale, agencyApproval] = await property.getData(1);
    console.log(pics, pprs, taxes, mortgage, date, pamount, owner, sale, agencyApproval);
  });
  it("Agency Approval", async()=>{
    await property.OnlyAgency(true, 1);
  })
  it("Change Selling Status", async()=>{
    await property.Sale("New Pics", 13, true, 1);
  })
  it("Get Property Data: ", async()=>{
    const [pics, pprs, taxes, mortgage, date, pamount, owner, sale, agencyApproval] = await property.getData(1);
    console.log(pics, pprs, taxes, mortgage, date, pamount, owner, sale, agencyApproval);
  });
  it("Change Property Data: " ,async()=>{
    const payment = {value: fromWei("15.0")};
    await property.Purchase("Ata", "23/02/2022", 1, payment);
  });
  it("Get Property Data: ", async()=>{
    const [pics, pprs, taxes, mortgage, date, pamount, owner, sale, agencyApproval] = await property.getData(1);
    console.log(pics, pprs, taxes, mortgage, date, pamount, owner, sale, agencyApproval);
  });
});
