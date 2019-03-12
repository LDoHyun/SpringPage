<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>403 patch</title>
<script>
	window.onload=function() {
		
		alert("보안화로 인해 JSP 페이지에 직접 접근할 수 없습니다. \n홈페이지로 이동하겠습니다.");
	
		setTimeout(function() {
			location.href="${pageContext.request.contextPath}";
		}, 100)
	}
</script>
</head>
<body>

</body>
</html>