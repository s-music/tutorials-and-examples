# Section-1. Javaプログラミングの基礎

## 1.1 Java言語とは

コンピュータ上の多種多様なアプリケーションはプログラミング言語と呼ばれる特殊な文章を記述し、  
コンピュータに対して様々な命令を与えることで作成することができます。  
プログラミン言語には様々な種類がありますが、*Java*もその一種です。  

Javaの特徴として、  
・機種依存が非常に少ない(あるコンピュータ(OS)上で機作ったプログラムが、違うコンピュータでも動く)  
・静的型付け  
・オブジェクト指向  
・マルチスレッドを扱うことができる  
などがあげられ、世界的にも広く用いられている言語です。  
(今はわからなくても大丈夫です。)  

### 開発に必要なもの

Javaでプログラミングを行うに当たって必要なもの・あると便利なものは概ね以下の通りです。  

・Java開発環境(JDK)  
Java言語で開発を行うために必要なソフトウェア(コンンパイラや標準クラスライブラリ)が梱包されたソフトウェアです。  

ダウンロード  
<http://www.oracle.com/technetwork/java/javase/downloads/index.html>

・統合開発環境(IDE)  
プログラミングで開発を行う際に、あると便利な機能・ソフトウェアが集約されたソフトウェアです。  
必須ではありませんが、IDEを使って開発を行う方が何かと便利です。  
今後*Eclipse*というIDEで開発を行っていきます。  

ダウンロード  
<http://www.eclipse.org/downloads/>

## 1.2 Java言語での開発の流れ

Java言語での開発の流れは以下のようになります。  

### 1. プログラムを記述する
.javaという拡張子のファイルにプログラムを記述していきます。  

### 2. コンパイルする(書いたプログラムを実行可能な状態にする)
書いたソースコードを機械語(コンピュータが理解できる命令)に変換する作業。

### 3. 実際に実行する
前述のIDEから実行GUIで実行することもできますが、コンソールからjavac, javaなどのコマンドで実行することもできます。  

### 4. デバッグする(バグやエラーの原因を調査・修正する)
開発を進めていくと、予期しない動作やエラーが発生することがあります。この原因を探り、修正する行為を*デバッグ*と呼びます。  

### 5. 1.に戻る

## 1.3 Hello, World!!の表示

Javaプログラミングのこと初めとして、「Hello, World!!」という文字を表示するプログラムを書いてみましょう。  
まずは、IDEを使わずに適当なテキストエディタを使ってみます。  
Main.javaを作成し、以下のプログラムを記述してみましょう。  

```java
public class Main {
    public static void main (String[] args) {
        System.out.println("Hello, World!!");
    }
}
```

記述できたらコンソールを開き、以下を実行します。  

```
$ javac Main.java  // Main.javaのコンパイル(同一階層にMain.classが作成される)
$ java Main // Main.classの実行
Hello, World!!
```

### プログラムを読んでみる

改めて先ほど記述したプログラムを読んでみましょう。  

```java
// Main.java
public class Main { // ← クラス宣言(名前の部分は通常大文字始まりで記述する)

    public static void main (String[] args) { // ← メソッドの定義(名前の部分は小文字始まりで記述する)

        System.out.println("Hello, World!!"); // 具体的な処理。;(セミコロン)で１つの動作の区切りを示す。

    }

}
```

このプログラムは3つの枠組みになっています。  
まず、第1行目~第5行目までが１つ目の枠組み。  
続いて、第2行目~第4行目までが2つ目の枠組み。  
最後に、第3行目が3つ目の枠組みになっています。  

まず１つ目の枠組みは、classという枠組みです。記述方法は、  

修飾子 class宣言 class名  

となります。(今は修飾詞は無視してもらって結構です)  
ソースコードが大きくなっていくと、機能ごとにプログラムを分けて書くようになります。  
このclassはその機能のごとの塊の１つになります。  

また、Javaでは１つのファイル内に対してClass定義さているClassは１つであり、  
Class名とファイル名は一致していなければなりません。  

次に2つ目の枠組みは、メソッドという枠組みです。記述方法は、  

修飾子 型 メソッド名 (引数の型 引数名) {}

となります。(型も無視してもらって結構です)  
これはclassの機能そのもので、この枠組みの中に実際に行いたい処理を記述します。  
Java言語ではmainというメソッドを記述すると、そのメソッドをスタート地点としてプログラムが実行されます。  

*引数*という見慣れない単語があると思いますが、これは処理を行う際に渡したい値を表しています。  
関数に引数を渡すことで、引数に応じた処理を行うことができるのです。  

最後に3つ目の枠組みはメソッドの具体的な処理です。  
この行は、JDKで前もって定義されているメソッドを呼び出しているものであり、  
括弧内(引数)に記述された文字列を画面に表示します。  
このように定義下メソッドの中から別のメソッドを呼び出すことができます。  

### 補足) 命名規則

プログラミングを行っていると、何かに名前をつける場面が多々存在します。  
名前の付け方には主に、  
・キャメルケース(valiableName(Lower), ClassName(Upper))  
・スネークケース(method_name(Lower), CONSTANT_VALUE(Upper))  
があります。  

