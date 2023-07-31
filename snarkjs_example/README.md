## compile circuit.circom
- circuit_js
- circuit.r1cs
- circuit.sym
```bash
npm run compile:circuit
```

## view circuit info
- circuitの情報を見る
```bash
npm run info:circuit
```

## view constraint info
- 回路の制約を見る
```bash
npm run print:circuit
```
## zk-SNARK setup, MPC Ceremony
- pot12_0000.ptau
```bash
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
```
- First contribution
- 既存のセットアップフェーズに対して新たなランダム性を追加する
- `--name="First contribution"`ではContributionを識別する
- pot12_0001.ptau
```bash
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
```
- Second contribution
- `verify`: ランダム値の整合性を検証
- pot12_0002.ptau
```bash
snarkjs powersoftau contribute pot12_0001.ptau pot12_0002.ptau --name="Second contribution" -e="gagaetstete" -v
snarkjs powersoftau verify pot12_0002.ptau
```
- Third Contribution
- pot12_0002.ptau
- challenge_000
- response_0003
- pot12_0003.ptau
```bash
snarkjs powersoftau export challenge pot12_0002.ptau challenge_0003
snarkjs powersoftau challenge contribute bn128 challenge_0003 response_0003 -e="tayotuegjasdkgalgsa" -v
snarkjs powersoftau import response pot12_0002.ptau response_0003 pot12_0003.ptau -n="Third contribution" -v
snarkjs powersoftau verify pot12_0003.ptau
```


Final Beacon
- `beacon`: 最終的なランダム性を追加
- `prepare phase2`: 第2フェーズの準備を行う。第2フェーズでは、特定の計算問題（「回路」）に対するセットアップが行われる。circuit の証明鍵と検証鍵を生成するために利用する最終的なptauファイルを生成
- pot12_beacon.ptau
- pot12_final.ptau
```bash
snarkjs powersoftau beacon pot12_0003.ptau pot12_beacon.ptau 432bef0719c9a5203f5e3f91980a84d61e97c3edcf05ebffac1aa24ff954969d  10  -n="Final Beacon" -v
snarkjs powersoftau prepare phase2 pot12_beacon.ptau pot12_final.ptau -v
snarkjs powersoftau verify pot12_final.ptau
```

### MPC Ceremony phase 2
- 証明用の鍵と検証用の鍵を生成
- circuit_0000.zkey
```bash
snarkjs zkey new circuit.r1cs pot12_final.ptau circuit_0000.zkey
```
- First Contribution
- circuit_0001.zkey
```bash
snarkjs zkey contribute circuit_0000.zkey circuit_0001.zkey --name="First contribution"
```
- Second Contribution
- circuit_0002.zkey
```bash
snarkjs zkey contribute circuit_0001.zkey circuit_0002.zkey --name="Second contribution" -e="gagaetstete"
```
- Third Contribution
- circuit_0002.zkey
- challenge_phase2_0003
- response_phase2_0003
- circuit_0003.zkey
```bash
snarkjs zkey export bellman circuit_0002.zkey challenge_phase2_0003
snarkjs zkey bellman contribute bn128 challenge_phase2_0003 response_phase2_0003 -e="gdgdgdfgdfggfg"
snarkjs zkey import bellman circuit_0002.zkey response_phase2_0003 circuit_0003.zkey --name="Third contribution"
```

## check phase 2
```bash
snarkjs zkey verify circuit.r1cs pot12_final.ptau circuit_0003.zkey
```

## random beacon
- circuit_final.zkey
```bash
snarkjs zkey beacon circuit_0003.zkey circuit_final.zkey 2e5d91d305f3b1d59de362baf0e5507af0899b444a33e79a641587ece38c952b 10 -n="Final Beacon phase2"
```
- 検証
```bash
snarkjs zkey verify circuit.r1cs pot12_final.ptau circuit_final.zkey
```

## export verification_key
- verification_key.json
- "protocol": "groth16"
- "curve": "bn128"
```bash
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json
```

## create a witness
- 特定の関係Rが存在していることを証拠とするwitnessを作成
- `witness.wtns`を生成
```bash
snarkjs wtns calculate circuit_js/circuit.wasm input.json witness.wtns
```
- witnessを算出するまでの過程を出力
```bash
snarkjs wtns debug circuit_js/circuit.wasm input.json witness.wtns circuit.sym --trigger -set -get
```

## Groth16 proving syatem
- witnessからproofを生成
```bash
snarkjs groth16 prove circuit_final.zkey witness.wtns proof.json public.json
```







## export the r1cs file to human-readable json
- r1csファイルを人間が読めるjsonにエクスポートする
```bash
cd circuit && snarkjs r1cs export json circuit.r1cs circuit.r1cs.json
```


## PLONK proving system
- `circuit_final.zkey`を生成
- 証明鍵と検証鍵が生成される
```bash
snarkjs plonk setup circuit.r1cs pot12_final.ptau circuit_final.zkey
```
- 証明鍵をエクスポート
- "protocol": "plonk"
```bash
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json
```
- create the proof
```bash
snarkjs plonk prove circuit_final.zkey witness.wtns proof.json public.json
```

