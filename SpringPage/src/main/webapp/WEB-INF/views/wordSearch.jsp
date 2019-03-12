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
		    		url : "${pageContext.request.contextPath}/login/idCheck",
		    	    type: "get",
		    	    dataType: "text",
		        	data : {
		        		username : $("#username").val()
		        		//password : $("#password").val()
		        	},
		        	success : function(data) {
		        		
		        		alert("중복점검성공");
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
</head>
<body>
<div>
result:${userLogin}<br>
	<header>
	<nav id = "menu1">
	  <ul>
		<li><a class="style1" href="${pageContext.request.contextPath}/join">회원가입</a></li>
		<li><a class="style1" href="${pageContext.request.contextPath}/login">로그인</a></li>
		<li><a class="style1" href="#">장바구니</a></li>
		<li><a class="style1" href="#">마이페이지</a></li>
	  </ul>
	</nav>
	<form id="search" action="search.php" method="post">
		<input type="text" title="검색">
		<input type="submit" value="검색">
	</form>
	</header>
	<nav id = "menu2">
	  <ul>
		<li><a class="style2" href="${pageContext.request.contextPath}/notice">공지사항</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy">로스팅원두</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy2">더치커피</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/coffee/buy3">이벤트</a></li>
		<li><a class="style2" href="${pageContext.request.contextPath}/board/boardList.do/1">상품후기</a></li>
	  </ul>
	</nav>
	<section>
		<div>
			<img src="${pageContext.request.contextPath}/pic/coffee_section2.jpg"
				width="990" height="130">
		</div>
	</section>
	<article>
	<p>FIND PASSWORD</p>
	<hr>
		<h2>비밀번호 찾기</h2>
		
		<c:if test="${error eq 'true'}">
			<div class="msg">${msg}</div>
		</c:if>

		<form id="wordSearch" 
			  name="wordSearch" 
			  action="<c:url value='/wordSearch?${_csrf.parameterName}=${_csrf.token}' />"
			  method="POST">
			  
		<table class="loginbox">
			<tr>
			  <td> 아이디 </td>
			  <td> <input type="text" id="username" name="username"> </td>
			</tr>
			<tr>
			  <td> 이름 </td>
			  <td> <input type="text" id="name" name="name"> </td>
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
			  </td>
			</tr>
			<tr>
			<td> <input id="joinbtn"
				        name="joinbtn"
				    	type="button"
				    	value="확인"
				    	onclick="location.href='${pageContext.request.contextPath}/login'"/> 
	    	</td>
			</tr>
	    </table>
	    <br>
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