# Section-5. 関数・配列の練習問題

## 練習問題

### 問1.

長方形(Rectangle)、三角形(Tryangle)、円(Circle)の面積を求めるプログラムを作成してください。  
コンソールから求めたい図形、図形毎のパラメータ(整数)をそれぞれ入力し、最後に結果を出力します。  
コマンドラインから入力された値が不正な場合は以下のメッセージを表示してプログラムを終了してください。  

```
入力値が不正です。
```

(円周率は3.14とします。)

- 実行結果

```
面積を求めたい図形を選択してください。(長方形: 0、三角形: 1、円: 2)
0
横の長さ: 3
縦の長さ: 4
長方形の面積: 12
```

```
面積を求めたい図形を選択してください。(長方形: 0、三角形: 1、円: 2)
1
底辺の長さ: 3
高さ: 4
三角形の面積: 6
```

```
面積を求めたい図形を選択してください。(長方形: 0、三角形: 1、円: 2)
2
半径: 3
円の面積: 28.26
```

```
面積を求めたい図形を選択してください。(長方形: 0、三角形: 1、円: 2)
a
入力値が不正です。再度値を入力してください: 2
半径: 3
円の面積: 28.26
```

```
面積を求めたい図形を選択してください。(長方形: 0、三角形: 1、円: 2)
2
半径: a
入力値が不正です。再度値を入力してください: 3
円の面積: 28.26
```

### 問2.

以下の配列があった時、  

```java
int[][] array =
    {
        { 0, 3, 4, 5, 2, 6 },
        { 4, 8, 8, 5 },
        { 9, 4, 6, 1, 2 },
        { 1, 2, 2, 3, 4, 5, 6 }
    };
```

各配列の要素の合計を出力するプログラムを記述してください。  

- 実行結果

```
20
25
22
23
```

### 問3.

コンソールから入力された整数までの階乗を求めるプログラムを作成してください。  
コマンドラインから入力された値が不正な場合は以下のメッセージを表示してプログラムを終了してください。  

```
入力値が不正です。
```

- 実行結果

```
値を入力してください: 5
5の階乗: 120
```


### 問4.

n=30のフィボナッチ数列を表示するプログラムを作成してください。  

- 実行結果

```
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765
```
