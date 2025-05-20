このプログラムを動かすにはpostgreSQL環境でユーザとデータベースとテーブルを作成する必要があります。説明はワークスペースからサーバを起動しWeb表示ができる環境があることを前提として説明しています。

STEP1

=> tuikaensyu-gitのフォルダのパスのところにcmdと打ち込む
![alt text](image.png)

STEP2\n
=> 立ち上がったコマンドプロンプトで以下の実行コマンドを打ちこむ

コマンド：psql -U postgres -f library_management.sql

STEP3\n
=> postgresのパスワードを打ち込む

STEP4\n
=> 任意のワークスペースに新規から動的プロジェクトを作成する

STEP5\n
=> ファイルの新規から動的Webプロジェクトを選択し、「tuikaensyu」として作成する

STEP6\n
=> 作成したフォルダ内にtuikaensyu-git直下のフォルダとファイルをすべてコピーする

STEP7\n
=> サーバーを立ち上げて下記アドレスにアクセスし接続を確認する
アドレス：http://localhost:8080/tuikaensyu/BooksManagementServlet