この先のコーディングでは、  
Class名 → キャメルケース(Upper)  
メソッド名 → キャメルケース(Lower)  
引数名、変数名(後述)、フィールド名(後述) → キャメルケース(Lower)  
定数名(後述) → スネークケース(Upper)  
で記述していきます。

プログラミングにおける命名規則はコーディング規約(Javaでコードを書く際の取り決め)などに記載されています。  
例としてGoogleのJavaのコーディング規約(Javaでコードを書く際の取り決め)のNamingの項目にGoogleの命名規則が記載されています。  
<https://google.github.io/styleguide/javaguide.html>


### 補足) 予約語

プログラミング言語では、言語ごとに予約語と呼ばれるあらかじめ意味をつけられている言葉があります。  
すでに出てきた。pablicやclassなどは予約語です。  

予約語はそれ単体だと変数名やメソッド名などにつかえないため、注意が必要です。  
参考書の付録Fに予約語一覧が載っているので参考にしてください。  

### 補足) オブジェクト指向

Javaはオブジェクト指向型のプログラミング言語と呼ばれています。  
オブジェクト指向とは現実世界のモノ(例: 動物、乗り物など)をプログラムで表現するという考え方で
モノが持つ性質(振る舞い)をメソッドなどを用いてプログラミングを行うという考え方です。  
このモノの設計図や構成を表す部分が、JavaにおけるClassです。  
そのためClassが持つメソッドにはモノが持つ性質(振る舞い)を表す適切な命名、挙動をさせることが望ましいです。  
プログラミングの基本を学ぶ上ではあまり意識しないことではありますが、  
Java言語のプログラムがこのような考え方に基づいて記述されることを頭の片隅に置いておいてください。  

### 1.4 二重引用符の表示

次のような文を表示するにはどのようにすれば良いでしょう。  
"ぼくは"java"を勉強しています。"  
これまでの知識でプログラムを書くと、  

```java
// Main.java
public class Main { // ← クラス宣言(名前の部分は通常大文字始まりで記述する)

    public static void main (String[] args) { // ← メソッドの定義(名前の部分は小文字始まりで記述する)

        System.out.println("ぼくは"java"を勉強しています。"); // 具体的な処理。;(セミコロン)で１つの動作の区切りを示す。

    }

}
```

のようになると思います。  

このプログラムを実際にコンパイルしてみましょう。  

```
$ javac Main.java
Main.java:5: エラー: ')'がありません
        System.out.println("ぼくは"java"を勉強しています。"); // 具体的な処理。;(セミコロン)で１つの動作の区切りを示す。
                                ^
Main.java:5: エラー: 文ではありません
        System.out.println("ぼくは"java"を勉強しています。"); // 具体的な処理。;(セミコロン)で１つの動作の区切りを示す。
                                    ^
Main.java:5: エラー: ';'がありません
        System.out.println("ぼくは"java"を勉強しています。"); // 具体的な処理。;(セミコロン)で１つの動作の区切りを示す。
                                               ^
エラー3個
```

*エラー*が出てしまいました。  
Javaではコンパイル時に文法的に正しくない部分があると、それを前もって教えてくれます。(このとき実行ファイルはできません。)  

一体なにが問題だったのでしょう?  
Javaプログラムは機械語に翻訳されて実行されているというのはすでに説明した通りですが、  
翻訳を行う際にjavaの前の'"(ダブルクォーテーション)'が文の終わりだと判断されてしまうため、  
その後に')(閉じ括弧)'が無いと怒られてしまっているのです。  

こういった特殊な文字を表示するためには、  
*エスケープシーケンス*と呼ばれる代替えの記述をすることで表示が可能となります。  
エスケープシーケンスの記述方法は'"'などの文字の前に'\ (バックスラッシュ )' or '¥ (エンマーク))'をつけます。  
これを使って先ほどのプログラムを書き換えると、  

```java
// Main.java
public class Main { // ← クラス宣言(名前の部分は通常大文字始まりで記述する)

    public static void main (String[] args) { // ← メソッドの定義(名前の部分は小文字始まりで記述する)

        System.out.println("ぼくは\"java\"を勉強しています。"); // 具体的な処理。;(セミコロン)で１つの動作の区切りを示す。

    }

}
```

コンパイルして実行すると、

```
$ javac Main.java
$ java Main
ぼくは"java"を勉強しています。
```

'"'が正しく表示されています。  

## エスケープシーケンス

|  表記 |  説明 |  |  |  |  |
|  ------ | ------ | ------ | ------ | ------ | ------ |
|  \b | バックスペース |  |  |  |  |
|  \t | 水平タブ |  |  |  |  |
|  \n | 改行 |  |  |  |  |
|  \f | 改ページ |  |  |  |  |
|  \r | 復帰(キャリッジリターン) |  |  |  |  |
|  \" | ダブルクォーテーション |  |  |  |  |
|  \' | シングルクォーテーション |  |  |  |  |
|  \\ | バックスラッシュ |  |  |  |  |
|  \uXXXX | XXXXの16進数4文字のUnicodeに対応する文字。 |  |  |  |  |
|  \uuXXXX | \uXXXXに同じ。ASCIIコードしか使えないツールに用いる。 |  |  |  |  |
|  \octal | octal部分に8進数1~3桁を書くと、その文字コードに対応する文字になる。 |  |  |  |  |

