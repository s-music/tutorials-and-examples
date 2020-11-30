# よく使うGitコマンドチートシート

## git init

```
$ git init // 現在のディレクトリをローカルリポジトリ化
```

## git clone

```
git clone <url> // リモートリポジトリをクローン
```

## git remote

```
git remote add <alias> <url> // リモートリポジトリのエイリアスを設定
git remote remove // リモートリポジトリのエイリアス削除
```

## git config

```
$ git config --list // 設定一覧表示
$ git config <key>(user.email, user.passwordなど)
$ git config unset <key> // 設定の削除
```

## git add

```
$ git add <filename1> <filename1> ... // 指定したファイルをステージ
$ git add <directoryname> // 指定したディレクトリ以下の全てのファイルの変更をadd
$ git add . // カレントディレクトリ以下の全てのファイルをadd
$ git -A(--all) // リポジトリ内の全ての変更をadd
```

## git status

```
$ git status // 現在のローカルリポジトリの内容を表示
$ git status -s(--short) // 短縮した形で表示
```

## git checkout

```
$ git checkout <filename> // インデックスの変更をワーキングエリアにコピー
$ git checkout -b <branchname> // branchを新たに作成し、checkout
```

## git reset

```
git reset <filename> // インデックスの指定したファイルの状態をリセット
git reset --soft // HEAD(ブランチの先頭)の移動。リセットした分の変更はインデックスに退避
git reset --mixed // HEAD(ブランチの先頭)の移動。インデックスもリセットし、リセットした分の変更はワーキングエリアに退避
git reset --hard // HEAD(ブランチの先頭)の移動。インデックス、ワーキングエリアの内容もリセット
```

## git commit

```
$ git commit // キストエディタが開き、コミットメッセージの編集を行う。保存しなければコミットされない。
$ git commit -m <"comment"> // コメントをつけて即コミット
```

## git log

```
$ git log // コミット履歴を表示
$ git log -n <num> // 最新のコミットから表示数分表示
$ git log -a // 全ブランチ
$ git log --graph // グラフィカルなログ表示
```

## git push

```
$ git push -u <remote branch> // 現在のブランチの追跡ブランチを指定したリモートブランチに指定(次回のpushからしてせずともそのブランチに対してpushを行う)
```

## git pull

```
$ git pull リモートブランチ名:ローカルブランチ名 // リモートブランチを指定した名前でローカルにコピー
```

## git rm

```
$ git rm <filename> // 指定したファイルを削除し、追跡ファイルからも外す
$ git rm -r <directoryname> // 指定したディレクトリを削除し、それに含まれるファイルを追跡ファイルから外す
$ git rm --cached <filename> // ファイルは削除せず、追跡ファイルから外す
```

## git mv

```
$ git mv <filename> <new filename> // フィアルのパスを変更
```

## git clean

```
$ git clean -d // ディレクトリも削除対象に含める
$ git clean -f // 強制的にファイルを削除する
$ git clean -i // 対話的にファイルを削除する
```

## git branch

```
$ git branch -a // リモートのブランチを含んだ全てのブランチを表示
$ git branch -r // リモートのブランチを表示
$ git branch -d <branchname> // 指定したブランチを削除
$ git branch - m <old branchname> <new branchname> // ブランチの改名
$ git branch
```

## git merge

```
$ git merge <branchname-a> <branchname-b> // aにbをmerge
```

## git rebase

```
$ git rebase <branchname-a> <branchname-b> // aにbをrebase
$ git rebase -i // 指定したコミッットまで遡ってコミットを編集。詳しいオプションは下記を参照
$ git rebase --continue // rebaseの続行
$ git rebase --skip // rebaseのスキップ
$ git rebase --abort // rebaseの強制終了。rebase実行前の状態に戻る
$ git rebase onto <branchname-a> <branchname-b> <branchname-c> // bから派生しているcをaにrebase
```

## git revert

```
$ git revert <commit hash> // 指定したコミットを打ち消すコミットの作成
$ git revert <commit hash> -e // コミットメッセージを編集してrevert
$ git revert -m <parent number> <commit hash> // mergeをのrevert。どちらの親の状態に戻すのかを指定する
```

## git stash

```
$ git stash save // 変更の退避
$ git stash list // 退避した変更のリストを表示
$ git stash show <stashname> // 変更に含まれるファイルを表示
$ git stash apply <stashname> // 退避した変更を適用
$ git stash drop <stashname> // 退避した変更の削除
$ git stash clear // 退避した変更の全削除
```

## 補足)

### git status -sの読み方

|  フラグ | ファイルの状態 |
|  ----// | ----// |
|  M | 変更された |
|  A | 追加された |
|  D | 削除された |
|  R | Renameされた |
|  C | コピーされた |
|  U | 変更されたがマージされていない |
|  ?? | インデックスもしくはワーキングツリーに追加されていない |

### git ignoreの書き方

```
# コメント
*.ext // 指定した拡張子のファイルを無視
<directoryname>/ // 指定したディレクトリ下のファイルを無視
!<pattern> // 特定パターンを無視しない
/<filename> // .gitignoreと同一ディレクトリ下の特定ファイルを無視
<filename> // ワーキングディレクトリ上の特定ファイルを無視
```

### git rebase -iコマンドのオプション

|  オプション | 動作 |
|  ----// | ----// |
|  pick | 何もしない(スキップされる) |
|  reword | コミットメッセージのみ修正(メッセージの部分を修正する) |
|  edit | このコミットの時点で一時停止 |
|  squash | １つ前のコミットに統合し、コミットメッセージを編集 |
|  fixed | 1つ前のコミットに統合し、１つ前のコミットメッセージを使用する |
|  U | 変更されたがマージされていない |
|  ?? | インデックスもしくはワーキングツリーに追加されていない |