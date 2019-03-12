<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
	로그아웃<br>
	${pageContext.request.userPrincipal.name}<br>
	<c:if test="${error eq 'true'}">
		${msg}
	</c:if>
	<script>
		alert("로그아웃 되었습니다.");
		location.href="home";
	</script>
</body>
</html>