### 補足) コメント

javaでは"//"を記述した一から行の文末までを*コメント*というプログラムの説明部分として解釈します。  
このコメントの部分には何を記述してもjavaの文法を適用した評価されません。(機械語に翻訳されない。)  
また、複数行に渡ってコメントを記述したい場合には、コメントしたい行を/*~*/で囲みます。

```java
/**
 * この中に複数行の
 * コメントを記述していく
 */
```

## 1.5 プログラムで加減乗除を行ってみる

前節までで、文字列を表示するプログラムを書くことができるようになりました。  
今回はもう少し進んで、四則演算を行うプログラムを書いてみましょう。  

以降はIDE(eclipse)を立ち上げてプログラムを作成していきましょう。  
まず、*パッケージ*と呼ばれるクラスのまとめるフォルダを作成します。  

srcフォルダを右クリック → New → Package → Nameにsapmleと入力してOKボタンをクリック  

パッケージが作成できたら、クラスを作成します。  

sampleパッケージを右クリック → New → Class → NameにMainと入力してOKボタンをクリック  

Mainファイルが作成できたと思います。以下のプログラムを記述してみましょう。  

```java
// Main.java
public class Main {

    public static void main (String[] args) {
        System.out.println(3 + 2); // 5
        System.out.println(5 - 8); // -3
        System.out.println(3 * 4); // 12
        System.out.println(7 / 3); // 2
    }

}
```

算数で四則演算を表現するのに(+, -, ×, ÷)を使いますが、  
Javaでは(+, -, *(アスタリスク), /(スラッシュ))を用います。  

文字列を表示した時のように、System.out.println();の引数に計算式を記述しています。  
記号が若干異なるだけで、ほとんど算数と同じですね。  

ここで、除算の時の計算結果が2になっていますが、算数の除算であれば2.3333...となるのが普通ではないかと思われる方もいると思います。  
*型*というものに関係しているのですが、  
今は小数点以下が切り捨てられてしまうという認識で大丈夫です。  

計算結果だけだと表示した数値が何を表しているかわからないため、説明する文字列も含めて表示してみたいと思います。  
+演算子はjavaでは文字列の連結にも使えます。  

```java
public class Main {

    public static void main (String[] args) {
        System.out.println("加算の結果は" + (3 + 2) + "です。"); // 加算の結果は5です。
        System.out.println("減算の結果は" + (5 - 8) + "です。"); // 減算の結果は-3です。
        System.out.println("乗算の結果は" + (3 * 4) + "です。"); // 乗算の結果は12です。
        System.out.println("除算の結果は" + (7 / 3) + "です。"); // 除算の結果は2です。
    }

}
```

- 優先順位

さらに複雑な式を計算してみましょう。

```java
public class Main {

    public static void main (String[] args) {
        System.out.println("計算の結果は" + (1 + 2 * 3 - 4 / 2) + "です。"); // ???
    }

}
```

答えは幾つになるでしょうか?  

javaにおける四則演算子(+, -, *, /)の優先順位は算数と同じで、  
*や/が+,-に優先して評価されます。  

javaには他にも演算子がたくさんありますが、それぞれに優先順位があるため、  
使用する際には注意が必要です。  

()を用いることで+, -の計算を優先させることもできます。

```java
public class Main {

    public static void main (String[] args) {
        System.out.println("計算の結果は" + ((1 + 2) * (3 - 4) / 2) + "です。"); // 計算結果は-1です。
    }

}
```

## 1.6 オーバーフロー

基本的に算数とJavaとで計算に違いはありませんが、  
Javaはコンピュータ上で動作しているため、扱える数の範囲には限界があります。  
Javaでの整数値は符号付き(*int型*と呼ばれる値)は32bitで表現されています。(例: 1 → 00000000000000000000000000000001)  
つまり表現できる数は2^32通りだけです。(-2,147,483,648 ～ 2,147,483,647)  
もし計算結果がこの範囲を超えてしまうと、*オーバーフロー*が起こります。  

以下はオーバーフローが起こるプログラムの例です。

```java
public class Main { // ← クラス宣言(名前の部分は通常大文字始まりで記述する)

    public static void main (String[] args) { // ← メソッドの定義(名前の部分は小文字始まりで記述する)
        System.out.println(2147483647 + 1); // int型の最大値に対して1を足す。
    }

}
```

問題なく実行できると思いますが、計算結果は-2147483648となっています。  
1を足したことによってint型の最小値になってしまいました。  

このように扱える値の範囲を意識しなければ、計算結果が予期せぬものになってしまいます。  
プログラマはこのことを念頭に置いてプログラミングを行わなければなりません。  

## 練習問題

[Section-1. Javaプログラミングの基礎の練習問題](./section-1-exercise.md)