<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新規会員登録 - 図書館管理システム</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム</h1>
    </header>
    <jsp:include page="/navigate.jsp" />
    <main>
        <div>
            <h2>新規会員登録</h2>
            <p>以下のフォームに必要な情報を入力してください。</p>
            
            <form action="/tuikaensyu/BooksManagementServlet" method="post">
                名前：<br>
                <input type="text" name="name" placeholder="名前を入力してください" autocomplete="off" required><br>
                郵便番号：<br>
                <input type="text" name="postal_code" placeholder="郵便番号を入力してください(半角ハイフンなし)" autocomplete="off" required><br>
                住所：<br>
                <input type="text" name="address" placeholder="住所を入力してください" required><br>
                電話番号：<br>
                <input type="text" name="phone_number" placeholder="電話番号を入力してください(半角ハイフンなし)" autocomplete="off" required><br>
                メールアドレス：<br>
                <input type="email" name="email" placeholder="メールアドレスを入力してください" autocomplete="off" required><br>
                生年月日：<br>
                <input type="date" name="birthdate" autocomplete="off" required><br>
                パスワード：<br>
                <input type="password" name="password" placeholder="パスワードを入力してください" autocomplete="off" required><br>
                パスワード確認：<br>
                <input type="password" name="confirm_password" placeholder="パスワードを再入力してください" autocomplete="off" required><br>
                <br>
                <button>登録</button><br>
                <input type="hidden" name="TF" value="False">
                <input type="hidden" name="action" value="add">
            </form>

            <p>すでにアカウントをお持ちの場合は、<a href="BooksManagementServlet?page=login">こちら</a>からログインしてください。</p>
        </div>
    </main>
    <jsp:include page="/footer.jsp" />
</body>
</html>

