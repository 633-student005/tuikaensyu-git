<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>図書館管理システム - 貸出可能資料一覧ページ</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム＜貸出可能資料一覧ページ＞</h1>
    </header>
    <jsp:include page="/navigate.jsp" />
    <main>
        <h2>貸出可能資料一覧</h2>
        <% for (int i = 0;i<10;i++){ %>
        <p>・本の詳細</p>
        <% } %>
<!--        <a href="login.jsp" class="btn">ログイン</a>-->
    </main>
    <jsp:include page="/footer.jsp" />
</body>
</html>