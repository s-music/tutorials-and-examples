# Section-2. 変数と型

## 2.1 変数とは

中学生の数学ではx, yなどの変数が出てくると思います。  
便宜的な文字を当てることで、変化する可能性がある値を表現していました。  

Javaでの変数も変化する値ではありますが、*値を入れておく入れ物*がもっと近いイメージです。  

変数は、作る宣言をする(変数宣言)ことでコンピュータ上に領域を確保し、  
値を入れたり、中身(値)を参照できたり、値を入れ直すことができます。  

具体的な変数の取り扱いは以下の通りです。

```java
int a = 1; // 型名 変数名 = 初期値で宣言できる。
System.out.println(a) // 実行結果: 1
a = 2; // 値を入れ直す。
System.out.println(a) // 実行結果: 2
```

変数はプログラム上で、一時的に値を保持しておきたい場合などに用います。

## 2.2 型とは

プログラミングで重要な概念の１つに、*型*と呼ばれる概念があります。  
型とは、そのデータがどういった種類のデータであるかを表すものです。  

Javaの型は、  
基本型(primitive type)と参照型(reference type)に分類されます。  
基本型とは*論理値(真、偽)や、整数を保持する型*であり、  
参照型とは*値を格納している場所を保持する型*です。  

基本型には  
int(整数値(32bit))、long(整数値(64bit))char(文字)、float(浮動小数点数(32bit))、double(浮動小数点数(64bit))、boolean(真偽値)  
などが属し、  

参照型には  
Class、string(文字列)、配列(後述)  
などがあります。  

今まで記述してきた例だと、  
- 1, 2, 3, ... → int型(整数)、基本型
- "Hello, World!!" → string型(文字列)、参照型
- class Main → 参照型
のような分類になります。  

## 2.3 変数を使ってみる

変数、型を理解したところで、実際にこれらを使ったプログラムを書いてみましょう。  
Main.javaに以下のプログラムを記述します。  

```java
// Main.java
public class Main {

    public static void main (String[] args) {
        // 変数の宣言時に型を指定
        int x = 2;
        int y; // 何も入っていないが、領域だけは確保
        // 変数への値の代入
        x = 4;
        y = x;
        System.out.println(x + y); // 変数同士を加算
    }

}
```

int x = 2;  
int y;  
という部分が変数の宣言部です。  
ここで、xには最初から2という値が入っている状態になり、  
yには値は入っていないが領域だけは確保されているという状態です。  

<u>このとき宣言した型以外の値は変数に代入できません。</u>  

次に変数への値の代入部分  
x = 4;  
y = x;  
ここは少し奇妙に思える方もいらっしゃるかもしれません。  
算数や数学では'='は値が等しいことを表す記号でした。  
Javaでは両辺が等しいことには変わりありませんが、変数に値を代入するという意味の方が強いです。  

最後に、xとyを加算していますが、結果はどうなっているでしょう?  
実際に実行してみると、8になると思います。  

メソッド内のプログラムは上から下に実行されるため、記述した順に値が代入され、はじめに入っていた値は破棄されます。  
xとyの値の変遷は次のようになっています。  
x: 2 → 4  
y: 何もない状態 → 4  

ここで、もしy = xの部分がなかったとすると、どうなるでしょう？  
y = xの部分をコメントアウトしてください。  

エラーが表示された筈です。  
何もない状態と四則演算はできないので、必ず値が入っている必要があります。  
したがって、変数宣言の際には、特に理由がない限り、初期値を設定しておくことが望ましいです。  

それでは、もう少し複雑な処理をみていきましょう。  

```java
// Main.java
public class Main {

    public static void main (String[] args) {
        int x = 2;
        x = x + 1; // xに1を加算した値をxに代入
        System.out.println(x);
    }

}
```

今度はxに1を加算し、それをxに代入しています。  
結果は3になるはずです。  

このように、ある変数に対してその変数自体の値を再代入することもできます。  
(また、このx = x + 1;は、x++;として書き換えることもできます。)  

１つ練習問題を解いてみましょう。  
次のように、  
int x = 1;  
int y = 2;  
という２つの変数があったとして、  
この２つの変数の値を入れ替えるプログラムを考えてみてください。  

### 補足) 暗黙の型変換

変数には、宣言時に指定した型以外の値は代入できないとしましたが、厳密には違います。  
例えば、double型で宣言した変数に対して1を代入したとしてもしたとしてもエラーにはなりません。  

Javaが自動で、代入した1を1.0に変換しています。  
このように言語側がある型を別の型に対して自動で変換して解釈することを*暗黙の型変換*と言います。  

