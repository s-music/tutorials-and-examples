# Section-4. スレッド

## 4.1 スレッド

Javaにおける*スレッド*とはプログラムを実行する主体を指します。(スレッド上でプログラムの処理が実行されます。)  
スレッド上ではどの時点でも、行なっている処理は１つです。  

*シングルスレッド*と呼ばれるスレッドが１つの状態では、プログラムの処理は１つずつ順番に行われていき、  
完了するまでに時間のかかる処理(*ボトルネック*)を行なっていたとしても、それが完了するまで次の処理は実行されません。  

対して、*マルチスレッド*と呼ばれるスレッドが複数ある状態では、複数の処理が平行して行われるため、  
ボトルネックがあったとしても、その完了を待たずに次の処理を進めることができます。  

Javaではこうしたスレッドをコード上から扱うことができます。  
Javaでスレッドを扱う方法は2種類あります。  

- Threadクラスを用いる方法
- Runnableインタフェースを用いる方法

それぞれの方法についてみていきましょう。  

## 4.2 Treadクラス

シングルスレッドとマルチスレッドの違いを確認するため、まずシングルスレッドのプログラムを書いてみます。  
Main.javaを作成し、以下のプログラムを記述してみてください。  

```java
// Main.java

public class Main {

  public static void main(String[] args) {
    for (int i = 0; i < 10; i++) {
        System.out.println("main: " + i);
    }
    for (int i = 0; i < 10; i++) {
        System.out.println("sub: " + i);
    }
  }

}
```

上記のプログラムはmain: 0 ~ 9を表示した後、sub: 0 ~ 9を表示します。  
これは何度実行しても、結果は同じになります。  

では、マルチスレッドのプログラムを書いてみましょう。  

Treadクラスを用いてスレッドを扱う場合、  
独立したスレッド上で扱いたい処理を扱うクラスにTreadクラスを継承させ、  
Treadクラスのメソッドであるrunメソッドをオーバーライドし、  
子クラスのインスタンスからstartメソッドを実行します。  

Count.javaを作成し、以下のプログラムを記述してみてください。  

```java
// Count.java

public class Count extends Thread {

  @Override public void run () {
    for(int i = 0; i < 10; i++) {
      System.out.println("sub: " + i);
    }
  }

}
```

さらに、Main.javaを以下のように書き換えてみましょう。  

```java
// Main.java

public class Main {

  public static void main(String[] args) {
    Count count = new Count();
    count.start(); // 先に実行しておく
    for (int i = 0; i < 10; i++) {
        System.out.println("main: " + i);
    }
  }

}
```

マルチスレッドの方はスレッドごとに処理が進むため、実行するたびに結果が異なると思います。  
※メソッド内部では処理が上から下に進んで行くため、forループの後にcount.start()を行うと結果が変わらなくなります。  

また、ここで新規に作成されたスレッドはrunメソッドの処理が終了した直後に消滅します。  

## 4.3 Runnableインタフェース

次にRunnableインタフェースを使った例をみてみましょう。  
Main.java、Count.javaを以下のように変更してください。  

```java
// Count.java

public class Count implements Runnable {

  @Override public void run () {
    for(int i = 0; i < 10; i++) {
      System.out.println("sub: " + i);
    }
  }

}
```

```java
// Main.java

public class Main {

  public static void main(String[] args) {
    Count count = new Count();
    Thread thread = new Thread(count);
    thread.start();
    for (int i = 0; i < 10; i++) {
        System.out.println("main: " + i);
    }
  }

}
```

Runnableインタフェースを使う場合には、  
インタフェースを実装したクラスのインスタンスを、  
Threadクラスのコンストラクタに渡し、  
そこで生成したThreadクラスのインスタンスのstartメソッドを呼び出すことで、  
スレッドを生成することができます。  

Threadクラスを継承する場合は生成されるインスタンスは子クラスのインスタンスのみとなり、  
実行方法も手軽でコード量も少なくて済みます。  
しかし、Javaではスーパクラスは１つしか持てないため、他のクラスを継承したい場合はRunnableインタフェースを用いる必要があります。  
場合によって使い分けるようにしましょう。  

