# Section-1. クラス

## 1.1 クラス・インスタンス・コンストラクタの復習

まずは復習から入りましょう。  
クラスとはプログラムで表現したいモノの設計図に当たるものでした。  
そしてそのクラスに定義されたコンストラクタという特殊なメソッドをnew演算子を使って呼び出すことで、  
具体的なモノ(インスタンス)を生成するという流れでした。  

人間というクラスがあったとすると、「佐藤さん」や「鈴木さん」が具体的なモノ(インスタンス)に相当します。  

クラスにはその性質を表す情報(フィールド)や振る舞い(メソッド)が定義され、クラス名もしくは変数名+'.(ピリオド)'に続けて名前を記述することで参照・呼び出しができるのでした。  

フィールドとメソッドを合わせて、クラスの*メンバ*と呼びます。

## 1.2 クラスに関するもう一歩進んだ話

まずRectangle.javaを作成し、以下のようなclassを記述してください。  
少し長いコードになりますが、頑張って記述して見てください。  

```java
/** Rectangle.java **/

public class Rectangle {

  /** フィールド **/
  // 定数
  // 外部に公開しない変更不可能なクラスフィールド
  private static final int INITIAL_WIDTH = 1;
  private static final int INITIAL_HEIGHT = 1;
  // インスタンスフィールド
  protected int width = 0;
  protected int height = 0;
  // クラスフィールド
  private static int counter = 0;

  /** コンストラクタ **/

  public Rectangle(int width, int height) {
    this.width = width;
    this.height = height;
    counter++; // counterを1増やす
  }

  public Rectangle() {
    this.width = INITIAL_WIDTH;
    this.height = INITIAL_HEIGHT;
    counter++; // counterを1増やす
  }

  /** クラスメソッド **/

  /**
   *  インスタンスの数の取得
   */
  public static int getCounter() {
    return counter; // クラスフィールドは特定のインスタンスのものではないため、thisはつけない
  }

  /** インスタンスメソッド **/

  /**
   *  横幅の取得
   */
  public int getWidth() {
      return this.width; 
  }

  /**
   *  高さの取得
   */
  public int getHeight() {
      return this.height;
  }


}

```

### ・クラスフィールド、インスタンスフィールド

メソッドの定義の際にstatic修飾子をつけたメソッドはクラスメソッドとなり、  
何も修飾子をつけていないメソッドはインスタンスメソッドとなることは以前お話しした通りですが、  
これはフィールドに対しても同様です。  
static修飾子をつけたフィールドを*クラスフィールド*、つけていないフィールドを*インスタンスフィールド*と呼びます。  
クラスフィールドはクラス全体で共有する情報で、各インスタンスから呼び出せますが、  
インスタンスフィールドは各インスタンスの固有情報となるため、各インスタンスからでしか呼び出すことができません。  

### ・定数

変数を定義する際にfinal修飾子をつけると、変数に格納されている値を変更できなくなります。  
つまり、その変数は*定数*となります。  

定数はそのプログラムを組む上で決まっている値やなんども出てくる同じ値に用います。  
定数として定義しておくことで、どういった値のなのかを読む人に伝えられますし、  
値を変更したい場合に、すべての使用箇所を一気に変更できます。  
上記の例では、長方形のデフォルトの幅と高さを定数として定義してあります。  

また、private修飾子をつけることで、他のクラスからその変数やメソッドに対してアクセスすることができなくなります。  
外部に後悔したくない変数やメソッドはもちろんのこと、公開する必要のないものに対しても極力つけるように心がけましょう。  


### ・コンストラクタのオーバーロード

メソッドは引数を変更することで、複数定義することもできます。(final修飾子をつけていない場合)  
これを*オーバーロード*と呼びます。  

コンストラクタをオーバーロードすることで、インスタンスを生成する際の引数の数によって、  
インスタンスの作成方法を選ぶことができます。  
ただし、同じ型の引数を同じ数とるメソッドを定義することはできません。  

