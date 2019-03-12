<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품정보</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
$(document).ready(function(){
	
	//개별 체크박스 선택 시 
	$("input[id ^= check_]").click(function(e){
		var pnum = e.target.id.substring(6, e.target.id.length);
		/* alert("pnum:" + pnum); */
	});
	
	$('#button[id ^= btnDelete_]').click(function(){

		if(confirm("삭제하시겠습니까?")){
	         $("input[id ^= checkbox_]:checked").each(function(){
	        	 
	        	 var tr=$(this).val();
	        	 /* var tr=$("tr[id ^= cart_table]"); */
	             tr.remove();
	         });
	     } else{
	         return false;
	     }
	});
});
</script>
<script>
$(function(){
	//단체 체크박스 선택 시
    $( "#cartCheck" ).click( function() {
    	//만약 전체 선택 체크박스가 체크된상태일경우 
    	if($("#cartCheck").prop("checked")) {
			
			$("input[type=checkbox]").prop("checked", true);
		} else {
			
			$("input[type=checkbox]").prop("checked", false);
		}
    });
	
    $( "#check_" ).click(function() {
    	//만약 전체 선택 체크박스가 체크된상태일경우 
    	
    	$("#check_").val("sessionDelete");
    }); //
});
</script>
<style>
table {
	border-collapse: collapse;
	border: 1px solid gray;
	font-size: 11px;
}

table td {
	border: 1px solid gray;
	padding: 12px;
}
</style>
<body>
그림 : ${cart.get(0)}<br>
<div>
	<header>
	<nav id = "menu1">
	  <ul>	
			<li>
				<c:if test="${not empty pageContext.request.userPrincipal.name}">
						    ${pageContext.request.userPrincipal.name} 님 환영합니다.
					<%-- <input type="button" value="로그아웃"
		   				   onclick="location.href='${pageContext.request.contextPath}/logoutProc'" />	 --%>	
		   			<a class="style1" href="${pageContext.request.contextPath}/logoutProc">로그아웃</a>
				</c:if>
			</li>
			<c:if test="${empty pageContext.request.userPrincipal.name}">
				<li><a class="style1" href="${pageContext.request.contextPath}/join">회원가입</a></li>
				<li><a class="style1" href="${pageContext.request.contextPath}/login">로그인</a></li>
			</c:if>
			<li><a class="style1" href="${pageContext.request.contextPath}/coffee/cartAction">장바구니</a></li>
			<li><a class="style1" href="${pageContext.request.contextPath}/secured/user/userview?username=${pageContext.request.userPrincipal.name}">마이페이지</a></li>
			<li>
				<c:if test = "${pageContext.request.userPrincipal.name == 'do5541hyun'}" >
		   				<a class="style1" href="${pageContext.request.contextPath}/admin/home">관리자 페이지</a>	    
					</c:if>	    
			<li>
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
		<li><a class="style2" href="${pageContext.request.contextPath}/notice">공지사항</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy">로스팅원두</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy2">더치커피</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy3">이벤트</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/board/boardList.do/1">상품후기</a></li>
	  </ul>
	</nav><header>
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
	<%-- <c:if test="${productVO.size() == 0}">
        <div style="text-align:center; font-size:12px">
         	 장바구니 없음
        </div>
     </c:if> --%>
	<br>
		<h6>상품구매목록</h6>
		 <hr>
			<table>
				<tr>
					<td><input type="checkbox" id="cartCheck" name="cartCheck" value="cartCheck"></td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>판매가</td>
					<td>수량</td>
					<td>배송지</td>
					<td>배송상태</td>
				</tr>
				<c:forEach items="${order}" var="deliver" varStatus="st">
					<tr id="cart_table${deliver.pnum}" name="cart_table${deliver.pnum}">
						<td><input type="checkbox" id="check_${deliver.pnum}" name="check_${deliver.pnum}" value="check_${goods.pnum}"></td>
						<td>
							<img src="<c:url value="/pic/${deliver.pfile}.jpg" />" width="60" height="55"/>
						</td>
						<td>${deliver.pname} <br> ${deliver.capacity} ${deliver.hardgrove}</td>
						<td>
							<fmt:formatNumber type="number" value="${deliver.price * deliver.pcount}"/>원</td>
						<td id = "pcount_${deliver.pnum}">
							<input type="number" id = "pcount_${deliver.pnum}" size="10" value = "${deliver.pcount}"/>
							<input type="button" id ="modify_btn_${deliver.pnum}" value="변경" 
								   onclick="location.href='${pageContext.request.contextPath}/pcountUpdate?pnum=${deliver.pnum}'"/>
						</td>
						<td><fmt:formatNumber type="number" value="2500"/>원</td>
						<td>
							<fmt:formatNumber type="number" value="${deliver.price *deliver.pcount + 2500}"/> 원
						</td>
					</tr>
						</c:forEach>
				</table>
					<br>
					<div align="center">
             		<input type="button" value="상품 더 보기" id="allDelete" 
             			   onclick="location.href='${pageContext.request.contextPath}/coffee/cartDelete'">
					</div>
			<br/>
		<br><br>
	</article>
</div>
</body>
</html>