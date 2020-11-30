# Section-3. 分岐命令

プログラミング言語には特定の処理を行う*制御構文*を持つものがあります。  
Section3, 4ではJavaの制御構文について学んでいきます。  

## 3.1 分岐命令

最初の制御構文は条件分岐命令である*if文*です。  
その名の通り「もし~ならばこれこれの処理を行う」という動作をします。  

早速使ってみましょう。Main.javaに以下を記述してみましょう。  

```java
// Main.java
import java.io.*;

public class Main {

    public static void main (String[] args) {
        String str = ""; // 空文字で初期化
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            str = reader.readLine();
        } catch(IOException e) {
            System.out.println("Error");
        }
        if(str == "") {
            System.out.println("文字を入力してください。"); 
        }
    }

}
```

if文は()内に記述された処理が正しい場合は{}内の処理を行い、正しく内場合は{}内の処理は行われません。  
if文の()内には結果がboolean型の値になる式(主に*比較演算子*を用いた式)を記述します。  

|  比較演算子を使った式 | 意味 |  |  |  |  |
|  :------: | :------: | ------ | ------ | ------ | ------ |
|  p == 50 | pが50に等しい場合にはtrue、等しくない場合はfalse |  |  |  |  |
|  p != 50 | pが50に等しくない場合はtrue、等しい場合はfalse |  |  |  |  |
|  p >= 50 | pが50以上の場合はtrue、pが50未満の場合はfalse |  |  |  |  |
|  p <= 50 | pが50以下の場合はtrue、pが50より大きい場合はfalse |  |  |  |  |
|  p > 50 | pが50より大きい場合はtrue、pが50以下の場合はfalse |  |  |  |  |
|  p < 50 | pが50より小さい場合はtrue、pが50以上の場合はfalse |  |  |  |  |
|  p >= 50 && p <= 100 | pが50以上かつ100以下の場合はtrue、pが50より小さいかつ100より大きいの場合はfalse |  |  |  |  |
|  p < 50 \|\| p > 100 | pが50より小さいかつ100より大きいの場合はtrue、pが50以上かつ100以下の場合はfalse |  |  |  |  |

さらにelseを用いることで、条件を満たさなかった場合の処理も記述できます。  

```java
// Main.java
import java.io.*;

public class Main {

    public static void main (String[] args) {
        String str = ""; // 空文字で初期化
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            str = reader.readLine();
        } catch(IOException e) {
            System.out.println("Error");
        }
        if(str == "") {
            System.out.println("文字を入力してください。");
        } else {
            System.out.println(str);
        }
    }

}
```

これで、何も入力がない場合は入力を促すメッセージを表示し、入力がある場合はそれを表示するようになりました。  
また、else if(条件式)を用いることで、条件を満たさない場合に別の条件を満たす場合の処理を記述することができます。  
少し複雑なプログラムを書いてみましょう。

```java
// Main.java
import java.io.*;

public class Main {

    public static void main (String[] args) {
        String str = "";
        int num = 0;
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            str = reader.readLine();
            num = Integer.parseint(str);
        } catch(IOException e) {
            System.out.println("Error");
        } catch(NumberFormatException e) {
            System.out.println("Error");
        }
        if(str >= 100) {
            System.out.println("入力された数値は100以上の数値です。");
        } else if(str >= 50) {
            System.out.println("入力された数値は50以上の数値です。");
        } else if(str >= 0) {
            System.out.println("入力された数値は正の数です。");
        } else {
            System.out.println("入力された数値は負の数です。");
        }
    }

}
```

## 3.2 switch文

Javaで条件分岐を行う制御構文にはif文の他に*switch文*と呼ばれる制御構文があります。  
switch文を使ってみましょう。Main.javaに以下を記述してみてください。  

```java
// Main.java
import java.io.*;

public class  Main {

    public static void main (String[] args) {
        String str = "";
        int num = 0;
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try {
            str = reader.readLine();
            num = Integer.parseint(str);
        } catch(IOException e) {
            System.out.println("Error");
        } catch(NumberFormatException e) {
            System.out.println("Error");
        }
        switch(num) {
        case 1:
            System.out.println("入力された数値は1です。");
            break;
        case 2:
            System.out.println("入力された数値は2です。");
            break;
        case 3:
            System.out.println("入力された数値は3です。");
            break;
        default:
            System.out.println("入力された数値は1,2,3以外の数値です。");
            break;
        }
    }

}
```

switch文は()内に記述した式がcase部分に記述された値と等しいときに':(コロン)'以降の処理が実行されます。  
どのcaseにもマッチしたかった場合は、default:以降の処理が実行されます。  

また、breakという処理が各case・default節の最後に記述されていますが、  
Javaのswitch文ではbreakを記述しない場合、それ以降の処理が全て実行されます。  
試しにbreak文を全てコメントアウトしてcase 2:の節に入るように数値を入力してみましょう。  

case 3:、default:の節に記述した処理も実行されたことが確認できたと思います。  
このようにbreak;を記述しない場合は後続の処理も実行されてしまうため、注意が必要です。  

## 練習問題

[Section-3. 分岐命令の練習問題](./section-3-exercise.md)  
