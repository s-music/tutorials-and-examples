# Section-5. Gitの応用-2

### 5-1 作業の退避

あるブランチで作業中に何らかの理由で別の作業を中断せざるおえなくなった場合、  
コミットはしたくないが、行っていた作業を保存したい場合があります。  
そんな場合には、git stashが便利です。

```
$ vi sample.txt
$ git stash save  "edit sample.txt" // メッセージ付きで、インデックス・ワーキングディレクトリの作業内容を一時退避
stash@{0}: On master: edit sample.txt
$ git status
soyama:git-training stone$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)
$ git stash list -- stashに保存した内容の一覧表示
stash@{0}: On master: edit sample.txt
$ git stash apply stash@{0} --index // stashに退避した変更内容を適用(--indexをつけない場合、インデックスにあった変更もワーキングディレクトリに戻る)
$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   sample.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ git stash list -- 適用しても一時退避した内容は消えない
stash@{0}: On master: edit sample.txt
$ git stash drop stash@{0} // 退避していた内容を削除する
Dropped stash@{0} (69a1e848d423aa8fa592440c31759aabaa564a60)
```

stashは便利な反面、退避した変更箇所と同じ箇所を変更してしまうと、コンフリクトが起きるため注意が必要です。  

### 5-2 .gitignore

build targetなど開発に当たって共有する必要のないファイルがワーキングエリア内に含まれていることがあります。  
そういった場合にはgitに追跡させないように、.gitignoreというファイルに設定を記述することができます。  

無視したいファイルが存在するフォルダに.gitignoreというファイルを作成し、無視したいファイルの先頭に"/"を付与した形で指定します。  
指定したファイルがすでに追跡済みの場合は指定しても無視されないため、追跡ファイルから外す必要がある。  

```
$ vi sample.txt // 何らかの変更を加える
$ vi .gitignore // sample.txtを無視する
$ git rm --cached sample.txt// すでに追跡済みのため追跡ファイルから外す。
$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    sample.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore
$ echo "aaa" >> sample.txt // sample.txtの末尾にaaaという文字列を追加
$ git status // 変更が追跡されていない
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    sample.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore
$ rm .gitignore
$ git status // 変更が追跡されている。
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    sample.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	sample.txt
```

### 5-3 特定のコミットの取り込み

ある特定のブランチの特定のコミットのみを取り込みたい場合、git cherry-pickが使えます。  
devブランチにcheckoutし、以下のように3つのコミットを行ってみましょう。  

```
$ git checkout dev
$ touch sample-a.txt
$ git add .
$ git commit -m "sample-a.txtを追加" // 1
$ touch sample-b.txt
$ git add .
$ git commit -m "sample-b.txtを追加" // 2
$ touch sample-c.txt
$ git add .
$ git commit -m "sample-c.txtを追加" // 3
$ git log -n 3
```

ここでmasterブランチに1番のコミットを取り込んでみます。  

```
$ git checkout master 
$ git cherry-pick 657150d // 1番のコミットのID
[master dcdec22] sample-a.txtの追加
 Date: Mon May 21 11:03:22 2018 +0900
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 sample-a.txt
$ git log // コミット履歴にdcdec22が追加されている
```
