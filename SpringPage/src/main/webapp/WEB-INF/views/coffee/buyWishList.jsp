<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
</script>
<body>
<div>
	<header>
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
			<img src="${pageContext.request.contextPath}/pic/coffee_section3.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	<c:if test="${users.size() == 0}">
        <div style="text-align:center; font-size:12px">
         	 회원 정보 없음
        </div>
     </c:if>
	<br>
		<h6>관심상품등록</h6>
		 <hr>
	<c:if test="${userNum != 0}">
	<table>
	 <tr>
	 	 <td align="center">상품선택</td>
		 <td align="center">이미지</td>
		 <td align="center">상품정보</td>
		 <td align="center">판매가</td>
		 <td align="center">배송비</td>
		 <td align="center">합계</td>
		 <td align="center">선택</td>
	 </tr>
     <hr>
	 <c:forEach items="${wishListVO}" var="wishList" varStatus="st">
		 <tr>
		 	 <td align="center">${wishList.pnum}</td>
		 	 <td align="center">
		 	 	<img src="${pageContext.request.contextPath}/pic/${wishList.pfile}.jpg"
		 	 		 width="50" height="50"></td>
			 <td align="center">${wishList.pname}<br>${wishList.country}</td>
			 <td align="center"><fmt:formatNumber type="number" value="${wishList.price}"/></td>
			 <td align="center"><fmt:formatNumber type="number" value="2500"/>원</td>
             <td align="center"><fmt:formatNumber type="number" value="${wishList.price + 2500}"/>원</td>
             <td align="center">
             <input type="button" value="주문하기" id="btnOrder" 
             		onclick="location.href='${pageContext.request.contextPath}/user/userUpdate?username=${user.username}'">
             <input type="button" value="장바구니담기" id="btnCart" 
             		onclick="location.href='${pageContext.request.contextPath}/user/userUpdate?username=${user.username}'">
             <input type="button" value="삭제" id="btnDelete" 
             		onclick="location.href='${pageContext.request.contextPath}/user/userUpdate?username=${user.username}'">
             </td>
		 </tr>
	 </c:forEach> 
	</table>
	</c:if>	 	
	</article>
	
</div>
</body>
</html>