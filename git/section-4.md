# Section-4. Gitの応用-1

## 4-1 作業の巻き戻し

gitで作業を行っている時に、特定のコミットまで状態を巻き戻したい場合があります。  
これはgit resetで実現できます。resetにはsoft, mixed, hardなどのオプションがあり、  
それぞれ現在の編集に与える影響が異なるため、それぞれについて見て行きたいと思います。  
まずは、ワーキングディレクトリ・ステージングの状態が異なる状態にします。  

```
$ vi sample.txt // 何らかの変更を加える
$ git add sample.txt // ステージングに変更をaddする
$ vi sample.txt // 何らかの変更を加える ← この時点でワーキングディレクトリとステージングが異なる状態になる。  
```

- git reset --soft HEAD~"戻したい数" or "コミットのハッシュ値"

HEAD(最新のコミットの位置)のみ戻し、現在行っている変更は残す。

```
$ git reset HEAD~1 // 一つ前のコミットに戻す
$ git log // 最新のコミットがなくなり、HEADが１つ前のコミットになっている
$ git status // なくなったコミットで行った変更がステージングに追加されている
```

- git reset --mixed HEAD~"戻したい数" or "コミットのハッシュ値"

HEAD(最新のコミットの位置)を戻し、ステージングに上がっている変更を、modified状態に戻す。  

```
$ git reset --soft HEAD~1 // 一つ前のコミットに戻す
$ git log // 最新のコミットがなくなり、HEADが１つ前のコミットになっている
$ git status // なくなったコミットで行った変更も含めてUntracked files:に含まれている。
```

- git reset --hard HEAD~"戻したい数" or "コミットのハッシュ値"

HEAD(最新のコミットの位置)を戻し、ステージング・ワーキングディレクトリの状態を全て破棄する。  

いずれのにしても、git resetを行った場合は戻したコミットまでのコミットは全て消えていしまうため、注意が必要です。

```
$ git reset --soft HEAD~1 // 一つ前のコミットに戻す
$ git log // 最新のコミットがなくなり、HEADが１つ前のコミットになっている
$ git status // 全ての変更が取り消されている。
```

## 4-2 作業の改変

gitで作業をコミットした場合に、自分の作業をやり直したい場面は多々あります。  
(コミットメッセージを間違えた、余計なファイルまでコミットに含めてしまったなど)  
作業をやり直したい場合にはいくつか方法があります。  

### ・直近のコミットを変更する  

git commit --amendを行うことで直前のコミットを現在のステージングの変更を組み込んだコミットに置き換えることができます。  

```
$ vi sample.txt // 何らかの変更を加える
$ git add sample.txt
$ git commit -m "sample.txtを変更"
$ git log -n 1
$ touch sample-2.txt
$ git add sample-2.txt
$ git commit --amend // 直前のコミットがsample-2.txtが含まれたコミットに置き換わる。
```

git commit --amend -m "コミットメッセージ"でコミットメッセージの編集を省略できます。  

### ・直近のコミット以前のコミットを修正する  

git rebase -i HEAD~"遡りたいコミット数"を行うことで、さらに遡ったコミットを変更することができます。  

```
$ git rebase -i HEAD~2
// ここでeditorが開くので、変更したいコミットの先頭をpickからeditに変更する(コミットの表示順に注意)
// 順番を入れ替えたり、削除もできる
// squashを指定することで、直前のコミットとひとまとめにできる。
Stopped at f24e309...  masterでの変更
You can amend the commit now, with

  git commit --amend 

Once you are satisfied with your changes, run

  git rebase --continue
$ git commit --amend -m "コミットメッセージを修正" // editにしたコミットまで戻るため、--amendで変更を加える。
$ git rebase --continue // --continueを行うと次のeditに指定したコミットに進む
```

また、コミットを分割することもでき、分割したいコミットで一旦git resetを行ってコミットを取り消した後、  
改めてコミットを行う形になります。

※ 注意) 最後のcontinueを行う前に何らかの操作を行うと、うまくいかなくなります。

注意) この操作はrebaseです。遡った分のコミットは編集していないものもすべて作りかえられます。  

この節で紹介した作業はすべてローカルリポジトリでのみ行ってください。  
一旦リモートリポジトリに上げてしまったコミットに適用すると、他人の作業に支障が出たり、混乱を招きます。  
ローカルリポジトリのコミットを整理にのみ利用するようにしましょう。  

### 4-3 作業を取り消す

一度コミットした内容を取り消すコミットをgit revertで作成することもできます。  
git resetやgit rebaseでもコミットを取り消すことは可能ですが、commitが残らないため危険です。  
git revertであれば、取り消した内容も残るため安全であり、リモートにプッシュしても問題ありません。  

```
$ vi sample.txt // 何らかの変更を加える。
$ git add sample.txt
$ git commit -m "sample.txtの修正"
$ git revert HEAD // 直前のコミットをrevert
$ git log -n 2
commit 89a8b343c3f7ab1630000e5d843134841e00b9dc (HEAD -> master)
Author: stone-shun-oyama <s.oyama@stonesystem.co.jp>
Date:   Thu May 17 09:36:20 2018 +0900

    Revert "sample.txtの修正"

    This reverts commit e077fa9428b7af6688df81269955892616d1ca3b.

commit e077fa9428b7af6688df81269955892616d1ca3b
Author: stone-shun-oyama <s.oyama@stonesystem.co.jp>
Date:   Thu May 17 09:36:07 2018 +0900

    sample.txtの修正
```

作業を進めて行く中でmergeをrevertしたい場合もありますが、通常のコミットをrevertするのとは若干方法が異なります。  
これはmergeを打ち消した場合に親コミットが２つあるため、どちらが正しいコミットであるかgitが判断できないためです。  
revertする際-mオプションをつけると親を指定できます。  

```
$ git checkout dev
$ vi sample.txt
$ git add sample.txt
$ git commit -m "sample.txtの編集"
$ git checkout master
$ git merge dev
$ git revert -m 1 HEAD // 1: master,2: dev
```