# チュートリアルで作成したプログラムの動かし方メモ

### npm モジュールのインストール

```bash
yarn
```

### Circom ライブラリのインストール

```bash
yarn add circomlib
```

### snark.js のライブラリのインストール

```bash
yarn add snarkjs
```

### circom ファイルのコンパイル

```bash
circom circuit/sample.circom --wasm --r1cs -o ./build
```

実行結果

```Bash
template instances: 71
non-linear constraints: 213
linear constraints: 0
public inputs: 0
public outputs: 1
private inputs: 1
private outputs: 0
wires: 215
labels: 583
Written successfully: ./build/sample.r1cs
Written successfully: ./build/sample_js/sample.wasm
Everything went okay, circom safe
```

### 事前に生成されている Proof key をインストールするコマンド
- web上のファイルをダウンロード
- `ptau`ファイルが信頼性のある第三者によって生成されている

```bash
# wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_12.ptau
curl -O https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_12.ptau
```

### proving key (zkey file)を生成するコマンド

```bash
npx snarkjs groth16 setup build/sample.r1cs powersOfTau28_hez_final_12.ptau zkey/circuit_0000.zkey
```

実行結果

```Bash
[INFO]  snarkJS: Reading r1cs
[INFO]  snarkJS: Reading tauG1
[INFO]  snarkJS: Reading tauG2
[INFO]  snarkJS: Reading alphatauG1
[INFO]  snarkJS: Reading betatauG1
[INFO]  snarkJS: Circuit hash:
                447c71f4 6a1f8964 e230c70f 8afc8875
                f72453a6 3201a3c3 f1d649f5 197b2400
                9d01f706 d0092ad7 98a8a339 79483ee9
                43bd0461 1bd32a72 a999f2e9 ecb4b9e6
```

### proof を生成するコマンド

```bash
yarn generate:proof
```

実行結果

```bash
public: [
  '17853941289740592551682164141790101668489478619664963356488634739728685875777'
]
proof: {
  pi_a: [
    '384034503464459846011625593726477237851260643084033863716146659295495123032',
    '14001542758971686288890455752103207396062426259201032545131651320412039860164',
    '1'
  ],
  pi_b: [
    [
      '7851910105368137708570792322934308886405726584889146499910084145640657634122',
      '7054635673357657230028965035923083780951070237887113596692979156039596183920'
    ],
    [
      '19786845011453783689186395402558741303393234954448837033860398939550073144855',
      '6544690705879350282377100036413219285733359226743537253619768278560403785344'
    ],
    [ '1', '0' ]
  ],
  pi_c: [
    '542563665488574753792782879813944375762935070104033184096919316162022401340',
    '1165756207900614582994056029242951818884764450668994562916666013792494048210',
    '1'
  ],
  protocol: 'groth16',
  curve: 'bn128'
}
```

### verificationkey を生成するためのコマンド

`verificationkey`フォルダ配下に`verification_key.json`ファイルが生成される。

```bash
npx snarkjs zkey export verificationkey zkey/circuit_0000.zkey verificationkey/verification_key.json
```

実行結果

```bash
[INFO]  snarkJS: EXPORT VERIFICATION KEY STARTED
[INFO]  snarkJS: > Detected protocol: groth16
[INFO]  snarkJS: EXPORT VERIFICATION KEY FINISHED
```

### proof を検証するためのコマンド

```bash
yarn verify:proof
```

実行結果

```bash
Verification OK
✨  Done in 0.58s.
```