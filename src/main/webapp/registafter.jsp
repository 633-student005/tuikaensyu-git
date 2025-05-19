<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>図書館管理システム - トップページ</title>
    <!-- 外部CSSファイルを読み込む -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>図書館管理システム＜登録完了ページ＞</h1>
    </header>
	<jsp:include page="/navigate.jsp" />
    <main>
    	<h2>登録完了しました。</h2>
    	<table border="1">
		<tr><td>ID</td><td>name</td><td>管理者権限</td></tr>
       	<c:forEach items="${requestScope.login_info}" var="info">
			<tr><td>${info.members_id}</td><td>${info.name}</td><td>${info.admin_flag ? "有り" : "無し"}</td></tr>
		</c:forEach>
		</table>
        <a href="BooksManagementServlet?page=login">ログイン</a>
    </main>
    <jsp:include page="/footer.jsp" />
</body>
</html>