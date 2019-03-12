<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<title>상품주문</title>

<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->

<!-- jquery -->  
<script src="<c:url value='/jquery/3.3.1/jquery-3.3.1.min.js'/>"></script>  

<!-- daum post map -->  
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>  

<%-- <script src="<c:url value='/js/datepicker.ko.js' />"></script> --%>

<!-- angularjs 1.7.6 -->
<script src="<c:url value='/angular/1.7.6/angular.min.js' />"></script>

<script>
	//도로명 주소 검색
	function getPostcodeAddress() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분	

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수

				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				fullAddr = data.roadAddress;

				// 법정동명이 있을 경우 추가한다.
				if (data.bname !== '') {
					extraAddr += data.bname;
				}
				// 건물명이 있을 경우 추가한다.
				if (data.buildingName !== '') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
							: data.buildingName);
				}
				// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('address').value = fullAddr;

				// 커서를 상세주소 필드로 이동한다.
				document.getElementById('address2').focus();
			}
		}).open();
	}
	function email_input(userinput) {
		var email_input = userinput.email3.value;
		if (email_input == "0") {
			userinput.email2.value = '';
			userinput.email2.readOnly = false;
		} else {
			userinput.email2.value = email_input;
			userinput.email2.readOnly = true;
		} //if
	}; //function email_input(userinput)
	
	$(function() {
		
		//수량 변경 버튼
		// onclick="
		$("[id^=modify_btn_]").click(function(e){

			var id = e.target.id;
			var pnum = id.substring(11, id.length);
			var pcount = $("#pcount_" + pnum).val();
			
			$.ajax({
		    		url : "${pageContext.request.contextPath}/secured/orderPcountUpdate",
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
			
			location.href="${pageContext.request.contextPath}/secured/coffee/orderDeleteAction?pnum=" + pnum;
		});
		
		//개별상품 삭제(버튼)
		$("#someDelete").click(function(){
			//check_${goods.pnum}
			
			var len = $("input[id^=check_]:checked").length;
			
			var params = "";
			
			console.log("##########");
			
			if(len > 0){

				for (var i=0; i<len; i++) {
			          
					var chk = $("input[id^=check_]:checked:eq("+i+")");
					var chkid = chk.attr("id");
					console.log("chkid : " + chkid);
					var pnum = chkid.substring(6, chkid.length);
					
					params += "&pnum=" + pnum;
					
		          } //
		          
					console.log("params:" + params);
				
					if(params == ''){
						alert("선택목록이 없습니다.");
					} else {
						//location.href='${pageContext.request.contextPath}/coffee/cartDeleteAction?' + params; 
					}
				
			} else {
				alert("선택된 상품이 없습니다.");
			}
		});
		
		// 체크박스 전체 선택/해제
		 $("#orderCheck").click(function() {
		      
		      var chkYn = $("#orderCheck").prop("checked");
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
		         } //

		         
		      } //
		     
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
		      } else {
		    	  alert("선택한 상품이 없습니다.");
		      }
		   }); 
	 
		$("#other_deliver").click(function(){
			
		/* 	$("input:radio[id='user_deliver']:checked").val();	
			$("input:radio[id='other_deliver']:checked").val();	 */	
			
			//주문자 정보 초기화
			$("#name").val("");
			$("#postcode").val("");
			$("#address").val("");
			$("#address2").val("");
			$("#phone").val("");
			$("#phone2").val("");
			$("#phone3").val("");
			$("#email").val("");
			$("#email2").val("");
			
			$("#name").focus();
		});
		
		$("#user_deliver").click(function(){
			
			/* 	$("input:radio[id='user_deliver']:checked").val();	
				$("input:radio[id='other_deliver']:checked").val();	 */	
				
				//주문자 정보 초기화
				$("#name").val($("#uname").val());
				$("#postcode").val($("#upostcode").val());
				$("#address").val($("#uaddress").val());
				$("#address2").val($("#uaddress2").val());
				$("#phone").val($("#uphone").val());
				$("#phone2").val($("#uphone2").val());
				$("#phone3").val($("#uphone3").val());
				$("#email").val($("#uemail").val());
				$("#email2").val($("#uemail2").val());
				
				$("#name").focus();
			});
		
			$("#user_deliver").click(function(){
			
			/* 	$("input:radio[id='user_deliver']:checked").val();	
				$("input:radio[id='other_deliver']:checked").val();	 */	
				
				//주문자 정보 초기화
				$("#name").val($("#uname").val());
				$("#postcode").val($("#upostcode").val());
				$("#address").val($("#uaddress").val());
				$("#address2").val($("#uaddress2").val());
				$("#phone").val($("#uphone").val());
				$("#phone2").val($("#uphone2").val());
				$("#phone3").val($("#uphone3").val());
				$("#email").val($("#uemail").val());
				$("#email2").val($("#uemail2").val());
				
				$("#name").focus();
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

.join_agree {
	width: 500px;
	height: 100px;
	overflow: auto
}
.err
{
    font-size:12px;
    color:red;
}  
#orderTable{
	width: 900px;
	margin: auto;
}
</style>
</head>
<body ng-app="updateApp" ng-controller="updateController">
<%-- userVO:${userVO}<br>  --%>
<%-- ID:${pageContext.request.userPrincipal.name}<br>
	 result:${userVO} --%>
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
			<h4>상품주문</h4>
			<hr>
			 <form id="orderForm" action="paymentAction" method="POST">  
				
				<table id="orderTable">
				<tr>
					<td><input type="checkbox" id="orderCheck" name="orderCheck" value="orderCheck"></td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>판매가</td>
					<td>수량</td>
					<td>배송비</td>
					<td>합계</td>
					<td>선택</td>
				</tr>
					<!-- 바로 상품구매 시 -->
					<c:forEach items="${orders}" var="goods" varStatus="st">
						<input type="hidden" id="pnum_${goods.pnum}" name="pnum" value="${goods.pnum}">
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
									<!-- 상품단가 -->
									<input type="hidden" id="goodsprice_${goods.pnum}" name="goodsprice_${goods.pnum}" value="${goods.price}"> 
									<br> <b>${goods.capacity} ${goods.hardgrove}</b></td>
								<td>
									<fmt:formatNumber type="number" value="${goods.price * goods.pcount}"/>원
									<input type="hidden" id="goodstotprice_${goods.pnum}" name="goodstotprice_${goods.pnum}" value="${goods.price * goods.pcount}">	
								</td>
								<td>
									<input type="number" id = "pcount_${goods.pnum}" name = "pcount_${goods.pnum}" size="10" value = "${goods.pcount}"/>
									<input type="button" id ="modify_btn_${goods.pnum}" value="변경" />
								</td>
								<td><fmt:formatNumber type="number" value="2500"/>원</td>
								<td>
									<fmt:formatNumber type="number" value="${goods.price * goods.pcount + 2500}"/> 원
									<input type="hidden" id="goodstotshipprice_${goods.pnum}" name="goodstotshipprice_${goods.pnum}" value="${goods.price * goods.pcount + 2500}">	
								</td>
								<td>
								<input type="button" value="주문하기" id="btnOrder" 
				             		onclick="location.href='${pageContext.request.contextPath}/secured/coffee/orderForm?pnum=${goods.pnum}'">
				             	<%-- <br>
				             	<input type="button" value="관심상품등록" id="btnOrder" 
				             		onclick="location.href='${pageContext.request.contextPath}/secured/coffee/buyWish'">
				             	<br> --%>
				             	<input type="button" value="삭제" id="btnDelete_${goods.pnum}">
				             		<%--    onclick="location.href='${pageContext.request.contextPath}/coffee/deleteSession'"> --%>
								</td>
							</tr>
						</c:forEach>
						<!-- 메뉴 -->
						<tr>
							<td colspan = "9" align="center">
								<input type="button" value="전체상품삭제" id="allDelete" >
	        					<input type="button" value="선택상품삭제" id="someDelete">
							</td>
						</tr>
				</table>
					
				<br>
				<h5>주문자 정보</h5>
				<input type="hidden" id="username" name="username" size="15" value="${userVO.username}">
				<table>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" id="uname" name="uname" readonly="readonly"
								   ng-model="uname" ng-init="uname='${userVO.name}'"
								   placeholder="${userVO.name}" size="15" 
								   value="${userVO.name}" maxlength="40">
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" id="upostcode" name="upostcode" 
								   readonly size="7" maxlength="5" ng-model="upostcode"
								   placeholder="${userVO.postcode}" value="${userVO.postcode}" 
                    			   ng-init="upostcode='${userVO.postcode}'"> 
							<br> 
							<input type="text" id="uaddress" name="uaddress" value="${userVO.address}"
								   ng-pattern="/^[a-zA-Z0-9 | 가-? | / | - |  (  |  ) | ,]{2,100}$/"  
								   placeholder="${userVO.address}" ng-model="uaddress"
                    			   ng-init="uaddress='${userVO.address}'"
								   size="50" readonly> <br> 
								   
						    <input type="text" id="uaddress2" name="uaddress2"
						    	   ng-model="uaddress2" name="uaddress2"  
                    			   ng-pattern="/^[a-zA-Z0-9 | 가-? | / | - |  (  |  ) | ,]{2,50}$/"  
								   placeholder="${userVO.address2}" value="${userVO.address2}" 
                    			   ng-init="uaddress2='${userVO.address2}'"
								   size="50" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>휴대전화</td>
						<td><input type="text" id="uphone" name="uphone" 
								 ng-model="uphone" readonly="readonly" 
			                     ng-pattern="/^\d{4}$/" value="${userVO.phone}" 
			                     placeholder="${userVO.phone}"  
			                     ng-init="uphone='${userVO.phone}'"
								 size="4" maxlength="4"> 
						 - <input type="text" id="uphone2" name="uphone2" 
								 ng-model="uphone2" readonly="readonly" 
			                     ng-pattern="/^\d{3,4}$/" value="${userVO.phone2}"  
			                     placeholder="${userVO.phone2}"  
			                     ng-init="uphone2='${userVO.phone2}'"
								 size="4" maxlength="4">
						 
						- <input type="text" id="uphone3" name="uphone3" 
								 ng-model="uphone3" readonly="readonly" 
			                     ng-pattern="/^\d{4}$/" value="${userVO.phone3}"  
			                     placeholder="${userVO.phone3}"  
			                     ng-init="uphone3='${userVO.phone3}'"
								 size="4" maxlength="4"> 
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="uemail" name="uemail" 
								   size="10" value="${userVO.email}" readonly="readonly">
							@ <input type="text" id="uemail2" name="uemail2" size="10" 
									 value="${userVO.email2}" readonly="readonly"> 
						</td>
					</tr>
				</table>
				<br>
				
				<h5>배송지 정보</h5>
				<table>
					<tr>
						<td>배송지 선택</td>
						<td>
							주문자와 동일 <input type="radio" name ="selectDeliver" id="user_deliver" 
											 value="user_deliver" checked = "checked"> 
							새로운 배송지 <input type="radio" name ="selectDeliver" id="other_deliver"
											 value="other_deliver"> 
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" id="name" name="name" value="${userVO.name}"
								   size="15" maxlength="40">
						    <input type="hidden" id="name" name="name" value="${userVO.name}"
						     	   size="15" maxlength="40">
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" id="postcode" name="postcode" value="${userVO.postcode}"
								   readonly size="7" maxlength="5" > 
						  - <input type="button" value="우편번호" onClick="getPostcodeAddress()"> 
							<br> 
							<input type="text" id="address" name="address" value="${userVO.address}"
								   ng-pattern="/^[a-zA-Z0-9 | 가-? | / | - |  (  |  ) | ,]{2,100}$/"  
								   size="50" readonly> <br> 
						    <input type="text" id="address2" name="address2" value="${userVO.address2}"
						    	   name="address2" size="50">
						</td> 
					</tr>
					<tr>
						<td>휴대전화</td>
						<td><select id="phone" name="phone">
								<option value="010" selected>010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
						</select> 
						 - <input type="text" id="phone2" name="phone2" value="${userVO.phone2}"
			                      ng-pattern="/^\d{3,4}$/" size="4" maxlength="4">
						 
						- <input type="text" id="phone3" name="phone3" value="${userVO.phone3}"
			                     ng-pattern="/^\d{4}$/" size="4" maxlength="4"> 
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="email" name="email" size="10" value="${userVO.email}">
							@ <input type="text" id="email2" name="email2" size="10" readonly="readonly" value="${userVO.email2}"> 
							  <select id="email3" name="email3" onchange="email_input(this.form)">
								<option selected>- 이메일 선택 -</option>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="nate.com">nate.com</option>
								<option value="hotmail.com">hotmail.com</option>
								<option value="yahoo.com">yahoo.com</option>
								<option value="empas.com">empas.com</option>
								<option value="korea.com">korea.com</option>
								<option value="dreamwiz.com">dreamwiz.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="0">직접입력</option>
						</select>
						</td>
					</tr>
		            <tr>
						<td>배송메시지</td>
						<td><input type="text" id="memo" name="memo" maxlength="255" cols="70" 
								   style="margin: 0px; width: 393px; height: 54px;">
						</td>
					</tr>
				</table>
				<br>
				<!-- 
				<h5>결재방식</h5>
				<table>
					<tr>
						<td>
					    <label><input type="radio" id="credit_card" name="credit_card" 
					    			  value="credit_card" checked="checked">카드결제</label>
					    <label><input type="radio" id="account_transfer" name="account_transfer" 
					    			  value="account_transfer">실시간 계좌이체</label>
					    <label><input type="radio" id="passbook" name="passbook" 
					    			  value="passbook">무통장입금</label>
						</td>
					</tr>
					<tr>
						<td>
						
					    </td>
					</tr>
					<tr>
						<td>
							입금자명 <input type="text" id="name" name="name" size="15" maxlength="40">
							<br>
							입금은행 <select id="phone" name="phone">
								<option value=0 selected>--- 선택해 주세요 ---</option>
								<option value=1>KEB하나은행:123-123456-12345 이도현</option>
							</select>
					    </td>
					</tr>
					<tr>
						<td>
							예금주명 <input type="text" id="name" name="name" size="15" maxlength="40">
					    </td>
					</tr>
				</table> -->
				<br>
					<input type="submit" id="btnOrder" name="btnOrder" value="상품결제">
					<input type="button" id="orderCancel" name="orderCancel" value="주문취소"
							onclick="location.href='${pageContext.request.contextPath}/secured/home'">
			</form> 
		</article>
		<aside>
		
		</aside>
		<footer>
			<hr>

		</footer>
	</div>
</body>
</html>