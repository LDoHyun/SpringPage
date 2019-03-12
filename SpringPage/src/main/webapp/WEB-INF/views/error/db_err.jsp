<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>db_err</title>
<script>
	window.onload=function() {
		
		alert("회원가입에 실패했습니다.");
		
		setTimeout(function() {
			location.href= "${pageContext.request.contextPath}/login"; // 페이지 이동
		}, 100);
	}
</script>
</head>
<body>

</body>
</html>