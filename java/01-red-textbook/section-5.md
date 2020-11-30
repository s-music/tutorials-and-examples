# Section-5. 関数・配列

## 5.1 メソッドの定義

これまでも、System.out.printlnメソッドやreadLineメソッドなどを利用してきました。  
こうしたメソッドは自分でも定義することができます。  
行う処理ごとにメソッドを切り分けることで、見通しの良いプログラムを記述することができます。  

早速mainメソッド以外のメソッドを定義してみましょう。
Main.javaに以下のプログラムを記述してみてください。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        int ms = 1000; // ミリ秒
        System.out.println(toSecond(ms) + "s");
    }

    /**
     *  ミリ秒の値を受け取って秒数に変換した値を返す
     *  @param ms
     */
    public static int toSecond(int ms) {
        int s = ms / 1000;
        return s;
    }

}
```

toSecondというメソッドを定義しました。

まず、*public修飾子*ですが、  
これは外部にそのメソッドを公開することを表しています。  
System.out.println()やreadLineメソッドの定義元でも同様の記述がありますが、  
このpublic修飾子をつけることによって他のClass内からでも同一パッケージであればアクセス可能になり、異なるパッケージ間でも、importすることによってアクセス可能になります。  
逆に公開する必要の無いものに関しては*private修飾子*をつけます。この修飾子をつけたものは外部から完全に遮断され、同一クラスからでしかアクセスできなくなります。  

次に、*static修飾子*です。  
すでに紹介した通り、static修飾子をつけたメソッドはクラスメソッドになります。  
これによって、Mainクラスからインスタンスを生成することなく使用できるようになります。  

続いてintの部分ですが、これが型を表していることは想像がつくと思います。  
何の型を示しているかというと、メソッドの*返り値*というものの型を示しています。
メソッドは基本的には何らかの値を受け取って、何らかの値を返すものです。(値を受け取らないこともできますし、値を返さないこともできます。)  
受け取る値を*引数*、返す値を*戻り値*と言います。  
メソッド名の前にある型が引数の型を表し、()内にある型が引数の型です。(voidは値を返さないメソッドにつける型です。)  

()内に型と一緒に記述されているmsは変数で、受け取った値が格納されており、  
この関数内で使うことができます。  

処理の最後にreturn s;という部分がありますが、  
returnの後に記述した値が結果として返却されます。  
このとき、返却する値の型が戻り値の型と一致しない場合は文法エラーとなります。  

#### ・処理を分けるの必要性

作成したプログラムは以下のように記述したとしても同じ動作となります。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        int ms = 1000; // ミリ秒
        int s = ms / 1000 // 秒
        System.out.println(s);
    }

}
```

この方が記述量も少なくて良いのでは無いでしょうか?  

今回の例では一度しか変換を行なっていないため、関数に分ける必要性は感じないかもしれませんが、  
この変換を行いたい値が複数ある場合、いちいち1000で割る処理を書いていくのは面倒です。  
関数に切り出しておくことで、繰り返して使う処理は一度の記述ですみます。  
また、処理自体に名前をつけることができるため、コードの可読性も向上します。  

## 5.2 配列とは

Javaでは複数の変数をまとめておくために*Array(配列)*と呼ばれるclassが提供されています。  
配列を使ったプログラムを書いてみましょう。  
Main.javaに以下のプログラムを記述してみてください。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        String[] members = { "Tom", "Alis", "Bob", "Clis" };
        System.out.println("一人目は" + members[0] + "です。");
    }

}
```

配列を使用するときは、インスタンスを作成する必要があります。  
普通のクラスと同じようにnew演算子を使うこともできるのですが、配列は特殊な構文が用意されています。  

```
配列にしたい型名[] 変数名 = { 型の値, 型の値, ... }; // 最後の要素に',(カンマ)'を記述してもエラーにはならないが、記述するべきではない。
```

ここで注意したいポイントとしては、型に合わない要素を配列に格納することはできません。  
例えば、上記のプログラムで、  

```java
String[] members = { "Tom", 2, "Bob", "Clis" };
```

とすることはできません。Javaの配列はあくまで同じ型の集合です。  

配列の要素にアクセスする場合には変数名の後に"[]"を続けて、その中にアクセスしたい要素の番号を指定します。  
ここで注意しなければならないのが、要素の番号は0から振られていくという点です。  
上記のプログラムでは配列の最初の要素にアクセスするために、0を指定しています。  
逆に最後の要素にアクセスしたいときに、要素が4つだからといって4を指定するとエラーになります。(ArrayIndexOutOfBoundsException) 

## 5.3 n次元配列

配列も１つの変数なので、配列を配列に格納することも可能です。入れ子になっている配列をn次元配列と呼びます。  
Main.javaを以下のように書き換えてみてください。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        String[][] members = new String[3][];
        String[] group1 = { "Tom", "Alis", "Bob" };
        String[] group2 = { "Jacob", "Sophia", "Ethan", "William" };
        String[] group3 = { "Google", "Excel" };
        members[0] = group1;
        members[1] = group2;
        members[2] = group3;
        for (int i = 0; i < 3; i++) {
            System.out.println("グループ" + (i + 1));
            for (int j = 0; j < 2; j++ ) {
                System.out.println((j + 1) + "人目" + members[i][j]);
            }
        }
    }

}
```