<br>

ここで作成したRectangleクラスを使用するコードを記述してみましょう。  
Rectangle.javaと同じパッケージ内にMain.javaを作成して、以下のコードを記述してください。  

```java
/** Main.java **/

public class Main {

  public static void main (String[] args) {
    Rectangle rectangle1 = new Rectangle(10, 20);
    Rectangle rectangle2 = new Rectangle();
    System.out.println("インスタンスの数: " + Rectangle.getCounter());
    System.out.println("rectangle1 横幅: " + rectangle1.width + ", 高さ: " + rectangle1.height);
    System.out.println("rectangle2 横幅: " + rectangle2.width + ", 高さ: " + rectangle2.height);
  }

}

```

実際に実行してみると、  

```
インスタンスの数: 2
rectangle1 横幅: 10, 高さ: 20
rectangle2 横幅: 1, 高さ: 1
```

となったと思います。  

## 1.3 クラスの継承

オブジェクト指向の重要な概念に*継承*という概念があります。  
継承とはあるクラスの性質を別のクラスが受け継ぐ機能のことです。  
ここで、継承元のクラスを*スーパクラス(親クラス)*と呼び、継承するクラスを*サブクラス(子クラス)*と呼びます。  

クラスを継承すると、コンストラクタ、privateで指定した変数・メソッド以外の全てのメンバを内部的に持っていることになります。  

継承を行うには*extends*という宣言を追加します。  
Rectangle.java, Main.javaと同じ階層にSquare.javaを作成し、以下のコードを記述してください。  

```java
public class Square extends Rectangle {

      /**
       *  フィールド
       */
      private static final int INITIAL_WIDTH = 1;

      /**
       *  コンストラクタ
       */
      public Square(int width) {
        super(width, width);
      }

      public Square() {
        super(INITIAL_WIDTH, INITIAL_WIDTH);
      }

}
```

ここで新しく出てきた*super*という単語はJavaの予約語であり、  
super.メンバ名とするとクラスのメンバにアクセスすることができます。  

また、super()とすると、親クラスのコンストラクタの呼び出しとなります。  

Squareのコンストラクタは奇妙に思えるかもしれません。  
コンストラクタの内部で親のコンストラクタを呼び出しています。  

実は、この呼び出しはJavaの継承では必ず行われていることなのです。  
(コンストラクタ内で明示的に親クラスのコンストラクタを呼び出さない場合は、  
暗黙的に引数なしのコンストラクタsuper();が呼び出されます。)  

子クラスのコンストラクタが呼び出された場合に、まず親クラスのコンストラクタが呼び出され、  
その後に子クラスのコンストラクタが呼び出されます。  
最終的なインスタンスのフィールドはこれらのコンストラクタで設定された値を持ちます。  

Squareを使ってみましょう。Main.jsを以下のように書き換えてください。  

```java
/** Main.java **/
public class Main {

  public static void main (String[] args) {
    Rectangle rectangle1 = new Rectangle(10, 20);
    Rectangle rectangle2 = new Rectangle();
    System.out.println("インスタンスの数: " + Rectangle.getCounter());
    System.out.println("rectangle1 横幅: " + rectangle1.width + ", 高さ: " + rectangle1.height);
    System.out.println("rectangle2 横幅: " + rectangle2.width + ", 高さ: " + rectangle2.height);
    Square square1 = new Square(10);
    Square square2 = new Square();
    System.out.println("インスタンスの数: " + Rectangle.getCounter());
    System.out.println("square1 横幅: " + square1.width + ", 高さ: " + square1.height);
    System.out.println("square2 横幅: " + square2.width + ", 高さ: " + square2.height);
  }

}
```

実行結果は  

```
インスタンスの数: 2
rectangle1 横幅: 10, 高さ: 20
rectangle2 横幅: 1, 高さ: 1
インスタンスの数: 4
square1 横幅: 10, 高さ: 10
square2 横幅: 1, 高さ: 1
```

