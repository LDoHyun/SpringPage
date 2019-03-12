<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>

<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">

<!-- bootstrap CSS : 4.2.1 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
  
<!-- jQuery : 3.3.1 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- bootstrap JS : 4.2.1 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

<!-- AngularJS : 1.7.6 -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular.min.js"></script>

<style>
section#writeForm {
	width: 600px;
}

/* 글내용 쓰기 필드 크기 조절 방지 */
textarea {
	resize: none;
}

/* 에러 메시지 글자 : tr */
tr.err_msg {
	color: red;
	text-indent: 6em;
}
</style>

<script>
     // AngularJS
	 var app=angular.module('boardFormApp', []); 
     
	 app.controller('boardFormController', function($scope) {
			
		// 최종  폼점검 
		$scope.formFinalCheck = function($event) {
			
			alert("최종 폼점검");
			
			if ($scope.boardForm.boardName.$valid == true &&
				$scope.boardForm.boardPass.$valid == true &&
				$scope.boardForm.boardSub.$valid == true &&
				$scope.boardForm.boardContent.$valid == true) 
			{
				document.boardForm.action="${pageContext.request.contextPath}/admin/notice/writeNoticeProc.do"; 
		  		document.boardForm.submit();
		  		
			} else {
				
				alert("폼점검 미완료")
				document.boardForm.boardName.focus(); 
			} //
			
		} //
	 });

	 // jQuery
	 $(function() {
		 
		   // jQueryUI tooltip(conponent help) 
		   var tooltips=$("[title]").tooltip({
		     position: {
		       my: "left top",
		       at: "right+5 top-5",
		       collision: "none"
		     }
		   });
		   
	 }); // jQuery
  </script>
</head>

<body ng-app="boardFormApp" ng-controller="boardFormController">
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
			<img src="${pageContext.request.contextPath}/pic/coffee_section2.jpg"
				width="990" height="130">
		</div>
	</section>
	<!-- 게시판 등록 시작 -->
	<section id="writeForm" class="container">
		<br>
		<h4>후기 글 작성</h4>
		<hr>

		<form:form method="post" enctype="multipart/form-data" id="boardForm"
		       name="boardForm" ng-model="boardForm" ng-submit="formFinalCheck()">

			<!-- bootstrap table 적용 -->
			<table class="table table-striped">

				<tr class="form-group">
					<td class="col-xs-2"><label for="boardName"
						class="control-label"> <span style="color: red">*</span>글쓴이
					</label></td>
					<td class="col-xs-10"><input type="text" id="boardName"
						name="boardName" ng-model="boardName" required="required"
						class="form-control" title="게시글 작성자를  2~15자 이내로 입력하십시오"
						ng-maxlength="15" ng-minlength="2" required="true" /></td>
				</tr>

				<!-- 글쓴이 에러 메시징 시작 -->
				<tr id="boardName_ERR" class="err_msg"
					ng-show="boardForm.boardName.$error.maxlegnth || 
							 boardForm.boardName.$error.minlength">
					<td colspan="2" class="col-xs-12">게시글 작성자를 2~15자 이내로 입력하십시오</td>
				</tr>
				<!-- 글쓴이 에러 메시징 끝 -->

				<tr>
					<td><label for="boardPass" class="control-label"> <span
							style="color: red">*</span>비밀번호
					</label></td>
					<td><input type="password" id="boardPass" name="boardPass"
						ng-model="boardPass" class="form-control"
						title="게시글 패쓰워드를 8~20자 이내로 입력하십시오" ng-maxlength="20"
						ng-minlength="8" required="true" /></td>
				</tr>

				<!-- 패쓰워드 에러 메시징 시작 -->
				<tr id="boardPass_ERR" class="err_msg"
					ng-show="boardForm.boardPass.$error.maxlength || 
							 boardForm.boardPass.$error.minlength">
					<td colspan="2" class="col-xs-12">게시글 패쓰워드를 8~20자 이내로 입력하십시오</td>
				</tr>
				<!-- 패쓰워드 에러 메시징 끝 -->

				<tr>
					<td><label for="boardSub" class="control-label">
							<span style="color: red">*</span>제 목
					</label></td>
					<td><input name="boardSub" type="text" id="boardSub"
						required="required" class="form-control"
						title="글제목은 2~25자이내로 적습니다" ng-model="boardSub"
						ng-maxlength="25" ng-minlength="2" required="true" /></td>
				</tr>

				<!-- 게시글 제목 에러 메시징 시작 -->
				<tr id="boardSubject_ERR" class="err_msg"
					ng-show="boardForm.boardSubject.$error.maxlength || 
							 boardForm.boardSubject.$error.minlength">
					<td colspan="2" class="col-xs-12">글제목은 2~25자이내로 적습니다</td>
				</tr>
				<!-- 게시글 제목 에러 메시징 끝 -->

				<tr>
					<td><label for="boardContent" class="control-label">
							<span style="color: red">*</span>내 용
					</label></td>
					<td><textarea id="boardContent" name="boardContent"
							cols="40" rows="15" required="required"
							title="글내용은 2~1000자이내로 적습니다" class="form-control"
							ng-model="boardContent" ng-maxlength="1000" ng-minlength="2"
							required="true"></textarea></td>
				</tr>

				<!-- 게시글 내용 에러 메시징 시작 -->
				<tr id="boardContent_ERR" class="err_msg"
					ng-show="boardForm.boardContent.$error.maxlength || 
							 boardForm.boardContent.$error.minlength">
					<td colspan="2" class="col-xs-12">글내용은 2~1000자이내로 적습니다</td>
				</tr>
				<!-- 게시글 내용 에러 메시징 끝 -->

				<tr>
					<td><label for="boardFile" class="control-label"> 파일
							첨부 </label></td>
					<td><input type="file" id="boardFile" name="boardFile"
						class="form-control" title="첨부 파일을 입력하십시오" /></td>
				</tr>

			</table>

			<section id="commandCell">

				<input type="submit" class="btn btn-info" value="등록"
					   ng-disabled="boardForm.$invalid">&nbsp;&nbsp; <input
					   type="reset" class="btn btn-info" value="다시쓰기" />

			</section>

		</form:form>

	</section>
	<!-- 게시판 등록 끝 -->

</body>
</html>