# Section-2. Gitの基本

## 2-1 Gitの全体像

改めてGitの全体像を見てみましょう。

![image2-1.png](images/image2-1.png "gitの全体像")

### ・リモートリポジトリ

サーバーにあるリポジトリ。ファイルの履歴を管理し、開発メンバーで共有して開発を進めたり、成果物を公開する。  

### ・ローカルリポジトリ

自分のPCにあるリポジトリ。リモートリポジトリと同期をとったり、自分の作業したファイルの履歴を管理する。  

### ・オブジェクト格納領域

ファイルに対する変更(コミット)やその履歴、変更に関する様々な情報を格納している場所。  

### ・インデックス(ステージングエリア)

ある瞬間のリポジトリ全体の情報が記録されたバイナリデータ(スナップショット)を保存する場所。  

### ・ワーキングエリア

gitで管理されているディレクトリ  

## 2-2 gitのファイル管理方法

gitでは以下のような手順でファイルが管理されています。  

1. ワーキングエリアの内容を変更する。

2. ワーキングエリアの変更内容を意味のあるまとまりで、インデックスに保存する。(*ステージ*)

3. インデックスの内容をオブジェクト格納領域へ保存する。(*コミット*)

4. ローカルリポジトリとリモートリポジトリに反映。(*プッシュ*)

また、リポジトリの変更履歴は*ブランチ(branch: 枝)*と呼ばれる仕組みによって、分岐されています。  
これを利用することによって、各変更内容ごとに別々に作業を行うことができます。(※詳しくはSection3で取り扱います。)
初めてコミットを行った際に、masterというブランチが作成されます。  

![image2-2.png](images/image2-2.png "ブランチのイメージ")

この後の節で行う作業は、masterというブランチ上で行っているんだな、ということを頭の片隅に入れておいてください。  

## 2-3 gitの基本操作

それでは実際にgitを操作してみましょう。  
まずは、ファイルを作成します。  

```
$ touch sample.txt // sample.txtの作成
```

この時点で一度リポジトリの状態を見てみましょう。  
git statusコマンドでリポジトリの状態を確認することができます。  

```
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	sample.txt

nothing added to commit but untracked files present (use "git add" to track)
```

Untracked filesにsample.txtが含まれています。  
gitでは各ファイルが管理されているかどうかを示すために、管理されているファイルをTracked, 管理されていないファイルをUntrackedという状態に分けています。  
はじめにGitでリポジトリを作った際に、そのディレクトリに含まれているファイルはTrackedの状態になっていますが、  
その後新しく作成したファイルに関しては、Untrackedの状態になります。  

git addコマンドでファイルをTracked状態にし、インデックスにステージすることができます。  

```
$ git add sample.txt // sample.txtをステージ
```

もう一度git statusを行ってみましょう.

```
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   sample.txt
```

先ほどのメッセージが消え、新たなメッセージが表示されました。  
一度ステージしたファイルをアンステージしたい場合は、  
git checkoutコマンドで現在のインデックスの変更をワーキングエリアにコピーし、  
git resetコマンドでインデックスの変更を破棄する必要があります。  

```
$ git checkout sample.txt // インデックスのsample.txtの変更をワーキングエリアにコピー
$ git status // この時点でメッセージに変化はない
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   sample.txt


$ git reset sample.txt // インデックスのsample.txtの変更を破棄
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	sample.txt

nothing added to commit but untracked files present (use "git add" to track)
```

次にインデックスに上げた変更をコミットしてローカルリポジトリの変更履歴に加えるところまでやってみましょう。  
再度git addコマンドを実行し、git commitコマンドを実行します。  

インデックスの状態をコミットする際には必ず、どういった変更内容かを記述した*コミットメッセージ*を添えなければなりません。  
git commitを実行すると、テキストエディタ(デフォルトはvim)が開くので、適切なコミットメッセージをつけましょう。  
このファイルを編集せずに閉じると、コミットは行われません。  

```
$ git add sample.txt
$ git commit // テキストエディタ(デフォルトはvim)が開き、コミットメッセージを編集する
$ git status
On branch master
nothing to commit, working tree clean
```

git statusでリポジトリの状態を確認すると、インデックスに上がった変更がなくなりcleanな状態となっています。  
コミットの履歴はgit logコマンドを用いることで確認することができます。  

```
$ git log
commit 91c568c3b8223a1a18a9a7a7be114300ad5a686e (HEAD -> master)
Author: stone-shun-oyama <s.oyama@stonesystem.co.jp>
Date:   Mon May 18 11:47:34 2018 +0900

    sample.txtの編集
```

ここまでで、ローカルリポジトリにディレクトリの変更履歴を保存することができました。  
あとはこの変更をリモートリポジトリにプッシュするだけです。  

```
$ git push origin master// originのmasterブランチ(ない場合は作成される)に反映
Password for 'https://stone-shun-oyama@bitbucket.org': // パスワードを求められる。
Counting objects: 3, done.
Writing objects: 100% (3/3), 231 bytes | 115.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://bitbucket.org/stone-shun-oyama/git-training.git
 * [new branch]      master -> master
```

ローカルで行った変更をリモートリポジトリに反映することができました。  
ブラウザでBitbucketでも確認してみましょう。さきほど追加したsample.txtの追加コミットが表示されているはずです。  

![image2-3.png](images/image2-3.png "Bitbucketのコミット")

