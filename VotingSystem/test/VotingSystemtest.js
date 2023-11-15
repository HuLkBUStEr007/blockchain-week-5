const {expect} = require ("chai");

describe ('Votingsystem' , function(){
let owner,voter1,voter2,votingsystem;


beforeEach(async function () {
[owner] = await ethers.getsigners ()
const Votingsystem =await ethers.getcontractfactory("Votingsystem") ;
votingsystem = await deploy.votingsystem(["candidate1","candidate2"]);
await votingsystem.deployed ();
});

it ("should sign the write contract",async function(){
  const candidate1Name = await votingsystem.candidates(0);
  const candidate2Name = await votingsystem.candidates(1);

  expect(candidate1Name).to.equal(candidate1);
  expect(candidate2Name).to.equal(candidate2);
})

it("should add candidate",async function (){
    await votingsystem.connect (owner). addcandidate(["candidate 3"]);
    const votingsystem = await votingsystem.getCandidatescount();
    expect (Candidatecount).to.equal(3);          
});

it("should remove candidate",async function (){
              await votingsystem.connect (owner).removecandidate(1);
              const votingsystem = votingsystem.getCandidatescount();
              expect (Candidatecount).to.equal(1);
});

it("should prevent double voting", async function () {
  await votingsystem.connect(voter1).vote(0);
  await expect(votingsystem.connect(voter1).vote(0)).to.be.revertedWith("Already voted");
});

it ("should allow onlyowner can perform add task ", async function (){
const  nonOwner = voter2;
await expect(votingsystem.connect(nonOwner).addCandidate("Candidate D")).to.be.revertedWith("Only Owner  Perform ");

});

it ("should allow onlyowner perform remove task ", async function (){
              const  nonOwner = voter2;
              await expect(votingsystem.connect(nonOwner).removeCandidate(1)).to.be.revertedWith("Only Owner  Perform");
});
});