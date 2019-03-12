<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원관리</title>

<link rel="stylesheet" href="<c:url value='/css/productpage.css' />">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

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
회원수:${productVO.size()}<br>
<div>
	<header>
	<nav id = "menu1">
	  <ul>
		<li><a class="style1" href="#">회원가입</a></li>
		<li><a class="style1" href="#">로그인</a></li>
		<li><a class="style1" href="#">장바구니</a></li>
		<li><a class="style1" href="#">마이페이지</a></li>
	  </ul>
	</nav>
	<form id="search" action="search.php" method="post">
		<input type="text" title="검색">
		<input type="submit" value="검색">
	</form>
	<div id="title_pic">
			<a href="${pageContext.request.contextPath}/home">
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
	
	</section>
	<article>
		
    <!-- 페이지 관련 변수들 -->
	<div>
	       현재 페이지(curPage) : <b>${pagingVO.curPage}</b><br>
	        총 페이지(totPage) : <b>${pagingVO.totPage}</b><br>
	        페이지당 행수(rowPerPage) : <b>${pagingVO.rowPerPage}</b><br>
	        시작 페이지(startPage) : <b>${pagingVO.startPage}</b><br>
	        마지막 페이지(endPage) : <b>${pagingVO.endPage}</b><br>
	        이전 페이지(prePage) : <b>${pagingVO.prePage}</b><br>
	        다음 페이지(nextPage) : <b>${pagingVO.nextPage}</b><br>
	        총 인원수(pnum) : <b>${pnum}</b><br>
    </div>
    <%-- 회원 정보가 없을 경우 --%>
   	 <c:if test="${productVO.size() == 0}">
        <div style="text-align:center; font-size:12px">
         	 회원 정보 없음
        </div>
     </c:if>
     
    <h4>회원관리</h4>
    <br>
	<%-- <form:form id="userlistpaging" action="userPaging" modelAttribute="userVO" method="POST"> --%>
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
				 <a href="${pageContext.request.contextPath}/product/productForm/${product.pnum}">
				 		  ${product.pname}</a>
			 </td>
			 <td align="center">${product.pkind}</td>
			 <td align="center">${product.price}원</td>
			 <td align="center">${product.country}</td>
		 </tr>
	 </c:forEach> 
	</table>
	</c:if>
	<%-- </form:form> --%>
    <br> 
    <!-------- paging 시작 -------->
 
    <%@ include file="paging.jsp" %> 
    
    <!-------- paging 끝 --------->

    <div id="search_pnl" class="form-group">
	
		<form class="form-inline" name="productsearch" value="pname"
			  action="productsearch" method="post">
			
			<input type="text"
				   id="searchWord" name="searchWord" size="20" />
			
			<input type="submit" class="btn btn-primary mb-2" value="검색">
			
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