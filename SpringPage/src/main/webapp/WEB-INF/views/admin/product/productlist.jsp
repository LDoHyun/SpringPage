<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원관리</title>

<link rel="stylesheet" href="<c:url value='/css/boardpage.css' />">
<!-- bootstrap CSS : 4.2.1 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- jQuery : 3.3.1 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- bootstrap JS : 4.2.1 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	
<!-- AngularJS : 1.7.6 -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular.min.js"></script>	

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script>
</script>
<style>
table {
	font-size: 11px; 
}
</style>
<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); // rollover-popup
    $('[data-toggle="popover"]').popover(); // click-popup
});
</script>
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
		<li><a class="style2" href="${pageContext.request.contextPath}/buy">로스팅원두</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/buy2">더치커피</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/buy3">이벤트</a></li>
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
		
    <!-- 페이지 관련 변수들 -->
	<%-- <div>
	        현재 페이지(curPage) : <b>${pagingVO.curPage}</b><br>
	        총 페이지(totPage) : <b>${pagingVO.totPage}</b><br>
	        페이지당 행수(rowPerPage) : <b>${pagingVO.rowPerPage}</b><br>
	        시작 페이지(startPage) : <b>${pagingVO.startPage}</b><br>
	        마지막 페이지(endPage) : <b>${pagingVO.endPage}</b><br>
	        이전 페이지(prePage) : <b>${pagingVO.prePage}</b><br>
	        다음 페이지(nextPage) : <b>${pagingVO.nextPage}</b><br>
	        총 인원수(pnum) : <b>${pnum}</b><br>
    </div> --%>
    
    <%-- 회원 정보가 없을 경우 --%>
   	 <c:if test="${ProductVO.size() == 0}">
        <div style="text-align:center; font-size:12px">
         	 상품 없음
        </div>
     </c:if>
     
    <br> 
    <h4>상품관리</h4>
	<%-- <form:form id="userlistpaging" action="userPaging" modelAttribute="userVO" method="POST">  --%>
	<c:if test="${pnum != 0}">
	<table>
	 <tr>
	 	 <td align="center">번호</td>
		 <td align="center">이름</td>
		 <td align="center">카테고리</td>
		 <td align="center">가격</td>
		 <td align="center">원산지</td>
	 </tr>
     <hr>
	 <c:forEach items="${productVO}" var="product" varStatus="st">
		 <tr>
		 	 <td align="center">${product.pnum}</td>
			 <td align="center">
				 <a href="${pageContext.request.contextPath}/admin/product/productUpdate?pnum=${product.pnum}">
				 		  ${product.pname}</a>
			 </td>
			 <td align="center">${product.pkind}</td>
			 <td align="center">${product.price}원</td>
			 <td align="center">${product.country}</td>
		 </tr>
	 </c:forEach> 
	</table>
	</c:if>
	<br>
	<%-- <form id="insertProduct" action="productInsert" method="post">  --%>
		<input type="button" id="product_btn" name="product_btn"
			   value="상품등록" onclick="location.href='${pageContext.request.contextPath}/admin/product/productInsert'"/>
	<%-- </form> --%>
	<%-- </form:form> --%>
    <br> 
    <!-------- paging 시작 -------->
 
    <%@ include file="paging.jsp" %> 
    
    <!-------- paging 끝 --------->

		</form>
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