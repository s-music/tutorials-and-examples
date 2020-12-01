## swiftのデータ型
#### 1. Class
参照型
```swift
Class Hoge {
   let a
   var b
}
```
#### 2. Struct
値型
```swift
Struct Hoge {
   let a
   var b
}
```
#### 3. Enum
値型
```swift
Enum Hoge {
   case a
   case b
}
```

## swiftの基本的な組み込み型

#### 1. Int型 → 整数値
#### 2. String型 → 文字列型
#### 3. Charcter → 文字型
#### 4. Bool型 → 真偽値型
#### 5. Float型 → 浮動小数点数型(32bit)
#### 6. Double型 → 浮動小数点数型(64bit)
#### 7. Array<Element>型 → 配列型
#### 8. Dictionary<Key, Value>型 → 辞書
#### 9. Range系の型 → 範囲
#### 10. Stride型 → 一定の間隔が空いた範囲
#### 11. Optional<Wrapped>型、ImplicitryUnwrappedOptional<Wrapped>型 → 値の存在

## swiftの制御構文
- if文<br>
条件にが真になったコードブロックの処理が実行される。
```swift
if 条件 {
    処理
} else if 条件 {
    処理
} else {
    処理
}
```

- while文<br>
条件がtrueの限り実行しつづける。
```swift
while 条件 {
    処理
}
```

- repeate-while文<br>
必ず一回実行されるwhile文
```swift
repeate {
    処理
} while 条件
```

- for-in文<br>
swift3からC言語風な構文
```swift
for i = 0; i < 1; i++ {

}
```
が廃止されています。

swift3から
```swift
for 変数名 in 式 (where式) {
    処理
} 
```
の形が採用されています。<br>
例)
```swift
// 0 ~ 10までの値のうち偶数のみを出力する。
for i in 0..<10 where i % 2 = 0 {
    print(i)
}

// hogeを三回表示
// 変数を使わない時はプレースホルダで省略
for _ in 0...2 {
    print("hoge")
}
```

- switch文<br>
条件にマッチした処理を実行します。swiftではデフォルトでC言語fallthroughしないのでbreakは不要。
```swift
switch 変数名 {
case  パターン1:
    処理
case  パターン2:
    処理
    fallthrough; // fallthroughを行いたい場合、明示的に記述する。
case  パターン3:
    処理
:
:
case  パターンn:
    処理
default:
    処理    
}
```

## swiftの関数定義
```swift
func 関数名(引数: 型) (-> 戻り値) {
    処理
}
```

## swiftのアクセス修飾子
#### 1. internal<br>
同一のモジュール内からアクセス可能。デフォルトの修飾子。
#### 2. private<br>
クラスなどの宣言内からのみアクセス可能。
#### 3. fileprivate<br>
同一のファイル内でのみアクセス可能。
#### 4. public<br>
他のモジュールからもアクセス可能。overrideは可能だが、継承ができない。
#### 5. open<br>
publicのアクセス範囲に加えて、継承が可能。

制約の強さ(弱 → 強)<br>
open → public → internal → fileprivate → private

## クロージャ<br>
無名関数を変数に代入する
```swift
let a: (引数: 型) -> (戻り値) =  { (引数: 型)　-> (戻り値) in 
    本文 
} 
```
例)
```swift 
let add: (Int, Int) -> Int = { (x: Int, y: Int) -> Int in 
    return x + y
}
```
省略
```swift
var add: (Int, Int) -> Int
add = { ($0, $1) in 
    return $0 + $1
}
```
さらに省略
```swift
var add: (Int, Int) -> Int
add = { $0 + $1 }
```

## 値の存在を示す型(Optional<Wrapped>, ImplicitlyUnwrappedOptional<wrapped>)

ラップしている型の値が存在しているかどうかを示し、Optional<Wrapped>は値を取り出すためにアンラップ処理を行う必要があります。<br>
ImplicitlyUnwrappedOptional<wrapped>はアンラップの必要がなく、暗黙的にラップしている型に変換されますが、値がない場合は実行時エラーになります。

```swift
let a: Int? // Optional<Int>
let b: Int! // ImplicitlyUnwrappedOptional<Int>
```

## Optional<Wrapped>のアンラップ
- オプショナルバインディング<br>
Optional<Wrapped>のWrapped型取り出し、定数に代入します。値がなかった場合はコードブロックの中がスルーされます。
```swift
let a: Int? = 0
if let b = a {
   print(b)
}
```
- オプショナルチェインニング<br>
Optional<Wrapped>の後ろに?をつけてWrapped型のメソッドを呼び出します。チェインの中でnilが返った場合は結果がnilになります。
```swift
let a: a String? = "Hello"
print(a?.length)
```

- guard文<br>
条件式が真出ないときelse節の中が実行されます。else節の中では現在のスコープから退出する処理を記述しなければなりません。
```swift
guard 条件式　else {
    処理
    スコープからの退出処理(returnなど)
}
```

- 強制アンラップ<br>
Optional<Wrapped>のWrapped型取り出します。値がなかった場合は実行時エラーになります。

```swift
let a: Int? = 0
let b: Int? = 1
a! + b!
```

- ??演算子<br>
Optional<Wrapped>のWrapped型を強制的に取り出します。値がなかった場合は右辺の値がセットされます。
```swift
let a: Int? = 0
print(a ?? 0)
```