これに関連する事項として、  
Section1で除算を行った際に、7 / 3が2.333...ではなく、2となったことを思い出してください。  
これは、両辺の値がint型だったため、結果もint型の値として計算され、2となっていたのです。  

実は、この式の片方もしくは両辺を少数に直すと、結果が2.333...になります。  
Javaで四則演算を行う際には、両辺の型から結果の型が自動で変換されます。  

計算結果が予期せぬ値になることもあるため、こうした言語仕様は把握しておく必要があります。  

## 2.4 標準入出力

ここからはさらに一歩進んで、ユーザーとの対話を行うプログラムを考えてみたいとおもいます。  
プログラムを記述するときはまず処理の流れを整理します。今回作成するプログラムは、  

プログラムを実行 → ユーザーからの入力された文字列を取得 → ユーザーの入力を受けた結果の表示  

というような流れになります。  

流れが確認できたところで、段階的にプログラムを組み立てていきましょう。  
ユーザーからの入力のやり方はまだ学んでいないため、まずは結果の表示を行う部分を記述してみます。  
結果はユーザーの入力によって変化する値のため、変数を用いるのが良さそうです。  

```java
// Main.java
public class Main {

    public static main(String []) {
        String who = "名前"; // TODO: ユーザーからの入力値を代入する
        println(who + "さん。こんにちは!");
    }

}
```

あとでプログラムを変更する可能性がある箇所には、

```java
// TODO: 変更すべき内容
```

をつけておきます。

次に、ユーザーからの入力を受け取ってみたいと思います。  
readLineメソッドというものを使うことで、ユーザーからの入力を受け取ることができるのですが、  
これはSystem.out.println();のように標準で用いることができないため、定義しているクラスを明治的に読み込む必要があります。  
*import*を用いることで、外部に定義されているClassのメソッドを使用できるようになります。  

以下のようにプログラムを書き換えてみましょう。  

```java
// Main.java
import java.io.*;

public class Main {

    public static void main (String[] args) {
        String who = "結果";
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        who = reader.readLine();
        println(who + "さん。こんにちは!");
    }

}
```

エラーにが出ると思いますが、今は気にせずに、  
追加した部分についてみましょう。  
まず、  
import java.io.*;  
の部分ですが、いままでプログラムを作成する際には、上部にpackage <パッケージ名>という文が自動で記述されていたと思います。  
このpackageというのはclassの集合体で、これをimportするとそのpackage下のclassを使用することができるようになります。  
今回使いたいreadLineメソッドを持つBufferedReaderクラスはjava ioパッケージに内にあるため、java.ioをインポートしています。  
ioのあとの'*'はjava.ioの全てのクラスをimportするという意味になります。  
(eclipceでBufferedReaderをcommand+clickしてみましょう。実際に定義されている場所を確認できます。)  

次に、  
BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));  
の部分です。  
これは、readLineメソッドを用いるための前準備です。  

メソッドにはClass名を指定して使えるもの(*クラスメソッド*、static修飾子が付いてる)と、  
クラスから生成した*インスタンス*を指定して使えるもの(*インスタンスメソッド*、static修飾子が付いていない)にわけられます。  

Section1ではクラスはモノの設計図を表しているといいましたが、インスタンスはモノそのものとなります。  
例をあげると、人というクラスがあった場合に、佐藤さんや鈴木さんなどの各個人がインスタンスとなります。  

メソッドはモノの振る舞いを表していますが、*クラスメソッドはそのクラス全体に共通する振る舞い*を表し、  
*インスタンスメソッドはインスタンス個別の振る舞いを表します。*  
※詳しくは後のSectionで説明します。  

クラスからインスタンスを作るにはnew演算子を使い、インスタンスを作るときに必要なものを引数として渡します。  
今回の場合はBufferedReaderインスタンスを作るためにInputStreamReaderインスタンスが必要であり、  
InputStreamReaderインスタンスを作るためにSystem.inが必要なので、こんな書き方になっています。  

これでreadLineメソッドを使う準備が整ったので、  
who = reader.readLine();  
でユーザからの入力を受け取り、whoにその結果を代入しています。  

ここまででプログラムは問題なく動きそうですが、なぜエラーが出ているのでしょうか?  
Consoleのエラーメッセージをみてみましょう。  

```
Exception in thread "main" java.lang.Error: Unresolved compilation problem: 
Unhandled exception type IOException

at sample.Main.main(Main.java:10)
```

Unhandled exception type IOException(IOExceptionという型の例外がハンドリングされていません。)  
となっています。  