n次元配列の型は  

型[][] ... []となります。  

また、配列の生成は  

```
型名[] = new 型名[配列の長さ]
```

という形でも行えます。  

n次元配列の要素へのアクセスは、  

１つ目の階層の要素をアクセス: 配列名[要素の番号]  
n階層の要素へのアクセス: 配列名\[要素の番号\][要素の番号]...  

となります。  

## 5.4 配列の便利な機能

### 配列の長さ

上記プログラムは、エラーを避けるため内側のforループで継続条件にj < 2を使っています。  
これでは、三人名以降のメンバーが表示できません。  

配列には長さを取得する機能(公開されているフィールド)があります。  
これを利用して上記のプログラムを改良してみましょう。  

```java
// Main
public class Main {

    public static void main(String[] args) {
        // 配列定義が冗長なためリファクタリング
        String[][] members = {
            { "Tom", "Alis", "Bob" },
            { "Jacob", "Sophia", "Ethan", "William" },
            { "Google", "Excel" }
        };
        for (int i = 0; i < members.length; i++) {
            System.out.println("グループ" + (i + 1) + ": " + members[i].length + "名");
            for (int j = 0; j < members[i].length; j++) {
                System.out.println((j + 1) + "人目" + members[i][j]);
            }
        }
    }

}
```

これで各グループごとにメンバーの数と、そのメンバーの名前を表示させることができました。  


## 5.5 クラスとインスタンス

ここまでの章でも度々出てきましたが、*クラス*と*インスタンス*について詳しく見て行きましょう。

まず、クラスとはプログラムで表現したいモノの設計図に当たるものです。  
例えば「人間」というクラスがあったとしたら、そのクラスは「名前」や「性別」といった情報(*フィールド*)を持ちますし、  
「話す」という振る舞い(*メソッド*)も行います。

クラスを定義して見ましょう。  
Mainクラスと同じパッケージ内にHuman.javaを作成し、以下を記述してください。  

```java
// Human.java
public class Human {

  /**
    * Humanクラスの持つフィールド。
    * 初期値を設定しているが、インスタンスを作るときに個別に設定する。
    */
  String name = "";
  int gender = 0; // 男性: 0, 女性: 1として表現している。

  /**
    * コンストラクタ
    */
  public Human(String name, int gender) {
      /**
        * コンストラクタが呼ばれたときに引数として渡された名前と性別を、
        * インスタンスのnameとgenderに設定する。
        */
      this.name = name;
      this.gender = gender;
  }

  /**
    * インスタンスメソッド
    */
  public String greet() {
      String frase = "Hello. How are you?";
      return frase;
  }

  public String reply() {
      String frase = "I'm fine. Thank you.";
      return frase;
  }

}
```

インスタンスはクラスから作られる「具体的なモノ」です。  
人間というクラスに対して、「佐藤さん」や「鈴木さん」という具体的な人物が相当します。  

クラスからインスタンスを作るためには*コンストラクタ*と呼ばれる特別なメソッドを呼び出します。  
Javaでのコンストラクタはクラスと同じ名前をつけます。  

上記のプログラムの例を見てみると、引数としてとったname, genderという値を this.name, this.genderに代入しています。  
ここで、nameとthis.nameは別物です。  
thisとは個別のインスタンスを表す特別な言葉(予約語)であり、this.nameはインスタンスそれぞれの名前を表しています。  
一方ただのnameの方は、インスタンスを生成する際に設定した値です。  

Humanクラスを利用するには、readLineメソッドを利用した時のように、  
new演算子でHumanインスタンスを生成します。  
Main.javaに以下を記述してください。

```java
// Main.java
package sample;

public class Main {

    public static void main(String[] args) {
        Human member1 = new Human("Tom", 0);
        Human member2 = new Human("Alice", 1);
        System.out.println(member1.name + ": " + member1.greet());
        System.out.println(member2.name + ": " + member2.reply());
    }

}
```

フィールドやメソッドの呼び出しには変数名.フィールド名や変数名.メソッド名(引数)といった記述をします。  

このようにモノの設計図(クラス)を定義し、その設計図から生成した具体的なモノ(インスタンス)を使って  
プログラムを組み立てていく考え方を*オブジェクト指向*と言います。  

オブジェクト指向は表現方法はそれぞれ異なりますが、多くのプログラミング言語に取り入れられている考え方です。  
この先の章ではJavaのオブジェクト指向における様々な概念が登場します。  
他の言語でも根幹となる考え方は共通するものが多いため、ぜひ身につけてください。

## 練習問題

[Section-5. 関数・配列の練習問題](./section-5-exercise.md)  
