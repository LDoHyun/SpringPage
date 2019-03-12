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
회원수:${users.size()}<br>
<div>
	<header>
			<nav id="menu1">
				<ul>
					<li>
						<c:if test="${not empty pageContext.request.userPrincipal.name}">
								   관리자 ${pageContext.request.userPrincipal.name} 님 환영합니다.
							<%-- <input type="button" value="로그아웃"
				   				   onclick="location.href='${pageContext.request.contextPath}/logoutProc'" />	 --%>	
				   			<a class="style1" href="${pageContext.request.contextPath}/logoutProc">로그아웃</a>	    
						</c:if>
					</li>
					<li><a class="style1" href="${pageContext.request.contextPath}/secured/home">회원페이지</a></li>
					<li><a class="style1" href="${pageContext.request.contextPath}/admin/user
												/userlistpaging?curPage=1">회원관리</a></li>
					<li><a class="style1" href="${pageContext.request.contextPath}/admin/product
												/productlist?curPage=1">상품관리</a></li>
					<li><a class="style1" href="${pageContext.request.contextPath}/admin/coffee/shopAdmin">상품배송</a></li>
				</ul>
			</nav>
			<form id="search" action="search.php" method="post">
				<input type="text" title="검색"> <input type="submit"
					value="검색">
			</form>
			<div id="title_pic">
				<a href="${pageContext.request.contextPath}/admin/home"> <img
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
		
    <!-- 페이지 관련 변수들 -->
	<%-- <div>
	        현재 페이지(curPage) : <b>${pagingVO.curPage}</b><br>
	        총 페이지(totPage) : <b>${pagingVO.totPage}</b><br>
	        페이지당 행수(rowPerPage) : <b>${pagingVO.rowPerPage}</b><br>
	        할당 인원수(members.size()) : <b>${users.size()}</b><br> 
	        시작 페이지(startPage) : <b>${pagingVO.startPage}</b><br>
	        마지막 페이지(endPage) : <b>${pagingVO.endPage}</b><br>
	        이전 페이지(prePage) : <b>${pagingVO.prePage}</b><br>
	        다음 페이지(nextPage) : <b>${pagingVO.nextPage}</b><br>
	        총 인원수(userNum) : <b>${userNum}</b><br>
    </div> --%>
    <%-- 회원 정보가 없을 경우 --%>
   	 <c:if test="${users.size() == 0}">
        <div style="text-align:center; font-size:12px">
         	 회원 정보 없음
        </div>
     </c:if>
     
    <br>
    <h4>회원관리</h4>
	<%-- <form:form id="userlistpaging" action="userPaging" modelAttribute="userVO" method="POST"> --%>
	<c:if test="${userNum != 0}">
	<table>
	 <tr>
	 	 <!-- <td align="center">번호</td> -->
		 <td align="center">아이디</td>
		 <td align="center">이름</td>
		 <td align="center">번호</td>
		 <td align="center">생년월일</td>
		 <td align="center">가입일</td>
	 </tr>
     <hr>
	 <c:forEach items="${users}" var="user" varStatus="st">
		 <tr>
		 	 <%-- <td align="center">${(pagingVO.curPage-1)*pagingVO.rowPerPage + st.count}</td> --%>
			 <td>${user.username}</td>
			 <td><a href="${pageContext.request.contextPath}/admin/user/userview?username=${user.username}">${user.name}</a></td>
			 <td> ${user.phone} - ${user.phone2} 
			 	- ${user.phone3}</td>
			 <td><fmt:formatDate value="${user.birthday}" 
			 				 	 pattern="yyyy년 MM월 dd일" /></td>
             <td><fmt:formatDate value="${user.joindate}" 
             					 pattern="yyyy년 MM월 dd일" /></td>
		 </tr>
	 </c:forEach> 
	</table>
	</c:if>
	<%-- </form:form> --%>
    <br> 
    <!-------- paging 시작 -------->
 
    <%@ include file="paging.jsp" %> 
    
    <!-------- paging 끝 --------->

    <%@ include file="search.jsp" %> 

	</article>
	<aside>
	
	</aside>
	<footer>
	<hr>
	
	</footer>
</div>
</body>
</html>