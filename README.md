# QiitaAPIを利用したビュワーアプリ

## WHAT

- QiitaのAPIを使用し、**Swift**のタグが付いた記事のみを取得する
- キーワードで検索ができる
  - 日本語検索の場合はエラーになるためパーセントエンコーディングしている
- セルをクリックすると、ブラウザを起動することなく該当の記事がモーダルで開かれる

## Library

- Alamofire