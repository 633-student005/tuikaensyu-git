<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>図書館管理システム - ログインページ</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム＜ログインページ＞</h1>
    </header>
    <jsp:include page="/navigate.jsp" />
    <main>
        <div class="login-container">
            <h2>ログイン</h2>
            <p>ユーザー名とパスワードを入力してください。</p>
            
            <form action="/tuikaensyu/BooksManagementServlet" method="post">
				ユーザー名：<br>
                    <input type="text" name="email" placeholder="ユーザー名を入力" autocomplete="off" required><br>
				パスワード：<br>
                    <input type="password" name="password" placeholder="パスワードを入力" autocomplete="off" required><br>
                <br>
                <button>ログイン</button><br>
                <input type="hidden" name="action" value="login">
            </form>

            <p>アカウントをお持ちでない場合は、<a href="BooksManagementServlet?page=register">こちら</a>から新規登録してください。</p>
        </div>
    </main>
    <jsp:include page="/footer.jsp" />
</html>