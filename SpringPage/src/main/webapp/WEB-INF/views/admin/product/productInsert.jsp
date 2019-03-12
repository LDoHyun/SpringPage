<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  
<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">  
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script>
$(document).ready(function() {
	$("#coffee_kind").val().replace(/\s/g, "");
	$("#coffee_kg").val().replace(/\s/g, "");
	
	$("#order").click(function() {
		
		if ($.trim($("#coffee_kind").val()) == "" ||
			$.trim($("#coffee_kg").val()) == ""){
			
			alert("필수 옵션을 선택해주세요.");
		}
	});
});
</script>
<style>
.pic {
	background:gray;
	float: left;
	width:250px;
	height:280px;
	margin:5px 50px 30px 120px;
}
.right {
	position: relative;
    float: right;
    width: 500px;
    padding: 10px 50px 30px 10px;
}
table {
	border-collapse:collapse;
	border: 1px solid white;
	font-size:12px;
}
table td {
	border: 1px solid white;
	padding: 7px;
}
p {
	margin:5px;
}
.err
{
    font-size:12px;
    color:red;
}  
</style>
</head>
<body>
<div>
	<header>
	<nav id = "menu1">
	  <ul>
		<li>
			<c:if test="${not empty pageContext.request.userPrincipal.name}">
					   관리자 ${pageContext.request.userPrincipal.name} 님 환영합니다.
				<%-- <input type="button" value="로그아웃"
	   				   onclick="location.href='${pageContext.request.contextPath}/logoutProc'" />	 --%>	
	   			<a class="style1" href="${pageContext.request.contextPath}/logoutProc">로그아웃</a>	    
			</c:if>
		</li>
		<li><a class="style1" href="${pageContext.request.contextPath}/admin/user
									/userlistpaging?curPage=1">회원관리</a></li>
		<li><a class="style1" href="${pageContext.request.contextPath}/admin/product
									/productlist?curPage=1">상품관리</a></li>
	  </ul>
	</nav>
	<form id="search" action="search.php" method="post">
		<input type="text" title="검색">
		<input type="submit" value="검색">
	</form>
	<div id="title_pic">
			<a href="${pageContext.request.contextPath}/admin/home">
				<img src="${pageContext.request.contextPath}/pic/title_pic.jpg"
					 width="220" height="83" usemap="coffee_fifle">
			</a>
		</div>
	</header>
	<nav id = "menu2">
	  <ul>
		<li><a class="style2" href="#">회사소개</a></li>
		<li><a class="style2" href="#">공지사항</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy">로스팅원두</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy2">더치커피</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy3">이벤트</a></li>
		<li><a class="style2" href="#">상품후기</a></li>
	  </ul>
	</nav>
	<section>
		<div>
			<img src="${pageContext.request.contextPath}/pic/coffee_section4.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
		<p>상품설명</p>
		 <hr>
		 <div class="pic"></div>
		 <form:form commandName="productVO"
		 			mothod = "POST"
		 			action = "insertProductAction">
		 <table>
		 <!-- <img src="**/pic/coffee1.jpg"> -->
		 <tr>
		 	<td>상품 이름</td>
		 	<td>
		 		<form:input path="pname" name="pname" 
		 					maxlength="40" size="15" />
		 		<form:errors path="pname" cssClass="err" /><br>
		 	</td>
		 </tr>
		 <tr>		 
			<td>가격</td>
			<td>
				<form:input path="price" name="price" 
							maxlength="5" size="15" />
				<form:errors path="price" cssClass="err" /><br>
			</td>
		 </tr>
		 <tr>
			<td>원산지</td>
			<td>
				<form:input path="country" name="country" 
							maxlength="20" size="15" />
				<form:errors path="country" cssClass="err" /><br>
			</td>
		 </tr>
		 <tr>
		 	<td>카테고리</td>
		 	<td>
		 	<select id="pkind" name="pkind">
			 	<option value="" selected>----------------</option>
			 	<option value="coffee">로스팅원두</option>
			 	<option value="dutch_coffee">더치커피</option>
			 	<option value="event">이벤트</option>
			</select>
		 	<form:errors path="pkind" cssClass="err" /><br>
		 	</td>
		 </tr>
		 <tr>
		 	<td>상품 사진</td>
		 	<td>
		 	
		 	</td>
		 </tr>
    	 </table>
    	 <hr>
	    	 <input type="submit" value="상품등록">
	    	 <input type="button" id="insert_cencel" name="insert_cencel" value="취소"
	    	 		onclick="location.href='${pageContext.request.contextPath}/product/productlist?curPage=1'">
	   </form:form>
	   
	</article>
	<aside>
	
	</aside>
	<footer>
	
	</footer>
</div>	
</body>
</html>