# Hardhat
(tutorial)[https://hardhat.org/tutorial/deploying-to-a-live-network.html]
(github)[https://github.com/wighawag/tutorial-hardhat-deploy]
## Create
```bash
mkdir hardhat-tutorial
cd hardhat-tutorial
yarn init --yes
yarn add -D hardhat
yarn hardhat    # Select Create an empty hardhat.config.js
yarn add -D @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai dotenv
```

## hardhat.config.js
```js
require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.4",
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/${process.env.GOERLI_API_KEY}`,
      accounts: [`0x${process.env.GOERLI_PRIVATE_KEY}`]
    }
  }
};
```

## contracts/Token.sol
```js
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Token {
    string public name = "My Hardhat Token";
    string public symbol = "MBT";

    uint256 public totalSupply = 1000000;

    address public owner;

    mapping(address => uint256) balances;

    constructor() {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function transfer(address to, uint256 amount) external {
        console.log("Sender balance is %s tokens", balances[msg.sender]);
        console.log("Trying to send %s tokens to %s", amount, to);
        require(balances[msg.sender] >= amount, "Not enough tokens");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint256) {
        console.log("balanceOf %s is %s token", account, balances[account]);
        return balances[account];
    }
}
```

## test/Token.js
```js
const { expect } = require("chai");

describe("Token contract", function () {
    it("Deployment should assign the total supply of tokens to the owner", async function () {

        const [owner] = await ethers.getSigners();
        const Token = await ethers.getContractFactory("Token");
        const hardhatToken = await Token.deploy();

        const ownerBalance = await hardhatToken.balanceOf(owner.address);
        expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    });
});
```

## scripts/deploy.js
```js
async function main() {

    const [deployer] = await ethers.getSigners();

    console.log(
        "Deploying contracts with the account:",
        deployer.address
    );

    console.log("Account balance:", (await deployer.getBalance()).toString());

    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy();

    console.log("Token address:", token.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
```

## .env
```bash
GOERLI_PRIVATE_KEY = fffff   # private key
GOERLI_API_KEY = projectKEY  # https://infura.io/dashboard
```

## package.json
```json
"scripts": {
    "test": "hardhat test",
    "deploy": "hardhat run scripts/deploy.js --network goerli"
  }
```

## Run
```bash
yarn test
yarn test ./test/Token.js
yarn deploy
```