IOExceptionとは、何らかの理由により読み込み先や書き込み先にJavaプログラムがアクセスできなかった時に起こるエラーです。  
キーボードからの入力、コンソールへの出力では滅多に起きることはありませんが、  
readLineメソッドはテキストファイル内の文章を読み込みなどにも使ったりします。  
ファイルを読み込む際にはそのファイルのパスをしていするのですが、該当のファイルが存在しなかった時などにはエラーとなってしまいます。  
こうしたエラーを未然に防ぐ手段として、Javaでは*例外(Exception)*の検査と呼ばれる機能を提供しています。  
これは、あらかじめメソッドが投げる可能性のある例外を定義しておくことで、コンパイル時にこの例外が投げられた処理が記述されていない場合は、  
コンパイルエラーを出す機能です。

readLineメソッドの定義元を参照してみると、throws IOExceptionという記述があると思います。  
この記述によって、IOExceptionを投げる可能性があることを明示しているのです。  

こうした例外を処理するための構文として、  
Javaには*try-catch構文*が用意されています。  

以下のようにプログラムを書き換えてみましょう。  

```java
import java.io.*;

public class Main {

    public static void main (String[] args) {
        String who = "結果";
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
          who = reader.readLine();
        } catch(IOException e) {
          System.out.println("Error");
          return;
        }
        System.out.println(who + "さん。こんにちは");
    }

}
```

try {}内に例外が発生する処理を記述し、catch(IOException e) {}に例外が発生した場合を記述します。  
IOException eは発生しうる例外の型+変数名を記述します。  
エラー処理は後ほど詳しく解説するので、今はこういう書き方をするということだけ覚えてもらえれば結構です。  

catch節の最後にreturn;という式が記述されています。  
これはメソッドの処理を終了し、値を返す場合に記述する式です。  

mainメソッドはvoid(値を返さないメソッドの印)が返り値として指定されているので、単純に処理が終了するだけです。  
詳しくは後の章で説明します。  

## 2.5 値の変換

プログラミングをしていると、ある型の値を別の型に変換したい場合もあります。  
具体的にはコンソールで受け取った数値の文字列を、数値に変換したい場合などです。  

コンソールから受け取った数値を1増やして表示するプログラムを記述してみましょう。

```java
// Main.java
import java.io.*;

public class Main {

    public static void main (String[] args) {
        int num = 0;
        String str = "";
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
          str = reader.readLine();
          num = Integer.parseInt(str);
        } catch(IOException e) {
          System.out.println("Error");
          return;
        }
        System.out.println(num + 1);
    }

}
```

実行結果は以下のようになると思います。  

```
1
2
```

readLineメソッドで受け取った文字列をstrに格納し、  
次の行のInteger.parseIntメソッドで受け取った文字列をint型として変換しています。  

Javaでは基本型(primitive type)にはそれぞれ対応する*ラッパークラス*というクラスが存在し、  
それぞれの基本型(primitive type)に対して便利な機能を提供しています。  

このラッパークラスのパースメソッドを用いることで、値を別の型の値に変換できます。  

ここで、数値ではなく文字を入力した場合はどうなるでしょう?

```
a
Exception in thread "main" java.lang.NumberFormatException: For input string: "a"
    at java.lang.NumberFormatException.forInputString(NumberFormatException.java:65)
    at java.lang.Integer.parseInt(Integer.java:580)
    at java.lang.Integer.parseInt(Integer.java:615)
    at other.Sample.main(Sample.java:17)
```

以下のようなエラーが吐かれました。NumberFormatExceptionとでているので、例外が吐かれたようですが、  
readLineメソッドの時のようにコンパイルエラーとはなりませんでした。  

実は、例外にはコンパイル時にチェックを行う例外と、チェックを行わない例外が存在するのです。  
詳しくは後の章で説明しますが、Javaは実行時に場合によっては起こりうる可能性がある例外は、検査を行わずにコンパイルします。  
全ての例外を処理するとキリがない場合が多々あるためこうした仕様となっているのですが、  
検査を行わない例外もcatch節で受け取ることができるため、プログラムを修正してみましょう。  

```java
// Main.java

import java.io.*;

public class Main {

    public static void main (String[] args) {
        int num = 0;
        String str = "";
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
          str = reader.readLine();
          num = Integer.parseInt(str);
        } catch(IOException e) {
          System.out.println("Error");
          return; 
        } catch(NumberFormatException e) {
          System.out.println("不正な値が入力されました。");
          return;
        }
        System.out.println(num + 1);
    }

}
```

## 練習問題

[Section-2. 変数と型の練習問題](./section-2-exercise.md)  