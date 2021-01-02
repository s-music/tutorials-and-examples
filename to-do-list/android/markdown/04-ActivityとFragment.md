# ActivityとFragment

## アプリの基本要素

### Activity
Androidアプリを構成する基本要素の一つがActivityです。  
ActivityはMVCで言うところのコントローラークラスに相当する役割を果たします。  
アプリが起動するとまず起動イベントを受け取るように設定されたActivityが立ち上がります。  
みなさんがAndroidアプリで目にする画面の大元には必ずActivityがあり、制御しています。  
Activityだけでも画面を表示させることはできますが、基本的にはFragmentというコンポーネントを用いてActivity上で画面を表示させます。  

### Fragment
Fragmentは多くの場合複数のUIを伴ったレイアウトを持ち、実際のUI表示はActivity上でFragmentを利用することにより実現します。  
Activityを一つの画面と捉えた時、その中に１つまたは複数のFragmentを表示することが可能です。  
FragmentのライフサイクルはそのホストのActivityのライフサイクルの影響を受けます。  
Activityが破棄されれば、Fragmentも破棄されます。  

### Resource
各種静的ファイルを扱います。  
多言語に対応した文字列リソースやレイアウト定義などは主にResourceで管理します。
