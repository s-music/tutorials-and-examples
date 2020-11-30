# Section-2. 抽象クラス・インタフェース

## 2.1 抽象クラス

Javaには実装を持たないメソッド(*抽象メソッド*)を持つことができる、*抽象クラス*というクラスがあります。  
抽象クラスは普通のクラスと違い、インスタンスを生成することはできません。  
※コンストラクタは定義できます。  

まずは、抽象クラスの定義を見てみましょう。  
Figure.javaを作成し、以下を記述してみてください。  

```java
// Figure.java
abstract class Figure {

  public abstract String getFigureName();

}
```

さらにこのクラスをSection1で作成したRectangleクラスに継承させてみましょう。  

`The type Rectangle must implement the inherited abstract method Figure.getFigureName() // Rectangleクラスは継承された抽象メソッドであるFigure.getFigureName()を実装しなければなりません。`

というようなエラーメッセージが出力されたと思います。  

継承を行った場合、実装(具体的な処理内容)のあるメソッドはオーバーライドしてもしなくても構いませんが、  
抽象メソッドは実装が決まっていないため、必ずオーバーライドしなくてはなりません。  

Rectangle.javaに以下を追記してみてください。  

```java
// Rectangle.java
// Rectangleクラス内

  /**
   *  図形名の取得
   */

  @Override public String getFigureName() {
    return "長方形";
  }
```

抽象メソッドの実装ができたので、Main.javaを以下のように書き換え、実行してみましょう。  

```java
// Main.java

public class Main {

  public static void main (String[] args) {
    Rectangle rectangle = new Rectangle(10, 20);
    System.out.println(rectangle.getFigureName()); // 長方形
  }

}
```

"長方形"が表示されたと思います。  

もう１つ、Figureクラスを継承するRoundクラスを作成し、同じようにgetFigureName()をオーバーライドして実装を与えてみましょう。  
Round.javaを作成し、以下を記述してください。  

```java
// Round.java

public class Round extends {

  @Override public String getFigureName() {
    return "円";
  }

}
```

さらに、Main.javaを以下のように書き換えます。

```java
// Main.java

public class Main {

  public static void main (String[] args) {
    Rectangle rectangle = new Rectangle(10, 20);
    Round round = new Round();
    System.out.println(rectangle.getFigureName()); // 長方形
    System.out.println(round.getFigureName()); // 円
  }

}
```

RectangleのインスタントとRoundのインスタンスでそれぞれの別の結果が返ってきます。  

このように、大本となる概念を抽象的クラスで表し、それぞれ異なる振る舞いを抽象メソッドとして定義しておくと、  
子クラスには必ずそのメソッドの実装を記述している箇所があることを保証できます。  

## 2.2 インタフェース

*インタフェース*とはあるクラス間で持つ共通のメンバを定義しておくものです。  
クラスにインタフェースを適用することを、*実装する(implement)*と言います。  

今までクラス間で共通のメンバを持たせる場合には継承を使ってきました。  
継承もインタフェースも同じようにクラス間で同一のメンバを持たせるようにできますが、  
継承の場合は親クラスを１つしか持てないのに対し、インタフェースは複数実装できます。  

継承が多分木構造をなしているのに対して、インタフェースは異なる木同士に共通の性質を持たせるものとなります。  

また、インタフェースの継承は*多重継承*が可能で、複数のインタフェースの性質を持つインタフェースを定義することができます。  

実際にインタフェースを定義してみましょう。  
Debuggable.javaを作成し、以下を記述してください。  

```java
// Debuggable.java
public interface Debuggable {

  /** フィールド **/
  // Debuggableの関数を有効化するかどうかのフラグ
  public static final boolean disabled = false; // public finalは自動で付与されるが、記載しておく

  /** 抽象メソッド **/
  /**
   *  disabledがtrueの時にクラス名を出力する関数
   */
  public abstract void printClass(); // public abstractは自動で付与されるが、記載しておく

}
```

インタフェースのフィールドは必ず定数(public finalが付与されたフィールド)になり、  
メソッドはデフォルトで抽象メソッドになります。(Java 8から実装を持つメソッドも宣言的に定義可能)  

このインタフェースを実装するクラスを定義します。  
Dummy.javaを作成し、以下を記述してください。  

```java
// Dummy.java
public class Dummy implements Debuggable {

  @Override public void printClass() {
    if(!Debuggable.disabled) { // Debuggable.disabledがtrue出ない場合に{}を実行
      System.out.println("Dummy");
    }
    return;
  }

}
```

インタフェースを実装するにはクラス名の後にimplements <インタフェース名1>, <インタフェース名2>, ...とします。  

抽象クラスを継承した時と同じように、インタフェースで定義されている抽象メソッドは必ずオーバーライドしなければなりません。  
また、disabledはstaticなフィールド(クラスフィールド、インタフェースフィールドとは言わない)のため、Debuggable.disabledでアクセスできます。  

このクラスのインスタンスを作成し、printClassメソッドを使ってみます。  
Main.javaを作成し、以下のプログラムを記述してください。  

```java
// Main.java

public class Main {

  public static void main(String[] args) {
    Debuggable dummy1 = new Dummy();
    dummy1.printClass();
  }

}
```

インタフェースは抽象クラスと同じようにインスタンスを作ることはできませんが、  
変数の型として指定することができ、  
そのインタフェースを実装しているクラスのインスタンスを格納することができます。  
※配列の型としてインタフェースを指定した場合、そのインタフェースを実装しているクラスのインスタンスであれば、  
要素として格納することができます。  

## 練習問題

[Section-2. インタフェースの練習問題](./section-2-exercise.md)
