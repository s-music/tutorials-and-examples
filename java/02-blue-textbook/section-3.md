# Section-3. Javaの機能

## 3.1 例外

Javaではプログラムで問題が発生した場合に例外(Exception)が投げられるということは以前にも説明しました。  
例外が発生する箇所にはtry-catch構文を適用し、catch節に例外が発生した場合の処理を記述するのでした。  

この説ではJavaにおける例外について厳密にみていきたいと思います。  

#### ・例外の階層

Javaではエラーを表現する大元のクラスに*Trowable*というクラスが存在します。  
このTrowableがtry節で投げられると、catch節に入ってきます。  

Trowableクラスを継承するクラスはErrorとExceptionに分かれ、  
Errorクラスは「これ以上プログラムの継続を期待できない場合のエラー」を表し  
Exceptionクラスは「適切な処理を行った後にプログラムの継続を期待する場合のエラー」を表します。  

さらにExceptionクラスはRuntimeExceptionクラス(プログラム実行中に発生する可能性があるException)と、  
それ以外のExceptionクラス(コンパイル時にチェックされるException)に別れます。

RuntimeException以外のExceptionには必ずtry-catch構文を使わなければなりません。  

例外を処理するプログラムを書いてみましょう。  
ExceptionTest.javaを作成し、以下を記述してみてください。  

```java
// ExcptionTest
public class ExceptionTest {

  public static void main(String[] args) {
    try {
      String str = "ABC";
      int val = Integer.parseInt(str); // RuntimeExceptionが発生する。 
    } catch(NumberFormatException e) {
      System.out.println(e);
    }
  }

}
```

Integer.parseInt(String s)メソッドは文字列のみを与えられた場合、それを10進数の値として変換するメソッドです。  
Integer.parseInt(String s)メソッドの定義元を確認してみると、 throws NumberFormatExceptionとあるのが確認できると思います。  
*throws*はこの関数内で例外が投げられた場合に、この関数の呼び出し元にその例外を伝搬させることを表しています。  
さらに関数を遡ってみると、Integer.parseInt(String s)メソッドの中ではInteger.parseInt(String s, int radix)メソッド  
が呼ばれており、こちらも同じくthrows NumberFormatExceptionがついています。  
そして、処理の中で度々throw NumberFormatExceptionインスタンスという記述がでてくるのが確認できると思います。  
この*throw文*が例外を発生させている箇所です。  
throw文で生成された例外はその関数内でcatchされなければ、throwsで上位の関数に伝搬されていきます。  

既存の例外を継承することで、独自の例外を作ることもできます。  
MyException.javaを作成し、以下を記述してください。  
さらに、Exception.javaも以下のように書き換えてください。  

```java
// MyException.java
public class MyException extends Exception {

  public MyException() {
    super();
  }
}
```

```java
// ExcptionTest.java
public class ExceptionTest {

  public static void main(String[] args) {
    try {
      throw new MyException();
    } catch(MyException e) {
      System.out.println(e);
    }
  }

}
```

既存の例外と同じようにtry-catchで例外をキャッチできたと思います。  

最後にtry-catch構文にはfinallyという節をつくることができます。  
これは例外が発生しようがしまいが必ず最後に実行する処理を記述します。  
Exception.javaを以下のように書き換えてください。  

```java
// ExcptionTest.java
public class ExceptionTest {

    private static final int num = 10;

    public static void main(String[] args) {
      try {
        if(num < 10) {
          throw new MyException();
        }
      } catch(MyException e) {
        System.out.println(e);
      } finally {
        System.out.println("最後に必ず実行");
      }
    }

}
```

numの値を変化させることでMyExceptionが発生するかどうかを変更できますが、  
MyExceptionが発生したかどうかに関わらず、finally節が実行されることが確認できると思います。  

## 3.2 ガーベッジコレクション(GC)

*ガーベッジコレクション(GC)*とは不要になったインスタンスが占有しているメモリを自動で解放してくる機能です。  
不要になったインスタンスとはどこからも参照されていないインスタンスを指します。  

JVM(Java仮想マシン)上のメモリ領域は*スタック*と*ヒープ*に分けられ、  
スタックには実行する処理や処理中に用いる変数などが格納され、  
ヒープには主にインスタンスが格納されています。  
ガーベッジコレクションは、あるタイミングでヒープ領域にあるインスタンスのうち不要なものを破棄します。  

また、ガーベッジコレクションが発生している間はプログラムが一時停止します。  

#### 補足) 参照型

クラスはデータではなくデータの保存場所(アドレス)を保持している、参照型でした。  
クラスからインスタンスを生成して変数に格納すると、インスタンスのアドレスが保存されます。  

参照型の変数を別の変数にコピーすると、２つの変数は同じインスタンスのアドレスを参照することになります。  
従って、片方の変数の値を変更した場合にはもう片方の変数の値も変化することになります。  

```java
Something obj1 = new Somethig(); // String str = "hoge"というフィールドを持つ
Something obj2 = obj1;
System.out.println(obj1.str); // hoge
System.out.println(obj2.str); // hoge
obj.str = "fuga";
System.out.println(obj1.str); // fuga
System.out.println(obj2.str); // fuga
```

ガーベッジコレクションの動作を確認してみましょう。  
Main.javaを以下のように書き換えます。  

```java
public class Main {

  public static void main(String[] args) {
      while(true) {
        String str = new String("");
        System.out.println(Runtime.getRuntime().freeMemory());
      }
  }

}
```

無限ループの中でインスタンスを作り続け、  
残りのメモリ量を表示するプログラムです。  
※「Ctrl+C」で強制終了できます。  

Runtimeクラスはアプリケーションの動作環境を表すクラスで、getRuntime()関数でRuntimeのインスタンスを取得し、  
freeeMemory()関数を用いることで、利用可能なメモリ量を取得できます。  

これを実行していくと、あるタイミングでメモリが増えることがあります。  
これはGCによってメモリが解放され、メモリが増えているのです。  

#### 補足) シングルトンパターン

Runtimeを取得するとき、わざわざgetRuntime()を呼び出してからfreeMemory()を呼び出すような設計になっているのは  
どうしてでしょう?  

Runtimeとはアプリケーションの動作環境を表すクラスのため、１つのアプリケーションに対して１つのインスタンスがあれば十分です。  
アプリケーション中であるクラスのインスタンスを１つだけ作り(シングルトンオブジェクト)、それ以外のインスタンスを生成できないようにする設計を  
*シングルトンパターン*と呼びます。

Runtimeクラスの定義元をみてみましょう。  

```java
public class Runtime {
    // Runtime内でのみ参照可能なクラスフィールドに自分自身のインスタンスを格納(シングルトンオブジェクト)
    private static Runtime currentRuntime = new Runtime();
    public static Runtime getRuntime() {
      // シングルトンオブジェクトを返すようにする。
      return currentRuntime;
    }
    // privateなコンストラクタ
    private Runtime() {}
    // ~ 以降コードが続く ~
}
```

コンストラクタをprivateにすることで、このクラス内でのみインスタンスを生成できます。  
そして、privateなクラスフィールドに自分自身のインスタンスを格納しておくことで、  
外部からインスタンスへのアクセスを制限(隠蔽)することができます。  

シングルトパターンは強力なパターンですが、シングルトンオブジェクト(インスタンス)が生成されるタイミングは  
getRuntimeメソッドを初めて呼び出したタイミングのため、Section4で説明する *マルチスレッド*で呼び出された場合、  
矛盾が発生する可能性があるため注意が必要です。  

## 練習問題

[Section-3. Javaの機能の練習問題](./section-3-exercise.md)
