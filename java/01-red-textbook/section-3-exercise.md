# Section-3. 分岐命令の練習問題

## 練習問題

### 問1.

コンソールから入力された整数が偶数であるか奇数であるかを判定するプログラムを作成してください。  
入力された文字列が整数に変換できない場合はエラーメッセージを表示してください。  

```
不正な入力です。
```

- 出力結果

```
数値を入力してください。:1
入力された数値は奇数です。
```

### 問2.

ユーザーからの入力を三回受け取り、計算結果を返すプログラムを作成してください。  
まず、「値を入力してください。」というメッセージを表示し、続けて出力結果のように値の入力を促していきます。(値はint型の値とします。)  
入力された文字列が整数に変換できない場合はエラーメッセージを表示してください。  

- 出力結果

```
値を入力してください。
演算子の左辺: 10
演算子(+, -, *, /): -
演算子の右辺: 6
結果: 4
```

```
値を入力してください。
演算子の左辺: 3
演算子(+, -, *, /): *
演算子の右辺: 4
結果: 12
```

```
値を入力してください。
演算子の左辺: b
演算子(+, -, *, /): *
演算子の右辺: 4
結果: 値が不正です。
```

```
値を入力してください。
演算子の左辺: 5
演算子(+, -, *, /): a
演算子の右辺: 4
結果: 演算子が不正です。
```

```
値を入力してください。
演算子の左辺: b
演算子(+, -, *, /): a
演算子の右辺: 4
結果: 値が不正です。
```

```
値を入力してください。
演算子の左辺: 3
演算子(+, -, *, /): a
演算子の右辺: b
結果: 値が不正です。
```

### 問3.

問1のプログラムに対して、このプログラムが仕様を満たしていることを保証するための*テスト仕様書*を作成してください。  