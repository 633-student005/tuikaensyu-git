<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>図書館管理システム - マイページ</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム＜マイページ＞</h1>
    </header>
	<jsp:include page="/navigate_mypage.jsp" />
    <main>
		<h2>${sessionScope.login_info.name}さん<br>ようこそ、図書館管理システムへ！</h2>

        <p>図書ニュース</p>
    </main>
    <jsp:include page="/footer_mypage.jsp" />
</body>
</html>