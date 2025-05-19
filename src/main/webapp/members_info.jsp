<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>図書館管理システム - 会員情報表示ページ</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム＜会員情報表示ページ＞</h1>
    </header>
	<jsp:include page="/navigate_mypage.jsp" />
    <main>
    	<h2>会員情報</h2>
    	<table border="1">
		<tr><td>ID</td><td>name</td><td>管理者権限</td></tr>
		<tr><td>${sessionScope.login_info.members_id}</td><td>${sessionScope.login_info.name}</td><td>${sessionScope.login_info.admin_flag ? "有り" : "無し"}</td></tr>

		</table>
    </main>
    <jsp:include page="/footer_mypage.jsp" />
</body>
</html>