## 4.2 スレッドの処理の競合

スレッドを複数生成することによって処理を並列して行うことができるということは理解していただけたと思いますが、  
並列して処理を行うことによって矛盾が発生するパターンをみてみましょう。  

Count.javaとMain.javaを以下のように書き換えてみてください。  

```java
// Count.java

public class Count implements Runnable {

  /** インスタンスフィールド **/
  public int counter = 0;

  /** インスタンスメソッド **/
  @Override public void run () {
    for(int i = 0; i < 10; i++) {
      this.countUp();
    }
  }

  public void countUp() {
    counter++;
    System.out.println(Thread.currentThread() + ": " + counter);
  }

}

```

```java
// Main.java

public class Main {

  public static void main(String[] args) {
    Count count = new Count();
    Thread thread1 = new Thread(count);
    Thread thread2 = new Thread(count);
    thread1.start();
    thread2.start();
  }

}
```

これを実行すると、  

```
Thread[Thread-0,5,main]: 2
Thread[Thread-0,5,main]: 3
Thread[Thread-0,5,main]: 4
Thread[Thread-1,5,main]: 2
Thread[Thread-1,5,main]: 6
Thread[Thread-1,5,main]: 7
Thread[Thread-1,5,main]: 8
Thread[Thread-1,5,main]: 9
Thread[Thread-0,5,main]: 5
Thread[Thread-1,5,main]: 10
Thread[Thread-0,5,main]: 11
Thread[Thread-1,5,main]: 12
Thread[Thread-0,5,main]: 13
Thread[Thread-1,5,main]: 14
Thread[Thread-0,5,main]: 15
Thread[Thread-1,5,main]: 16
Thread[Thread-0,5,main]: 17
Thread[Thread-1,5,main]: 18
Thread[Thread-0,5,main]: 19
Thread[Thread-0,5,main]: 20
```

このように数字がまちまちになっていると思います。  
片方がcountUp()メソッドの処理中にもう片方もcountUp()メソッドを実行し、  
片方がコンソールに表示する前にもう片方が表示まで処理を進めてしまうことがあるのです。

このような事態を防ぐために、*synchronized修飾子*が用意されています。  
この修飾子をつけているメソッドをあるスレッドが実行している間は、  
他のスレッドはそのメソッドを使用することができなくなり、待ち状態になります。  

countUp()メソッドにsynchronized修飾子をつけてみましょう。  

```java 
// Count.java

public synchronized void countUp() {
  counter++;
  System.out.println(Thread.currentThread() + ": " + counter);
}
```

数字が揃うようになったと思います。  

### 補足) synchronized修飾子の付け方

synchronized修飾子を付与上で注意が必要なのは、  
付与する関数がインスタンスメソッドなのかクラスメソッドなのかを認識しておく必要があることです。  

インスタンスメソッドに付与した場合は、異なるスレッドで同じインスタンスのインスタンスメソッドにアクセスした時に片方がブロックされます。  
一方クラスメソッドに付与した場合は、異なるスレッドでそのクラスメソッドにアクセスした場合に片方がブロックされます。  

この違いを意識しないと、バグの温床になります。  


### 補足) 匿名クラス(Anonymous class)

Javaではこのような記述を見かけることがあります。  

```java
Runnable r = new Runnable() {
  @Override public void run() {
    System.out.println("aaa");
  }
};
```

なぜ、インタフェースをnewできているのでしょうか?  
これはインタフェースのインスタンスを生成している訳ではなく、Runnableインタフェースを実装した名前のないクラスが  
自動で定義され、そのインスタンスが作られているのです。  

このように自動で定義される名前のないクラスを*匿名クラス*もしくは*インナークラス*と呼びます。  

この構文はクラスにも適用でき、そのクラスを継承した名前のないクラスが自動で定義されます。  

## 練習問題

[Section-4. スレッドの練習問題](./section-4-exercise.md)  