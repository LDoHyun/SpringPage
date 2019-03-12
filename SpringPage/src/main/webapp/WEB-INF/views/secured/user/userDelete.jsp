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
                       if ($('#password1').val() == '') {  

                           alert("비밀번호를 입력하세요"); 
                           
                       } else if ($('#password').val() ==  $('#password1').val()) {
                    	   
                    	   alert("비밀번호가 일치하지 않습니다.");
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
<br>
<br>
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
			<h4>회원정보 수정</h4>
			<hr>
			<form:form modelAttribute="userUpdateVO" id="securedUserDelete" name="securedUserDelete" 
        			   action="deleteAction" method="POST">  
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
                		<td id="pw2ErrMsg" ng-show="securedUserUpdate.password.$viewValue != 
                    			securedUserUpdate.password1.$viewValue"> 비밀번호가 일치하지 않습니다.</td> 
                    </tr> 
				</table>
				<br>
				<div>
					<input type="submit" id="btnDelete" name="btnDelete" value="회원정보 삭제" ng-click="checkFinal()">
					<input type="button" id="btnCencel" name="btnCencel" value="취소" 
						   onclick="location.href='${pageContext.request.contextPath}/secured/home'">
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