# RainbowWars Solidity Contract

## Description
RainbowWars is a cross-chain game. Here is the [description][describe] and [demo][demo].

This is the solidity contract for RainbowWars.
The RainbowWars project consists of three parts:
- [ethereum solidity contract][ethcontract]
- [near assembly contract][nearcontract]
- [vue frontend][frontend]

## Requirements
- NodeJS v8.9.4 or later
- Truffle
- ganache-cli or other ethereum client

## Project setup
1. install truffle: `npm install -g truffle`
2. install ganache-cli: `npm install -g ganache-cli`
3. install dependencies: `npm install` or `yarn`

## Modify the contract code
Modify the `contracts/nearprover/RainbowWars.sol`, changing the `bridgeHash` to your NEAR contractID:
```
...
bytes32 constant bridgeHash = keccak256("NearContractID.testnet");
...
```

## Compilation
```
truffle compile
```

## Deployment
### Ganache-cli:
1. start Ganache-cli
```
ganache-cli --account <private_key>,<initial_balance>
```
example: `ganache-cli --account 0x00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff,1000000000000000000000`
2. deploy contract to ganache-cli
```
truffle deploy --network=develop
```
It will display your contract address, record the contract address.

For example, in the following information, `0x90774f99783f1238e1193cD7030FB3d686D0786E` is the contract address.
```
1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x8e22a42660c393f1b894cc4150b75cf1d14788cfcd6aa1966e155de89797ca27
   > Blocks: 0            Seconds: 0
   > contract address:    0xC70Ea3E08e62C8416fb537c2fB61d0bb832bDAd1
   > block number:        1
   > block timestamp:     1601362513
   > account:             0x87C018EF78005f118C53fa9cadf0a4Fd367a77A9
   > balance:             999.9974206
   > gas used:            128970 (0x1f7ca)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0025794 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:           0.0025794 ETH


2_deploy_demo.js
================

   Deploying 'RainbowWars'
   -----------------------
   > transaction hash:    0x33c7a82cd8a6dc7161de9600a8f2cabf926e55fe27c679f4046ca4a0b3e56c85
   > Blocks: 0            Seconds: 0
   > contract address:    0x90774f99783f1238e1193cD7030FB3d686D0786E
   > block number:        3
   > block timestamp:     1601362513
   > account:             0x87C018EF78005f118C53fa9cadf0a4Fd367a77A9
   > balance:             999.93897254
   > gas used:            2880137 (0x2bf289)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.05760274 ETH


   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.05760274 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.06018214 ETH
```

[demo]: https://peekpi.github.io/RainbowWars/dist
[ethcontract]: https://github.com/peekpi/RainbowWars-Solidity
[nearcontract]: https://github.com/peekpi/RainbowWars-Assembly
[frontend]: https://github.com/peekpi/RainbowWars-Vue
[describe]: https://github.com/peekpi/RainbowWars