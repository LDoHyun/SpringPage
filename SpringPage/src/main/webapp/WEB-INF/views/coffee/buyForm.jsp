<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
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

<script>
$(function() {
	
	$("#order").click(function() {
		
		if ($("#hardgrove").val() == "" ||
			$("#capacity").val() == ""){
			
			alert("필수 옵션을 선택해주세요.");
		} else {
			
			$("#buyForm").attr("action","${pageContext.request.contextPath}/secured/coffee/orderOneAction");
			$("#buyForm").submit();
			//location.href='${pageContext.request.contextPath}/secured/coffee/orderAction?pnum=' + "${productVO.pnum}";
		}
	});//
	$("#cart").click(function() {
		
		if ($("#hardgrove").val() == "" ||
			$("#capacity").val() == ""){
			
			alert("필수 옵션을 선택해주세요.");
			return false;
		} 
	});//
	
});
</script>
<script>
// 분쇄도, 용량 설정
function selectCoffeeHardgroveAndCapacity(hardgrove, capacity) {
        // 분쇄도 설정
        var len = document.all["hardgrove"].length; 
        
        //alert(len);
        
        var selectedIdx = 0; // 선택된 항목의 index
        
        // 항목에 해당하는 순번(index)값 검색
        for (i=0; i<len; i++) {
            
            if (document.all["hardgrove"][i].value == hardgrove)
                selectedIdx = i;
            	
        } // for
        
        // 선택항목 재설정(re-select)
        document.all["hardgrove"].selectedIndex = selectedIdx;
        
        //용량 설정
		var len = document.all["capacity"].length; 
        var selectedIdx = 0; // 선택된 항목의 index
        
        // 항목에 해당하는 순번(index)값 검색
        for (i=0; i<len; i++) {
            
            if (document.all["capacity"][i].value == capacity)
                selectedIdx = i;
        } // for
        
        // 선택항목 재설정(re-select)
        document.all["capacity"].selectedIndex = selectedIdx;
        
    }

	window.onload = function() {
			selectCoffeeHardgroveAndCapacity("${productVO.hardgrove}", "${productVO.capacity}");
	}	
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
			<img src="${pageContext.request.contextPath}/pic/coffee_section.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	<br>
		<h6>상품설명</h6>
		 <hr>
		 <div>
		 	<img class="pic" src="${pageContext.request.contextPath}/pic/${productVO.pfile}.jpg">
		 </div>
		 
	<form:form id ="buyForm" method="post" action="cartAction" modelAttribute="productVO"> 
	
		 <!-- 히든 필드 -->
		 <input type="hidden" id="pnum" name="pnum" size="15" value="${productVO.pnum}">
		 <input type="hidden" id="pname" name="pname" size="15" value="${productVO.pname}">
	 	 <input type="hidden" id="price" name="price" size="15" value="${productVO.price}">
	 	 <input type="hidden" id="country" name="country" size="15" value="${productVO.country}">
	 	 <input type="hidden" id="totshipprice" name="totshipprice" value="2500">
	 	 <input type="hidden" id="pfile" name="pfile" value="${productVO.pfile}" />
	 	 
		 <table>
		 <!-- <img src="**/pic/coffee1.jpg"> -->
		 <tr>
		 	<td>상품 이름</td>
		 	<td>${productVO.pname}
		 	</td>
		 </tr>
		 <tr>		 
			<td>가격</td>
			<td><fmt:formatNumber type="number" value="${productVO.price}"/>원
		 	</td>
		 </tr>
		 <tr>
			<td>원산지</td>
			<td>${productVO.country}
		 	</td>
		 </tr>
		 <tr>	 
			<td>배송비</td>
			<td><fmt:formatNumber type="number" value="2500"/>원</td>
		 </tr>
		 <tr>
			<td>분쇄도</td>
			<td>
			<select id="hardgrove" name="hardgrove">
			 	<option value="" selected>----------------</option>
			 	<option value="홀빈(분쇄안함)">홀빈(분쇄안함)</option>
			 	<option value="에스프레소">에스프레소</option>
			 	<option value="모카포트">모카포트</option>
			 	<option value="더치커피">더치커피</option>
			 	<option value="드립커피">드립커피</option>
			</select>
			</td>
		 </tr>
		 <tr>
			<td>용량</td>
			<td>
			<select id="capacity" name="capacity">
			 	<option value="" selected>----------------</option>
			 	<option value="250g">250g</option>
			 	<option value="500g">500g (+8000)</option>
			 	<option value="1kg">1kg (+16000)</option>
			</select>
			</td>
		 </tr>
		 <tr>
			 <td>갯수</td>
			 <td>
			 <input type="number" name="pcount" min="1" max="10" value="1">개
		 	 </td>
		 </tr>
	    	 </table>
	    	 <hr>
	    	 <button type="button" id="order" name="order">주문하기</button>
	    	 <button type="submit" id="cart" name="cart" >장바구니</button>
	    	 <button type="button" id="wish_list" name="wish_list"
	    	 		 <%-- onclick="location.href='${pageContext.request.contextPath}/coffee/buyWish'" --%>>관심상품등록</button>
	</form:form>
	</article>
	<aside>
	
	</aside>
	<footer>
	
	</footer>
</div>	
</body>
</html>