# Javaによる関数型プログラミング Java 8ラムダ式とStream 問題



## 第2章 コレクションの使用

### 問1.

「第2章 コレクションの使用」に関する簡単な要約と考察をまとめた資料を作成して提出してください。  

### 問2.

以下のようなリストがあったとする。  

```java
List<String> friends = Arrays.asList("Tom", "Alice", "Bob", "Clis", "Jacob");
```

このリストから、'a(A)''c(C)'、'b(B)'を含む名前をそれぞれ抽出して大文字変換し、    
それらを',(カンマ)'で区切った文字列を表示するプログラムを記述してください。  

<br>

- 実行結果

```
ALICE, JACOB
BOB, JACOB
ALICE, CLIS, JACOB
```

## 第3章 文字列、コンパレータ、フィルタ

### 問1.

「第3章 文字列、コンパレータ、フィルタ」に関する簡単な要約と考察をまとめた資料を作成して提出してください。  

### 問2.

商品を表すProductクラスがあったとする。

```java
public class Product {

  /** フィールド **/
  private String name = ""; // 商品名
  private String code = ""; // 商品コード
  private ProductType type = ProductType.TypeA; // 商品種別
  private int price = 0; // 値段(円)

  public static enum ProductType {
    TypeA,
    TypeB,
    TypeC,
    TypeD
  };

  /** コンストラクタ **/
  public Product(String name, String code, ProductType type, int price) {
    this.name = name;
    this.code = code;
    this.type = type;
    this.price = price;
  }

  /** インスタンスメソッド **/
  public String getName() {
      return this.name;
  }

  public String getCode() {
      return this.code;
  }

  public ProductType getType() {
      return this.type;
  }

  public int getprice() {
      return this.price;
  }

  @Override public String toString() {
      return String.format("商品名: %s, 商品コード: %s, 種別: %s,  価格: %d円", this.name, this.code, this.type , this.price);
  }

}
```

以下のようなProductインスタンスのリストがあった場合に、  
このリストから商品種別Aと商品種別Bかつ1000円よりも安いのものを抽出し、  
価格順に並べて表示するプログラムを作成してください。  

```java
private static List<Product> products = Arrays.asList(
    new Product("商品A", "0001", ProductType.TypeA, 100),
    new Product("商品B", "0002", ProductType.TypeA, 500),
    new Product("商品C", "0003", ProductType.TypeB, 5000),
    new Product("商品D", "0004", ProductType.TypeC, 300),
    new Product("商品E", "0005", ProductType.TypeB, 400),
    new Product("商品F", "0006", ProductType.TypeD, 200),
    new Product("商品G", "0007", ProductType.TypeA, 10),
    new Product("商品H", "0008", ProductType.TypeD, 3000),
    new Product("商品I", "0009", ProductType.TypeB, 1500),
    new Product("商品J", "0010", ProductType.TypeC, 450)
);
```

- 実行結果

```
商品A: 
商品名: 商品B, 商品コード: 0002, 種別: TypeA,  価格: 500円
商品名: 商品A, 商品コード: 0001, 種別: TypeA,  価格: 100円
商品名: 商品G, 商品コード: 0007, 種別: TypeA,  価格: 10円

商品B: 
商品名: 商品E, 商品コード: 0005, 種別: TypeB,  価格: 400円
```

## 第4章 ラムダ式設計する

### 問1.

「第4章 ラムダ式設計する」に関する簡単な要約と考察をまとめた資料を作成して提出してください。  

### 問2.

第3章 問2において作成したプログラムを改良して商品種別Cと商品種別Dの商品も抽出できるようにしてください。  
また、1000以上の商品を抽出して商品種別順(A → B → C → D)に並べて表示できるようにしてください。  

ただし、関数型インタフェースを用いて実装してください。  

- 実行結果

```
商品A: 
商品名: 商品B, 商品コード: 0002, 種別: TypeA,  価格: 500
商品名: 商品A, 商品コード: 0001, 種別: TypeA,  価格: 100
商品名: 商品G, 商品コード: 0007, 種別: TypeA,  価格: 10

商品B: 
商品名: 商品E, 商品コード: 0005, 種別: TypeB,  価格: 400

商品C: 
商品名: 商品J, 商品コード: 0010, 種別: TypeC,  価格: 450
商品名: 商品D, 商品コード: 0004, 種別: TypeC,  価格: 300

商品D: 
商品名: 商品F, 商品コード: 0006, 種別: TypeD,  価格: 200
```

## 第5章 外部リソースを扱う

### 問1.

「第5章 外部リソースを扱う」に関する簡単な要約と考察をまとめた資料を作成して提出してください。  

### 問2.

コンソールから入力された文字列を指定されたファイルに対して書き込むプログラムを作成してください。  
ただし、ラムダ式を用いてEAMパターンになるようにしてください。  

- 実行結果

```
書き込むファイル名を入力してください: sample.txt
書き込む文字列を入力してください: "Hello, World!!"
ファイルをオープンします。
ファイルに書き込みをおこないます。
ファイルをクローズします。
```

## 第6章 「遅延させる」ということ

### 問1.

「第6章 「遅延させる」ということ」に関する簡単な要約と考察をまとめた資料を作成して提出してください。  

### 問2.

第3章, 第4章で用いたProductインスタンスをコンソールから指定された個数生成する工場(ProductFactoryクラス)を作成してください。  
(必要に応じてProductクラスを変更しても構いません。)
工場の仕様については生産ライン(Thread)を２つ持っており、別々にオーダーを受けます。  
機械(ProductMachineクラス)を用いてProductを生産しますが、片方のThreadが作業している間はもう片方はその終了を待たなくてはいけません。(スレッドセーフ)  

- 実行結果

```
商品名を入力してください: Product1
商品コードを入力してください: 0001
種別を入力してください(0: A, 1: B, 2: C, 3: D): 0
価格を入力してください: 200
thread1に生産させる個数を入力してください: 2
thread2に生産させる個数を入力してください: 3
Thread[Thread1,5,main]:商品名: Product1, 商品コード: 0001, 種別: TypeA,  価格: 200
Thread[Thread2,5,main]:商品名: Product1, 商品コード: 0001, 種別: TypeA,  価格: 200
Thread[Thread1,5,main]:商品名: Product1, 商品コード: 0001, 種別: TypeA,  価格: 200
Thread[Thread2,5,main]:商品名: Product1, 商品コード: 0001, 種別: TypeA,  価格: 200
Thread[Thread2,5,main]:商品名: Product1, 商品コード: 0001, 種別: TypeA,  価格: 200
商品名を入力してください: // 入力待ちの状態に戻る
```

※ 不正な値が入力された場合は以下のメッセージを出力してプログラムを終了してください。  
`入力値が不正です。`

※ 不正な入力以外でのプログラムの終了はCtrl+Dで行うようにしてください。  

## 第7章 再帰の最適化

### 問1.

「第7章 再帰の最適化」に関する簡単な要約と考察をまとめた資料を作成して提出してください。  

### 問2.

n=50のフィボナッチ数列を求めるプログラムを作成してください。  
ただし、末尾呼び出し最適化を行ってください。  

- 実行結果

```
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229, 832040, 1346269, 2178309, 3524578, 5702887, 9227465, 14930352, 24157817, 39088169, 63245986, 102334155, 165580141, 267914296, 433494437, 701408733, 1134903170, 1836311903, 2971215073, 4807526976, 7778742049```