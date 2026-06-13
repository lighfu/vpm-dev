# Ajisaiflow VPM - Dev channel

AjisaiFlow パッケージの開発 (dev) チャンネル VPM listing。
dev パッケージの保管 (GitHub Releases) と listing 公開 (GitHub Pages) を兼ねる自己完結リポジトリ。

## VCC / ALCOM への追加

Add Repository に以下の Listing URL を貼り付ける:

    https://lighfu.github.io/vpm-dev/index.json

ランディングページ: https://lighfu.github.io/vpm-dev/

## チャンネル

- stable : https://lighfu.github.io/vpm/
- dev (this repo) : https://lighfu.github.io/vpm-dev/

## 仕組み

source.json が listing 設定 (githubRepos に自身を指定)。
.github/workflows/build-listing.yml が vrchat-community/package-list-action で
GitHub Releases を走査して index.json を生成し、Website/ テンプレートと共に GitHub Pages へ配信する。
release は release.py --channel dev が作成し、完了時に repository_dispatch (dev-release) で本 workflow を起動する。