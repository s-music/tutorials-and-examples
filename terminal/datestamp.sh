#! /bin/bash
# Usage:
#   /bin/bash timestamp.sh [file_path] [file_name]
# 
# Description:
#   カレントディレクトリ配下にディレクトリを作成し、その直下に現在時刻を記載したファイルを作成するスクリプト
# 
# Args:
#   file_path: 作成するファイルパス
#   file_name: 作成するファイル名

if [[ $# -lt 2 ]]; then
  echo "引数が足りません。"
  exit 1
fi

if [[ ! -e ./new_dir ]]; then
  mkdir -p $1
fi

pushd $1 > /dev/null
date > $2
cat $2
popd > /dev/null

ls -la $1/$2
