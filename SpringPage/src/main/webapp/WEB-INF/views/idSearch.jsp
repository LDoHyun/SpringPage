<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="<c:url value='/css/loginpage.css' />">

<title>home</title>
<style>
button {
	height:65px;
}
input {
	height:25px;
}
table td {
	padding:2px 0px 0px 5px;
}
a {
	text-decoration:none;
}
</style>

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	var app = angular.module('idSearchBody', []);
	
	app.controller('idSearch',
	               ['$scope', function ($scope) {
	                   
	    // 로그인 정보 전송 버튼 클릭시...             
	    $scope.idSearchCheck = function() {
	       
	        // 폼점검에 문제가 있다면...
	        if ($scope.idSearchForm.$valid == false) {
	            openIdSearchModal("정상적인 검색 데이터가 아닙니다.<br>다시 입력하십시오.");
	            $scope.idSearchForm.id.focus(); // 아이디 필드에 입력 대기
	        } else { // 전송시
	            openIdSearchModal("아이디 검색 정보를 전송합니다.");
	        }
	         
	    } //   
	   
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
	
</script>
<style>
* {
    padding:5px;
}
input[type="text"] {
    height:30px;
}
[id$=msg] {
    /* background-color:yellow; */
    height:50px;
    color:red;
    text-indent:2em;
}
</style>
</head>
<body ng-app="idSearchBody"
      ng-controller="idSearchController">
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
	<nav id = "menu2">
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
			<img src="${pageContext.request.contextPath}/pic/coffee_section2.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	<p>FIND ID</p>
	<hr>
		<h2>아이디 찾기</h2>
		
		<form id="idSearch" 
			  name="idSearch" 
			  action="idSearchAction"
			  method="POST">
			  
		<table class="loginbox">
			<tr>
			  <td> 이름 </td>
			  <td> <input type="text" id="name" name="name" ng-model="name"> </td>
			</tr>
			<tr>
			  <td> 이메일 </td>
					<td><input type="text" id="email" name="email" size="10">
						@ <input type="text" id="email2" name="email2" size="10" readonly="readonly"> 
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
			<td> <input id="idSearchBtn"
				        name="idSearchBtn"
				    	type="submit"
				    	ng-click="idSearchCheck()"
				    	value="확인"
				    	<%-- onclick="location.href='${pageContext.request.contextPath}/join'" --%>/> 
			</td>
			</tr>
	    </table>
	    <br>
	    <br>
	    <!-- 아이디 검색 결과 메시지 -->
        <div id="result_msg">
            ${empty msg ? '' :  
              msg != '해당되는 아이디가 없습니다.' ?
              '아이디는 <b>'.concat(msg).concat('</b>입니다') : msg}
        </div>
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