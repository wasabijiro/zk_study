pragma circom 2.1.3;

include "../node_modules/circomlib/circuits/comparators.circom";

// 2つの数値の乗算を行うシンプルな回路
template SimpleMultiplier() {
    // Private input signals
    // 回路は2つの入力を受け取る
    signal input in[2];

    // Output signal (public)
    // 回路は1つの出力を生成する
    signal output out;

    // 新しいコンポーネント(制約)を作成
    // https://github.com/iden3/circomlib/blob/master/circuits/comparators.circom#L24
    // IsZero制約は、入力が0であれば1を返し、そうでなければ0を返す
    // template IsZero() {
    //   signal input in;
    //   signal output out;

        // 内部で使用する信号を定義
    //   signal inv;

        // ゼロ除算を防ぐ
        // 入力が0でない場合はその逆数をinvに格納し、0の場合はinvを0に設定
    //   inv <-- in!=0 ? 1/in : 0;

        // 出力を計算
        // 入力がゼロでない場合、この式はゼロになる
        // 入力がゼロの場合、この式は1になる
    //   out <== -in*inv +1;

        // 制約を作成
        // 入力と出力の積がゼロであることを要求
        // これにより、出力が入力がゼロであるかどうかを正確に示すことが保証される
    //   in*out === 0;
    // }
    component isz = IsZero();
    // IsZero制約の入力に `in[0] - in[1]` を割り当てる
    isz.in <== in[0] - in[1];

    // IsZero制約は、入力が0であれば1を返し、そうでなければ0を返すので、ここでは `in[0] - in[1]` が 0 ではないことを要求
    isz.out === 0;

    // 2つの新しいコンポーネント(制約)の配列を作成
    // これらの制約はそれぞれ入力が0以上であること、5以下であることをチェックする
    // Define the greater than and less than components that we'll define
    // inside the for loop below.
    component gte[2];
    component lte[2];

    // 2つの信号をループして比較する
    // 各入力に対して上記のチェックを行うループを作成
    for (var i = 0; i < 2; i++) {

        // https://github.com/iden3/circomlib/blob/master/circuits/comparators.circom#L105
        // `in[0] <= in[1]`の場合1を返し、`in[0] > in[1]`の場合0を返す
        // template LessEqThan(n) {
        //   signal input in[2];
        //   signal output out;

        //   component lt = LessThan(n);

        //   lt.in[0] <== in[0];
        //   lt.in[1] <== in[1]+1;
        //   lt.out ==> out;
        // }
        // ビット数を引数としている
        // 今回は入力が[0,5]であることを確認したいので、3ビット（101）が必要
        lte[i] = LessEqThan(3);

        lte[i].in[0] <== in[i];
        lte[i].in[1] <== 5;

        // in[i]が5以下であることをチェックする
        lte[i].out === 1;

        // https://github.com/iden3/circomlib/blob/master/circuits/comparators.circom#L131
        // `in[0] >= in[1]`の場合1を返し、`in[0] < in[1]`の場合0を返す
        // template GreaterEqThan(n) {
        //   signal input in[2];
        //   signal output out;

        //   component lt = LessThan(n);

        //   lt.in[0] <== in[1];
        //   lt.in[1] <== in[0]+1;
        //   lt.out ==> out;
        // }
        // ビット数を引数としている
        gte[i] = GreaterEqThan(3);

        gte[i].in[0] <== in[i];
        gte[i].in[1] <== 0;

        // in[i]が0以上であることをチェックする
        gte[i].out === 1;
    }

    // `in[0] * in[1]` を out に割り当てる
    out <== in[0] * in[1];
}

component main = SimpleMultiplier();