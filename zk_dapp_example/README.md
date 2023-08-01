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