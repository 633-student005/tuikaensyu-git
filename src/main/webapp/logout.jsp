<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>図書館管理システム - ログアウトページ</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム＜ログアウトページ＞</h1>
    </header>
    <jsp:include page="/navigate.jsp" />
    <main>
		<h2>ログアウトしました。</h2>
		<p><a href="BooksManagementServlet?page=toppage">トップページへ戻る</a></p>
    </main>
    <jsp:include page="/footer.jsp" />
</html>