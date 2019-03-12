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
$(function(){
	
	//수량 변경 버튼
	// onclick="
	$("[id^=modify_btn_]").click(function(e){

		var id = e.target.id;
		var pnum = id.substring(11, id.length);
		
		var pcount = $("#pcount_" + pnum).val();
		
		$.ajax({
	    		url : "${pageContext.request.contextPath}/pcountUpdate",
	    	    type: "get",
	    	    dataType: "text",
	        	data : {
	        		pnum: pnum,
	        		pcount : $("#pcount_" + pnum).val()
	        	},
	        	success : function(data) {
	        		
	        		alert(data);
	        		// 변경 후 현황 교정
	        		location.reload(); // 페이지 갱신으로 현황 변경
	        		
				}, error : function(xhr, status) {
	                 
	                console.log(xhr+" : "+status); // 에러 코드
	            } 
	        	
	    	}); // $.ajax
	});
	
	//개별상품 선택삭제(체크박스)
	$("[id^=btnDelete_]").click(function(e){
		
		var chkid = e.target.id;
		var pnum = chkid.substring(10, chkid.length);
		
		location.href="${pageContext.request.contextPath}/coffee/cartDeleteAction?pnum=" + pnum;
	});
	
    // 선택삭제버튼 클릭
	$("#deleteAction").click(function() {
		
		//var len = "${cart.size()}";
		var len = $("input[id^=check_]").length; // 체크박스 갯수
		var params = ""; //인자
		
		console.log("##########################");
		console.log("len :" + len); 
		console.log("길이 : " + $("input:checked").length);
		
		for(var i = 0; i < $("input[id^=check_]:checked").length; i++){ // 체크된 체크박스 상품아이디(pnum) 추출  ex)check_11 -> 11
			
			var chk = $("input[id^=check_]:checked:eq("+i+")");
			var chkid = chk.attr("id");
			console.log("chkid : " + chkid);
			var pnum = chkid.substring(6, chkid.length);
			
			params += "&pnum=" + pnum;
		}
		
		console.log("params:" + params);
		
		if(params == ''){
			alert("선택목록이 없습니다.");
		} else {
			location.href='${pageContext.request.contextPath}/coffee/cartDeleteAction?' + params; 
		}
		
	});//$("#deleteAction")
   
   //체크박스 전체 선택/해제
   $("#cartCheck").click(function() {
      
      var chkYn = $("#cartCheck").prop("checked");
      var len = $("input[id^=check_]").length;
      
      if (chkYn == false) {
         
            // 체크박스 전체 해제
         for (var i=0; i<len; i++) {
          
            $("input[id^=check_]:eq("+i+")").removeAttr("checked");
         } //

      } else if (chkYn == true) {

         // 체크박스 해제 선택
         for (var i=0; i<len; i++) {
          
            $("input[id^=check_]:eq("+i+")").attr("checked","checked");
         } // for
      } // if
   });
	
   //체크박스 전체 선택/해제
   $("#allDelete").click(function() {
      
      var chkYn = $("#orderCheck").prop("checked");
      var len = $("input[type=checkbox]").length;
      
      if(len > 0){
    
    	  // 전체체크박스 선택
         for (var i=0; i<len; i++) {
          
            $("input[type=checkbox]:eq("+i+")").attr("checked","checked");
         } //
	         
	      // 장바구니 세션 삭제
         location.href = "${pageContext.request.contextPath}/coffee/cartAllDeleteAction";
         
      } else {
    	  alert("선택한 상품이 없습니다.");
      }
      
   }); 

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

#cartTable {
	width: 900px;
	margin: auto;
	
}
</style>
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
			<img src="${pageContext.request.contextPath}/pic/coffee_section3.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	
	<br>
		<h6>장바구니</h6>
		 <hr>
		 <form id="orderform" name="orderform" method="POST" action="${pageContext.request.contextPath}/secured/coffee/orderAction">
			<table id="cartTable">
				<tr>
					<td><input type="checkbox" id="cartCheck" name="cartCheck" value="cartCheck"></td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>단가</td>
					<td>총가격</td>
					<td>수량</td>
					<td>배송비</td>
					<td>합계</td>
					<td>선택</td>
				</tr>
				<c:if test="${sesssionScope.cart.size() == 0 || empty sessionScope.cart}">
					<tr>
						<td colspan = "9">
							<div align = "center">장바구니가 비어있습니다.</div>
						</td>
					</tr>
				</c:if>
				
				<c:if test="${cart.size() > 0}" > <!-- 장바구니가 있을 때 -->
					<input type="hidden" id="pcount_size" name="pcount_size" value="${cart.size()}"> <!-- 상품갯수 -->
					
					<c:forEach items="${cart}" var="goods" varStatus="st">
						<input type="hidden" id="pnum_${goods.pnum}" name="pnum_${goods.pnum}" value="${goods.pnum}">
						<tr id="cart_table${goods.pnum}" name="cart_table${goods.pnum}">
							<td><input type="checkbox" id="check_${goods.pnum}" name="check_${goods.pnum}" value="check_${goods.pnum}"></td>
							<td>
								<img src="<c:url value="/pic/${goods.pfile}.jpg" />" width="60" height="55"/>
								<input type="hidden" id="goodsfile_${goods.pnum}" name="goodsfile_${goods.pnum}" value="${goods.pfile}">
							</td>
							<td>${goods.pname} 
								<input type="hidden" id="goodsname_${goods.pnum}" name="goodsname_${goods.pnum}" value="${goods.pname}">
								<input type="hidden" id="goodscapacity_${goods.pnum}" name="goodscapacity_${goods.pnum}" value="${goods.capacity}">
								<input type="hidden" id="goodshardgrove_${goods.pnum}" name="goodshardgrove_${goods.pnum}" value="${goods.hardgrove}">
								<br> ${goods.capacity} ${goods.hardgrove}
							</td>
							<td>
								<fmt:formatNumber type="number" value="${goods.price}"/>원
								<input type="hidden" id="goodsprice_${goods.pnum}" name="goodsprice_${goods.pnum}" value="${goods.price}">	
							</td>
							<td>
								<fmt:formatNumber type="number" value="${goods.price * goods.pcount}"/>원
								<input type="hidden" id="goodstotprice_${goods.pnum}" name="goodstotprice_${goods.pnum}" value="${goods.price * goods.pcount}">	
							</td>
							<td>
								<input type="number" id = "pcount_${goods.pnum}" name = "pcount_${goods.pnum}" size="10" value = "${goods.pcount}"/>
								<input type="button" id ="modify_btn_${goods.pnum}" value="변경" />
							</td>
							<td>
								<fmt:formatNumber type="number" value="2500"/>원
							</td>
							<td>
								<fmt:formatNumber type="number" value="${goods.price * goods.pcount + 2500}"/> 원
								<input type="hidden" id="goodstotshipprice_${goods.pnum}" name="goodstotshipprice_${goods.pnum}" value="${goods.price * goods.pcount + 2500}">	
							</td>
							<td>
							<input type="submit" value="주문하기" id="btnOrder">
			             		<%-- onclick="location.href='${pageContext.request.contextPath}/secured/coffee/orderAction'"> --%>
			             	<%-- <br>
			             	<input type="button" value="관심상품등록" id="btnOrder" 
			             		onclick="location.href='${pageContext.request.contextPath}/secured/coffee/buyWish'">
			             	<br> --%>
			             	<input type="button" value="삭제" id="btnDelete_${goods.pnum}">
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
			</table>
			
			<br>
			<div align="center">
			<%-- <input type="button" value="상품주문" id="allOrder" 
             	   onclick="location.href='${pageContext.request.contextPath}/secured/coffee/orderForm?pnum=${goods.pnum}'"> --%>
           		<input type="submit" value="상품주문" id="allOrder">
           		<input type="button" value="전체상품삭제" id="allDelete">
      			<input type="button" value="선택상품삭제" id="deleteAction">
			</div>
			
		</form>
		<br><br><br>
	</article>
</div>
</body>
</html>