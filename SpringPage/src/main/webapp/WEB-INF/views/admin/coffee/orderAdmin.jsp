<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품배송 설정</title>

<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- jquery -->  
<script src="<c:url value='/jquery/3.3.1/jquery-3.3.1.min.js'/>"></script>  

<!-- daum post map -->  
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>  

<script src="<c:url value='/js/datepicker.ko.js' />"></script>

<!-- angularjs 1.7.6 -->
<script src="<c:url value='/angular/1.7.6/angular.min.js' />"></script>

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
<script>
// 배송상태 설정
function selectDeliverState(deliverState) {

		var len = document.all["deliverState"].length; 
        
        //alert(len);
        
        var selectedIdx = 0; // 선택된 항목의 index
        
        // 항목에 해당하는 순번(index)값 검색
        for (i=0; i<len; i++) {
            
            if (document.all["deliverState"][i].value == deliverState)
                selectedIdx = i;
            	
        } // for
        
        // 선택항목 재설정(re-select)
        document.all["deliverState"].selectedIndex = selectedIdx;
    }

	window.onload = function() {
			selectCoffeeHardgroveAndCapacity("${productVO.hardgrove}", "${productVO.capacity}");
	}	
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
</head>
<body>
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
			<img src="${pageContext.request.contextPath}/pic/coffee_section4.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
		<h4>상품설명</h4>
		 <hr>
		 <form modelAttribute="productVO" id="orderForm" action="orderAction" method="POST">  
			 <%-- <form:form modelAttribute="productVO"  id="orderForm" action="orderAction" method="POST">  --%> 
				
				<table>
				<tr>
					<td><input type="checkbox" id="cartCheck" name="cartCheck" value="cartCheck"></td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>판매가</td>
					<td>수량</td>
					<td>배송상태</td>
				</tr>
				<c:forEach items="${orders}" var="delivers" varStatus="st">
					<input type="hidden" id="pnum_${delivers.pnum}" name="pnum" value="${delivers.pnum}">
					<tr id="cart_table${delivers.pnum}" name="cart_table${delivers.pnum}">
						<td><input type="checkbox" id="check_${delivers.pnum}" name="check_${delivers.pnum}" value="check_${delivers.pnum}"></td>
						<td>
							<img src="<c:url value="/pic/${delivers.pfile}.jpg" />" width="60" height="55"/>
							<input type="hidden" id="goodsfile_${delivers.pnum}" name="goodsfile_${delivers.pnum}" value="${delivers.pfile}">
						</td>
						<td>${delivers.pname} 
							<input type="hidden" id="goodsname_${delivers.pnum}" name="goodsname_${delivers.pnum}" value="${delivers.pname}">
							<input type="hidden" id="goodscapacity_${delivers.pnum}" name="goodscapacity_${delivers.pnum}" value="${delivers.capacity}">
							<input type="hidden" id="goodshardgrove_${delivers.pnum}" name="goodshardgrove_${delivers.pnum}" value="${delivers.hardgrove}">
							<br> ${delivers.capacity} ${delivers.hardgrove}
						</td>
						<td>
							<fmt:formatNumber type="number" value="${delivers.price * delivers.pcount + 2500}"/> 원
							<input type="hidden" id="goodstotshipprice_${delivers.pnum}" name="goodstotshipprice_${delivers.pnum}" value="${delivers.price * delivers.pcount + 2500}">	
						</td>
						<td id = "pcount_${delivers.pnum}">
							<input type="number" id = "pcount_${delivers.pnum}" name = "pcount_${delivers.pnum}" size="10" value = "${delivers.pcount}"/>
							<input type="button" id ="modify_btn_${delivers.pnum}" value="변경" 
								   onclick="location.href='${pageContext.request.contextPath}/pcountUpdate?pnum=${delivers.pnum}'"/>
						</td>
						<td>
							<select id="deliverState" name="deliverState">
							 	<option value="" selected>----------------</option>
							 	<option value="상품 준비중">상품 준비중</option>
							 	<option value="배송시작">배송시작</option>
							 	<option value="배송중">배송중</option>
							 	<option value="배송완료">배송완료</option>
							</select>
						</td>
					</tr>
						</c:forEach>   
					 </table> 	
			 <br>
	    	 <input type="submit" value="배송상태수정">
	    	 <input type="button" id="insert_cencel" name="insert_cencel" value="취소"
	    	 		onclick="location.href='${pageContext.request.contextPath}/product/productlist?curPage=1'">
	    	</form>
	</article>
	<aside>
	
	</aside>
	<footer>
	
	</footer>
</div>	
</body>
</html>