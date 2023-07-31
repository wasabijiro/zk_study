## compile circuit.circom
```bash
npm run compile:circuit
```

## view constraint info
```bash
npm run print:circuit
```

## view circuit info
```bash
npm run info:circuit
```

## zk-SNARK setup, MPC Ceremony
```bash
npm run setup
```

First contribution
- 既存のセットアップフェーズに対して新たなランダム性を追加する
- `--name="First contribution"`ではContributionを識別する
```bash
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
```

Second contribution
- `verify`: ランダム値の整合性を検証
```bash
snarkjs powersoftau contribute pot12_0001.ptau pot12_0002.ptau --name="Second contribution" -v -e="some random text"
snarkjs powersoftau verify pot12_0002.ptau
```

Final Beacon
- `beacon`: 最終的なランダム性を追加
- `prepare phase2`: 第2フェーズの準備を行う。第2フェーズでは、特定の計算問題（「回路」）に対するセットアップが行われる。
```bash
snarkjs powersoftau beacon pot12_0002.ptau pot12_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"
snarkjs powersoftau prepare phase2 pot12_beacon.ptau pot12_final.ptau -v
```