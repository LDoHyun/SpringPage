<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<title>회원정보 수정</title>

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

		$("#birthday").datepicker();

		// $("#birthday").datepicker("option", "dateFormat", "yy-mm-dd");
		// $("#birthday").datepicker("option", "ko", "yy-mm-dd");

	});
    /*angular*/  
    angular.module('updateApp', [])
    	   .controller(  
           'updateController',  
           [  
               '$scope',  
               function($scope) {  

                   $scope.checkFinal = function() {  
					   
                       //신규 비밀번호 점검  
                       //두 개의 신규 비밀번호 모두 공백일 경우 => 폼점검 승인 : 기존 비밀번호 불변  
                       if ($('#password1').val() == '' && $('#password2').val() == '') {  

                           alert("비밀번호를 입력하세요");  
                           //공란일경우 기존 패쓰워드 전송  
                           $scope.password1 = "${userUpdateVO.password1}";  
                           $scope.password2 = "${userUpdateVO.password2}";  
                       }  
                   }  
               } ]);  
/*  	$(document).ready(function(){
		$("#btnDelete").click(function(){
			
			if(confirm("회원정보를 삭제하겠습니까?")){
				document.form1.action = "${pageContext.request.contextPath}/admin/user/deleteAction?username=${userVO.username}";
				document.form1.submit();
			}
		});
	});  */
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
</style>
</head>
<body ng-app="updateApp" ng-controller="updateController">
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
			<h4>회원정보 수정</h4>
			<hr>
			<form:form modelAttribute="userUpdateVO" id="userUpdate" name="userUpdate" 
        			   action="updateAction" method="POST">  
				<table>
					<tr>
						<td>아이디</td>
						<td>${userVO.username}
						<input type="hidden" id="username" name="username" 
							   size="15" value="${userVO.username}"> 
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td>  
							<input type="hidden" id="password"  
			                       name="password" value="${password}">
		                    <input type="password" id="password1" maxlength="20"
		                    	   size="15"  name="password1" ng-model="password1" required="true" 
			                       ng-pattern="/^(?=.*\d)(?=.*[a-z,A-Z])(?=.*\W).{8,20}$/"></td>  
						</td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td>
							<input type="password" id="password2" name="password2" 
								   size="15" ng-model="password2" required="true" maxlength="20"
								   ng-pattern="/^(?=.*\d)(?=.*[a-z,A-Z])(?=.*\W).{8,20}$/">
						</td>
						</tr>
					<tr>
						<td id="pwErrMsg" ng-show="userUpdate.password.$error.pattern || 
                   				userUpdate.password2.$error.pattern"> 특수/대소문자,숫자 각 1자 이상 8~30자로 입력하세요</td>  
						<!--  비밀번호 불일치시 에러메시지: 추후 완성 -->  
                		<td id="pw2ErrMsg" ng-show="userUpdate.password1.$viewValue != 
                    			userUpdate.password2.$viewValue"> 비밀번호가 일치하지 않습니다.</td> 
                    </tr> 
					<tr>
						<td>비밀번호 질문</td>
						<td><select id="passhint" name="passhint" value="${userVO.name}">
								<option value="hint01">기억에 남는 추억의 장소는?</option>
								<option value="hint02">자신의 인생 좌우명은?</option>
								<option value="hint03">자신의 보물 제1호는?</option>
								<option value="hint04">가장 기억에 남는 선생님 성함은?</option>
								<option value="hint05">타인이 모르는 자신만의 신체비밀이 있다면?</option>
								<option value="hint06">추억하고 싶은 날짜가 있다면?</option>
								<option value="hint07">받았던 선물 중 기억에 남는 독특한 선물은?</option>
								<option value="hint08">유년시절 가장 생각나는 친구 이름은?</option>
								<option value="hint09">인상 깊게 읽은 책 이름은?</option>
								<option value="hint10">읽은 책 중에서 좋아하는 구절이 있다면?</option>
								<option value="hint11">자신이 두번째로 존경하는 인물은?</option>
								<option value="hint12">친구들에게 공개하지 않은 어릴 적 별명이 있다면?</option>
								<option value="hint13">초등학교 때 기억에 남는 짝꿍 이름은?</option>
								<option value="hint14">다시 태어나면 되고 싶은 것은?</option>
								<option value="hint15">내가 좋아하는 캐릭터는?</option>
						</select></td>
					</tr>
					<tr>
						<td>비밀번호 확인 답변</td>
						<td>
							<input type="text" id="passans" name="passans" 
								   size="50" value="${userVO.passans}"
								   ng-model="passans" ng-init="passans='${userVO.passans}'">
						</td>
					</tr>
					<tr>  
		                <td id="passansErrMsg" ng-show="userUpdate.passans.$invalid">  
		                  	 답변을 입력하세요</td>  
            		</tr>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" id="name" name="name" 
								   ng-model="name" placeholder="${userVO.name}" 
								   size="15" value="${userVO.name}" maxlength="40"
								   ng-init="name='${userVO.name}'">
						</td>
					</tr>
					<tr>  
		                <td id="nameErrMsg" ng-show="userUpdate.name.$invalid ">  
		                  	 이름을 입력하세요</td>  
            		</tr>  
					<tr>
						<td>주소</td>
						<td><input type="text" id="postcode" name="postcode" 
								   readonly size="7" maxlength="5" ng-model="postcode"
								   placeholder="${userVO.postcode}"  
                    			   ng-init="postcode='${userVO.postcode}'"> 
						  - <input type="button" value="우편번호" onClick="getPostcodeAddress()"> 
							<form:errors path="address2" cssClass="err" />
							<br> 
							<input type="text" id="address" name="address" 
								   ng-pattern="/^[a-zA-Z0-9 | 가-? | / | - |  (  |  ) | ,]{2,100}$/"  
								   placeholder="${userVO.address}" ng-model="address"
                    			   ng-init="address='${userVO.address}'"
								   size="50" readonly> <br> 
						    <input type="text" id="address2" name="address2"
						    	   ng-model="address2" 
                    			   ng-pattern="/^[a-zA-Z0-9 | 가-? | / | - |  (  |  ) | ,]{2,50}$/"  
								   placeholder="${userVO.address2}"  
                    			   ng-init="address2='${userVO.address2}'"
								   size="50">
						</td>
					</tr>
					<tr>  
                	<td id="memberAddressDetailErrMsg"  
                    	ng-show="userUpdate.address2.$invalid">
                    	상세주소를 입력하세요</td>  
           		   </tr>  
					<tr>
						<td>휴대전화</td>
						<td><select id="phone" name="phone" value="${userVO.phone}">
								<option value="010" selected>010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
						</select> 
						 - <input type="text" id="phone2" name="phone2" 
								 ng-model="phone2"  
			                     ng-pattern="/^\d{3,4}$/"  
			                     placeholder="${userVO.phone2}"  
			                     ng-init="phone2='${userVO.phone2}'"
								 size="4" maxlength="4">
						 
						- <input type="text" id="phone3" name="phone3" 
								 ng-model="phone3"  
			                     ng-pattern="/^\d{4}$/"  
			                     placeholder="${userVO.phone3}"  
			                     ng-init="phone3='${userVO.phone3}'"
								 size="4" maxlength="4"> 
						</td>
					</tr>
					<tr>  
		                <td id="memberPhoneErrMsg"  
		                    ng-show="userUpdate.memberPhone.$error.pattern">
		                   	 핸드폰번호를 정확하게 입력하세요.</td>  
		            </tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="email" name="email" 
								   size="10" value="${userVO.email}">
							@ <input type="text" id="email2" name="email2" size="10" 
									 value="${userVO.email2}" readonly="readonly"> 
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
		                <td id="emailErrMsg"  
		                    ng-show="userUpdate.email.$invalid">
		                   	이메일을 입력하세요.</td>  
		            </tr>
					<tr>
						<td>생년월일</td>
						<td>
                    	<%-- <input type="date" id="birthday" name="birthday" value="${userVO.birthday}"
                    			value="${userVO.birthday}" pattern="yyyy-MM-dd"> --%>
                    	<input type="date" name="birthday" path="birthday" size="30" 
                    		   value="${userVO.birthday}"  pattern="yyyy-MM-dd"/> 
                    	<%-- <spring:hasBindErrors name="userVO">
	                        	<c:if test="${errors.hasFieldErrors('birthday')}">
	                            <!-- <span class="err">${errors.getFieldErrors("birthday")}</span> -->
	                            	<span class="err">${birthday_error}</span>
	                       	    </c:if>
                   	 	</spring:hasBindErrors> --%>
						</td>
					</tr>
					<tr>  
		                <td id="birthdayErrMsg"  
		                    ng-show="userUpdate.birthday.$invalid">
		                                        생일을 정확하게 입력하세요.</td>  
		            </tr>
				</table>
				<br>
				<h4>추가입력</h4>
				<hr>
				<table>
					<tr>
						<td>수신여부</td>
						<td><label><input type="checkbox" id="chemail"
								name="chemail" value="${userVO.chemail}">이메일</label> 
							<label><input type="checkbox" id="chphone" 
								name="chphone" value="${userVO.chphone}">휴대전화</label>
						</td>
					</tr>
				</table>
				<br>
				<div>
					<input type="submit" id="btnUpdate" name="btnUpdate" ng-click="checkFinal()" value="회원정보 수정">
					<input type="button" id="btnDelete" name="btnDelete" value="회원정보 삭제" 
						   onclick="location.href='${pageContext.request.contextPath}/admin/user/userDelete?username=${userVO.username}'">
					<input type="button" id="btnCencel" name="btnCencel" value="취소" 
						   onclick="location.href='${pageContext.request.contextPath}/admin/user/userlistpaging?curPage=1'">
				</div>
				</form:form>
		</article>
		<aside>
		
		</aside>
		<footer>
			<hr>

		</footer>
	</div>
</body>
</html>