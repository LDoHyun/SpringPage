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
#login {
	weight:40px;
	height:70px;
    background: #3e3d3c;
    border: 1px solid #3e3d3c;
    color: #fff;
}
#inputSearch {
	height:19px;
}
</style>

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
	$(document).ready(function() {
		
		 // 필드 공백 제거
		 $("#username").val().replace(/\s/g, "");
		 $("#password").val().replace(/\s/g, "");
		 
		 $("#login").click(function() {
			
			/*  alert("username: " + $("#username").val());
			 alert("password: " + $("#password").val()); */
			 
			// 공백 여부 점검
			if ($.trim($("#username").val()) == "" || 
				$.trim($("#password").val()) == "")   {
				
				alert("아이디와 비밀번호를 입력해주세요.");
				$("#username").val("");
				$("#password").val("");
				
			} else {
				//id점검후 성공시 로그인 전송
				$.ajax({
		    		url : "${pageContext.request.contextPath}/idCheck",
		    	    type: "get",
		    	    dataType: "text",
		        	data : {
		        		username : $("#username").val()
		        		//password : $("#password").val()
		        	},
		        	success : function(data) {
		        		
		        		if (data.trim() == "true") {
		        			
		        			document.loginForm.submit();
		        		} else {
			       			 alert("아이디가 존재하지 않습니다."); 
		        			 $("#username").focus();
			        	} 
					}
		        	
		    	}); // $.ajax
		    	
		    	
			} // if
	    	
	    }) // login
	    
	}) //
</script>
</head>
<body>
<div>
<%-- result:${userLogin}<br> --%>
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
			</li>
		</ul>
	</nav>
	<form id="search" action="search.php" method="post">
		<input id = "inputSearch" type="text" title="검색">
		<input id = "btnSearch" type="submit" value="검색">
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
		<li><a class="style2" href="${pageContext.request.contextPath}/notice/noticeList.do/1">공지사항</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy">로스팅원두</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy2">더치커피</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy3">이벤트</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/secured/board/boardList.do/1">상품후기</a></li>
	 </ul>
	</nav>
	<section>
		<div>
			<img src="${pageContext.request.contextPath}/pic/coffee_section2.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	<p>LOGIN</p>
	<hr>
		<h2>회원 로그인</h2>
		
		<c:if test="${error eq 'true'}">
			<div class="msg">${msg}</div>
		</c:if>

		<form id="loginForm" 
			  name="loginForm" 
			  action="<c:url value='/login?${_csrf.parameterName}=${_csrf.token}' />"
			  method="POST">
			  
		<table class="loginbox">
			<tr>
			  <td> 아이디 </td>
			  <td> <input type="text" id="username" name="username" > </td>
			  <td rowspan="2">
			  	<input id="login"
					   name="login" 
					   type="button" 
					   value="login" />
			  </td>
			</tr>
			<tr>
			  <td> 비밀번호 </td>
			  <td> <input type="password" id="password" name="password" > </td>
			  <td colspan="2">
				<span class="err">
				${password_err}
				</span>
			  </td>
			</tr>
			<tr colspan="2">
				<td>
				<div>
					<p>
					<img src="${pageContext.request.contextPath}/pic/security.gif">
					보안접속
					</p>
				</div>
				</td>
			</tr>
		<tr>
		<td>
	    <!-- <div id="find_btn"> -->
	    	<a class="findId" href="${pageContext.request.contextPath}/idSearch">아이디 찾기</a>
	    </td>
	    <td>
	    	<a class="findword" href="${pageContext.request.contextPath}/wordSearch">비밀번호 찾기</a>
	    </td>
	    <td>
	    	<a class="joinbtn" href="${pageContext.request.contextPath}/join">
				<img src="${pageContext.request.contextPath}/pic/joinbtn.gif">
			</a>
	    </td>
		</tr>
		</table>
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