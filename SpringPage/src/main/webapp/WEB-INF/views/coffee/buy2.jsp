<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">

<!-- bootstrap CSS : 4.2.1 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- jQuery : 3.3.1 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- bootstrap JS : 4.2.1 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	
<!-- AngularJS : 1.7.6 -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular.min.js"></script>	

<style>
img.coffeePic:hover { 
	opacity: 0.7; 
	filter: alpha(opacity=100);  
}
</style>
</head>
<body>
<div>
	<header>
			<nav id="menu1">
				<ul>
					<li><c:if
							test="${not empty pageContext.request.userPrincipal.name}">
					    ${pageContext.request.userPrincipal.name} 님 환영합니다.
				<%-- <input type="button" value="로그아웃"
	   				   onclick="location.href='${pageContext.request.contextPath}/logoutProc'" />	 --%>
							<a class="style1"
								href="${pageContext.request.contextPath}/logoutProc">로그아웃</a>
						</c:if></li>
					<c:if test="${empty pageContext.request.userPrincipal.name}">
						<li><a class="style1"
							href="${pageContext.request.contextPath}/join">회원가입</a></li>
						<li><a class="style1"
							href="${pageContext.request.contextPath}/login">로그인</a></li>
					</c:if>
					<li><a class="style1"
						href="${pageContext.request.contextPath}/coffee/cartAction">장바구니</a></li>
					<li><a class="style1"
						href="${pageContext.request.contextPath}/secured/user/userview?username=${pageContext.request.userPrincipal.name}">마이페이지</a></li>
					<li><c:if
							test="${pageContext.request.userPrincipal.name == 'do5541hyun'}">
							<a class="style1"
								href="${pageContext.request.contextPath}/admin/home">관리자 페이지</a>
						</c:if>
					<li>
				</ul>
			</nav>
			<form id="search" action="search.php" method="post">
				<input type="text" title="검색"> <input type="submit"
					value="검색">
			</form>
			<div id="title_pic">
				<a href="${pageContext.request.contextPath}/home"> <img
					src="${pageContext.request.contextPath}/pic/title_pic.jpg"
					width="220" height="83" usemap="coffee_fifle">
				</a>
			</div>
		</header>
		<nav id="menu2">
			<ul>
				<li><a class="style2"
					href="${pageContext.request.contextPath}/notice/noticeList.do/1">공지사항</a></li>
				<li><a class="style2"
					href="${pageContext.request.contextPath}/coffee/buy">로스팅원두</a></li>
				<li><a class="style2"
					href="${pageContext.request.contextPath}/coffee/buy2">더치커피</a></li>
				<li><a class="style2"
					href="${pageContext.request.contextPath}/coffee/buy3">이벤트</a></li>
				<li><a class="style2"
					href="${pageContext.request.contextPath}/secured/board/boardList.do/1">상품후기</a></li>
			</ul>
		</nav>
	<section>
		<div>
			<img src="${pageContext.request.contextPath}/pic/coffee_section2.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	<h6>더치커피</h6>
	<hr>
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=10">
		<img src="${pageContext.request.contextPath}/pic/dutch_01.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
		<p><fmt:formatNumber type="number" value="22000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=10">산타 클라라 (PET)</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=11">
		<img src="${pageContext.request.contextPath}/pic/dutch_02.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="22000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=11">수프리모 메델린 (PET)</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=12">
		<img src="${pageContext.request.contextPath}/pic/dutch_03.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="22000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=12">파젠다 산타 루시아 (PET)</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=13">
		<img src="${pageContext.request.contextPath}/pic/dutch_04.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="22000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=13">수마트라 만델링 (PET)</a>
	 	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=14">
		<img src="${pageContext.request.contextPath}/pic/dutch_05.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="22000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=14">이르가체페(PET)</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=15">
		<img src="${pageContext.request.contextPath}/pic/dutch_06.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="6500"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=15">비비드 더치커피 250ml</a>
	 	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=16">
		<img src="${pageContext.request.contextPath}/pic/dutch_07.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="26000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=16">수마트라 만델링</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=17">
		<img src="${pageContext.request.contextPath}/pic/dutch_08.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="26000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=17">파젠다 산타 루시아</a>
	 	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=18">
		<img src="${pageContext.request.contextPath}/pic/dutch_09.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="26000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=18">수프리모 메델린</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=19">
		<img src="${pageContext.request.contextPath}/pic/dutch_10.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="26000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=19">산타 클라라</a>
	  	</p>
	  </div>
	  
	  <div class = "pic">
	  <a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=20">
		<img src="${pageContext.request.contextPath}/pic/dutch_11.jpg" class="coffeePic"
			width="220" height="230">
	  </a>
			<p><fmt:formatNumber type="number" value="26000"/>원</p>
		<p>
		<a class = "product_name" href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=20">이르가체페</a>
	 	 </p>
	  </div>
	  
	</article>
	<aside>
	
	</aside>
	<footer>
	<hr>
	
	</footer>
</div>	
</body>
</html>