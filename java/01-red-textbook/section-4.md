# Section-4. 繰り返し命令

## 4.1 for文

ある処理を一定の回数繰り返し行いたい場合は*繰り返し構文*と呼ばれる構文を用います。
まずは*for文*と呼ばれる構文を紹介します。  

Main.javaに以下のプログラムを記述してみてください。  

```java
// Main.java
public class Main {

    public static void main (String[] args) {
        for(int num = 0; num < 5; num++) {
            System.out.println("今の値は" + num + "です。");
        }
    }

}
```

for文の構造は以下のようになっています。  

```
for (変数の初期化; 条件式; {}の処理が終わった後に実行する処理) {
  繰り返す処理
}
```

したがって、上記のプログラムは、  
()ないでnumという変数を定義し、numが5より小さい限りnumを表示し続け、numの表示し終わったタイミングでnumを1増やすという処理になります。  

１つ注意しなければならない点として、繰り返しを始める前にも条件を判定します。  
従って、初期化する際にint num = 6などとすると、{}内の処理は一度も実行されません。  

for文内に別のfor文を入れることも可能です。  
以下のようにMain.javaを書き換えて、九九を表示するプログラムにしてみましょう。  

```java
// Main.java
public class Main {

    public static void main (String[] args) {
        for(int i = 1; i < 10; i++) {
            System.out.println(i + "の段");
            for(int j = 1; j < 10; j++) {
                System.out.println(i + " × " + j + " = " + (i * j));
            }
        }
    }

}
```

for分の中にfor文を入れ子にした場合は、外側のfor文が進むたびに、内側のfor文が実行されます。  
つまり実行回数は(外側の繰り返し回数) × (内側の繰り返し回数)となります。  

## 4.2 変数の有効範囲(スコープ)

プログラミングには*スコープ*という概念があります。  
スコープとは、ある変数やクラス、メソッドがあったとして、それにアクセスできる範囲のことです。  

九九のプログラムで以下のようにfor文の外からiにアクセスしてみましょう。

```java
// Main.java
public class Main {

    public static void main (String[] args) {
        for(int i = 1; i < 10; i++) {
            System.out.println(i + "の段");
            for(int j = 1; j < 10; j++) {
                System.out.println(i + " × " + j + " = " + (i * j));
            }
        }
        System.out.println(i);
    }

}
```

エラーが出たと思います。  
for文で宣言した変数にはfor文内からしかアクセスできないため、注意が必要です。  

## 4.3 while文

繰り返し構文にはもう１つ*while文*と呼ばれる構文があります。  
Main.javaに以下のプログラムを記述してください。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        int i = 0;
        while (i < 3) {
            System.out.println(i);
            i++;
        }
    }

}
```

while文は()内の式を評価してtrueだった場合に処理を実行し、再度()内の式を評価します。  
for文と違い、処理完了後の処理を記述する部分が無いため、処理の終わりにiを1づつ増やしています。  

## 4.4 do-while文

while文と同じような動作を行う構文に、*do-while文*という構文があります。  
Main.javaを以下のように書き換えてみてください。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        int i = 0;
        do {
            System.out.println(i);
            i++;
        } while (i > 0);
    }

}
```

これは、*無限ループ*になってしまう例です。  
do-while文はまず処理を行った後で、繰り返し条件を評価するため、  
最初の一回が実行されてしまい、条件式がtrueになり続けるため、永遠に処理が終わらなくなってしまいます。 

## 4.5 break文とcontinue文

条件式の評価以外にループから抜ける方法として、*break文*が用意されています。
先ほどの無限ループのプログラムを以下のように書き換えてください。

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        int i = 0;
        do {
            System.out.println(i);
            if(i == 100) {
                break;
            }
            i++;
        } while (i > 0);
    }

}
```

iが100になった場合にbreak文が実行され、強制的にループから抜けます。  

*continue文*を使って、強制的に次の処理に進めることもできます。  
以下のようにMainを書き換えてください。  

```java
// Main.java
public class Main {

    public static void main(String[] args) {
        int i = 0;
        while(i <= 100) {
            if(i % 2 != 0) {
                i++;
                continue;
            }
            System.out.println(i);
            i++;
        }
    }

}
```

iが2の倍数でないときはcontinue;が実行され、  
System.out.println(i);  

## 練習問題

[Section-4. 繰り返し命令の練習問題](./section-4-exercise.md)  
