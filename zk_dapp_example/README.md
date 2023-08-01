## ZK Example Dapp
2つの入力を受け取り、以下をzkpで保証する
- それらが両方とも0から5の間であること
- それらが両方とも互いに等しくないこと
2つの値を掛け算して出力する

## Getting Started
```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

## Ref
Github
https://github.com/ytham/zk_example_dapp
Medium
https://medium.com/@yujiangtham/writing-a-zero-knowledge-dapp-fd7f936e2d43

## Setup file
powersOfTau28_hez_final_08.ptau を使用
https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_08.ptau
```bash
template instances: 6
non-linear constraints: 14
linear constraints: 0
public inputs: 0
public outputs: 1
private inputs: 2
private outputs: 0
wires: 13
labels: 51
```

## Deploy Contract
Truffleを使用
```bash
Deploying 'PlonkVerifier'
   -------------------------
   > transaction hash:    0x79fcef0bfbaced4b55c4c5cd14333a64e2036defe0e4c687975a55c3798f7edd
   > Blocks: 0            Seconds: 8
   > contract address:    0x502066A3d06eF9c874e0f3C06A2784941e67bA35
   > block number:        9444183
   > block timestamp:     1690886316
   > account:             0x0F08e3cB454ad1fE1fF7387e950139E4bd36d926
   > balance:             0.189890004979951678
   > gas used:            1546740 (0x1799f4)
   > gas price:           2.522658284 gwei
   > value sent:          0 ETH
   > total cost:          0.00390189647419416 ETH
```
https://goerli.etherscan.io/address/0x502066a3d06ef9c874e0f3c06a2784941e67ba35
```bash
Deploying 'SimpleMultiplier'
   ----------------------------
   > transaction hash:    0x53007abac5534ce0e54b2a2f6ddbae6ac3cf7f63349f120f89d9c97777ff618f
   > Blocks: 0            Seconds: 4
   > contract address:    0xdc86d58643A41608b2A0e6BAb09D6bD48cd810fB
   > block number:        9444184
   > block timestamp:     1690886328
   > account:             0x0F08e3cB454ad1fE1fF7387e950139E4bd36d926
   > balance:             0.188715547524583486
   > gas used:            465588 (0x71ab4)
   > gas price:           2.522525184 gwei
   > value sent:          0 ETH
   > total cost:          0.001174457455368192 ETH
```
https://goerli.etherscan.io/address/0xdc86d58643a41608b2a0e6bab09d6bd48cd810fb