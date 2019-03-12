<%@ page isErrorPage="true" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>image error patch</title>
<script>
	window.onload=function() {
		
		alert("업로드한 파일이 그림 파일이 아닙니다.");
		
		setTimeout(function() {
			location.href= "${pageContext.request.contextPath}/product/productInsert"; // 페이지 이동
		}, 100);
	} //
</script>
</head>
<body>
</body>
</html>