となったと思います。  

### 補足) 多重継承

Javaの継承は複数の親を持つ*多重継承*を禁止しています。  

`class Hoge extends Fuga, Pyoro`

や  

`class Hoge extends Fuga extends Pyoro`

などとはできません。  

この後の章で紹介するインタフェースと呼ばれるものを使うと、擬似的に多重継承を表現できます。  

### 補足) デフォルトコンストラクタ

クラスを宣言した際にコンストラクタを定義しなかった場合、  
デフォルトコンストラクタと呼ばれるコンストラクタが内部で自動で定義されます。  

例えば、下記のようなRectangleクラスがあった場合、  

```java
public class Rectangle {

}
```

コンストラクタが定義されていないため、  

```java
Rectangle() {
  super();
}
```

のようなコンストラクタが自動で定義されます。  

### 補足) オーバーライド

継承した親クラスのメンバの内容を子クラス側で上書きすることもできます。  
よく使うオーバーライドメソッドとしてtoStringメソッドがあります。  
このメソッドはJavaの全てのクラスが自動的に継承しているObjectというクラスに定義されているメソッドで、  
このメソッドで返す文字列が、インスタンスを文字列化した時の文字列となります。  

メソッドをオーバーライドするには*@Override*をつけて再度同じメソッドを子クラス側で定義します。  

@Overrideは*アノテーション*と呼ばれるもので、コードに利用できる注釈のことです。  
注釈というとコメントを思い浮かべることと思いますが、  
コメントと違う部分はコンピュータ側にも意味をもつ注釈であるということです。  

この@Overrideアノテーションをつけることで、継承元にそのメソッドがなければエラーを出してくれます。  
何もつけていない状態でも、IDEで作業している分には自動でエラーを出してくれていますが、  
独立したテキストエディタなどで作業して、コマンドラインからプログラムを実行する場合はオーバーライドミスを検知しません。  

@Overrideをつけなくてもエラーにはなりませんが、  
別の人がみてオーバライドしたメソッドであることを一目でわかるという目的と、Overrideミスを防ぐという意味で、  
オーバーライドしたメソッドには@Overrideをつけるようにしましょう。    

```java
// Rectangle.java
@Override public String toString() {
  return "Rectangle";
}
```

この状態でRectangleインスタンスをSystem.out.printlnメソッドの引数として渡すと、"Rectangle"が表示されます。  

```java
// Main.java
Rectangle rectangle = new Rectangle();
System.out.println(rectangle); // Rectangle
```

少し前にオーバーロードについて説明しましたが、オーバーライドとは別物ですので混同しないように気をつけましょう。  

### 補足) アクセス制御修飾子

*アクセス修飾子*はそれをつけているクラス・メソッド・変数のスコープ(アクセスできる範囲)を指定する修飾子です。  
アクセス修飾子は継承などにも影響を与えます。  

|  アクセス修飾子 | 同一クラス内 | 同一パッケージ | サブクラス |
|  ------ | ------ | ------ | ------ |
|  指定なし | ○ | ○ | × |
|  public | ○ | ○ | ○ |
|  protected | ○ | ○ | ○ |
|  private | ○ | × | × |


ここで、用語のおさらいをしておきましょう。  

- クラス: プログラムで表現したいモノの設計図
- インスタンス: 設計図(クラス)から生成された具体的なモノ
- コンストラクタ: クラスからインスタンスを生成する際に呼ばれるメソッド
- フィールド: モノの情報
- メソッド: モノの振る舞い
- メンバ: フィールドとメソッドの総称
- 継承: あるクラスの性質(メンバ)を引き継ぐこと

覚える用語が多くて大変だと思いますが、１つずつ整理して身につけていってください。  

## 練習問題

[Section-1. クラスの練習問題](./section-1-exercise.md)