git push時に毎回origin masterをつけるのは面倒です。  
既存のローカルブランチをリモートにあるブランチの*追跡ブランチ*に設定することで、次回から指定しなくてもgit pushを行えるようになります。  

```
git push --set-upstream origin master // ローカルのmasterブランチをoriginのmasterブランチの追跡ブランチに設定する
```

ここまででgitのファイル管理における一連の操作が完了しました。  
Gitでは、このようにリポジトリに変更履歴を記録して行くことで開発を進めて行きます。  

## リモートリポジトリの変更の取得

実際の開発では、自分以外の変更以外にもリモートリポジトリに変更が加えられて行きます。  
こうした他の誰かがリモートにプッシュした変更を取り込むためには*プル*という操作を行います。  
また、リモートにまだ取り込んでいない変更がある場合は、プッシュできなくなります。  

まず、Bitbucketでsample.txtに変更を加えてコミットし、その後、ローカルリポジトリ内で新たに、sample-2を作成し、これをプッシュしてみます。  

```
--- Bitbucketでsample.txtに何らかの変更が加えられ、それがコミットされている状態 ---
$ touch sample-2.txt
$ git add sample-2.txt
$ git commit -m "sample-2.txtの追加" -- -mオプションでコミットメッセージを指定してコミット
$ git push // error
```

このままだとプッシュできないため、git pullコマンドを使ってリモートの変更を取得し、再度プッシュを試みます。

```
$ git pull // テキストエディタが開くため、保存して閉じる。
Merge made by the 'recursive' strategy.
 sample.txt | 1 +
 1 file changed, 1 insertion(+)
$ git push // 成功
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 547 bytes | 547.00 KiB/s, done.
Total 4 (delta 1), reused 0 (delta 0)
To https://bitbucket.org/stone-shun-oyama/git-training.git
   c69daf4..167be38  master -> master
```

※ リモートリポジトリとローカルリポジトリで同一ファイルの同じ箇所を変更していた場合、コンフリクト(conflict: 競合)が発生します。競合が発生した場合はこれを解消する必要がありますが、詳しくはSection3で取り扱います。

## ファイルの削除、パス変更

補足として追跡されているファイルの削除、改名、移動についてみて行きましょう。  

### ・ファイルの削除

インデックスとワーキングエリアの両方からファイルを削除したい時はgit rmコマンドを使います。  

```
$ rm sample.txt // 普通に削除
$ git status // インデックスには反映されていない
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	deleted:    sample.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ git checkout sample.txt // 一旦削除を取り消し
$ git rm sample.txt
$ git status // インデックスにも反映されている
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    sample.txt
$ git reset // すでにsample.txtはTracked状態のため、インデックスの変更だけ破棄される
$ git checkout smple.txt // 削除取り消し
``` 

### ・ファイルのパス変更

インデックスとワーキングエリアの両方のファイルパスを変更したいときはgit mvコマンドを使います。  
パスの変更は、一旦ファイルが削除され、再度ファイルが作り直されます。  

```
$ git mv sample.txt sample-1.txt
$ git status // インデックスにrenameが反映されている。
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	renamed:    sample.txt -> sample-1.txt
$ git reset
$ git status // sample.txtの削除、sample-1.txtの追加に分けられている。
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	deleted:    sample.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	sample-1.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

ここで、この変更を取り消すためには一度sample-1を削除し、sample.txtをgit checkoutする必要があります。  
普通に削除することも可能ですが、ファイルが多かった場合はいちいち削除して行くのは面倒です。  
未追跡のファイルをまとめて削除するgit clean -fコマンドを使ってみましょう。  

```
$ git clean -f // -fオプションをつけることで強制削除
$ git status // sample-1.txtの追加が破棄されている
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	deleted:    sample.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ git checkout sample.txt
```

## コマンドのおさらい

ここまでのコマンドのおさらいをしてみましょう。  

```
git init // リポジトリの作成
git clone <url> // リモートリポジトリのクローン
git remote add <alias> <url> //  リモートリポジトリの登録
git config // gitの共通情報設定
git add <ファイル名> // ファイルをインデックスに追加
git status // 現在のローカルリポジトリの状態を表示
git checkout <ファイル名> // インデックス上のファイルの変更内容をワーキングエリアにコピー
git reset <ファイル名> // インデックス上のファイルの変更内容を破棄
git commit // インデックスの内容をコミット
git log // コミット履歴の表示
git push // リモートリポジトリのブランチにローカルリポジトリのブランチの変更内容をプッシュ
git pull // リモートリポジトリのブランチの変更をローカルリポジトリのブランチに取り込む
git rm <ファイル名> // インデックス・ワーキングエリアからファイルの削除
git mv <ファイル名> // インデックス・ワーキングエリアのファイルのパス変更
git clean -f // 未追跡ファイルの強制削除
```

これらのコマンドを用いることでgitの基本的な操作は可能になるはずです。  
コマンドが多くて大変かもしれませんが、徐々に覚えて行きましょう。  

### 補足)

また、プッシュ時に毎回passwordを入力するのも面倒です。  
.git/configの
```
[remote "origin"]
        url = https://username@bitbucket.org/username/repositoryname.git
```
を
```
[remote "origin"]
        url = https://username:password@bitbucket.org/username/repositoryname.git
```
に変更することでpasswordを聞かれないようにできます。  

パスワードに特殊文字が含まれている場合はエンコードが必要  
<https://fabianlee.org/2016/09/07/git-calling-git-clone-using-password-with-special-character/>
