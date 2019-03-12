<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no">
<title>home</title>

<link rel="stylesheet" href="<c:url value='/css/homepage.css' />">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="js/jQuery/3.3.1/jquery-3.3.1.min.js" charset="UTF-8"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function() {
	//사용할 배너
	var $banner = $(".banner").find("ul");

	var $bannerWidth = $banner.children().outerWidth();//배너 이미지의 폭
	var $bannerHeight = $banner.children().outerHeight(); // 높이
	var $bannerLength = $banner.children().length;//배너 이미지의 갯수
	var rollingId;

	//정해진 초마다 함수 실행
	rollingId = setInterval(function() { rollingStart(); }, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

	//마우스 오버시 롤링을 멈춘다.
	banner.mouseover(function(){
		//중지
		clearInterval(rollingId);
		$(this).css("cursor", "pointer");
	});
	//마우스 아웃되면 다시 시작
	banner.mouseout(function(){
		rollingId = setInterval(function() { rollingStart(); }, 3000);
		$(this).css("cursor", "default");
	});
	
	function rollingStart() {
		$banner.css("width", $bannerWidth * $bannerLength + "px");
		$banner.css("height", $bannerHeight + "px");
		//alert(bannerHeight);
		//배너의 좌측 위치를 옮겨 준다.
		$banner.animate({left: - $bannerWidth + "px"}, 3000, function() { //숫자는 롤링 진행되는 시간이다.
			//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
			$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
			//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
			$(this).find("li:first").remove();
			//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
			$(this).css("left", 0);
			//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
		});
	}
	
	$banner.mouseover(function(){
		//중지
		clearInterval(rollingId);
		$(this).css("cursor", "pointer");
	});
	//마우스 아웃되면 다시 시작
	$banner.mouseout(function(){
		rollingId = setInterval(function() { rollingStart(); }, 2000);
		$(this).css("cursor", "default");
	});
}); 
</script>
</head>
<style>
#roll_btn {
	width: 220px;
	height: 20px;
	position: absolute;
	right: 8px;
	bottom: 5px;
	cursor: pointer;
}

#main_left {
	float: left;
	width: 850px;
	height: 320px;
	margin: 0 10px 0 0;
	position: relative;
}

img.pic:hover { 
	opacity: 0.7; 
	filter: alpha(opacity=100);  
}

.banner {
	position: relative; 
	width: 980px;
	height: 320px;
	bottom: 10px;
	margin:0 auto; 
	padding:0; 
	overflow: hidden;
}
.banner ul {
	position: absolute; 
	margin: 0px; 
	padding:0; 
	list-style: none; 
}
.banner ul li {
	float: left; 
	width: 980px;
	height: 320px;
	margin:0; 
	padding:0;
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
			<%-- <div id="coffee_head">
				<img src="${pageContext.request.contextPath}/pic/coffee_head01.jpg"
					width="980" height="320">
			</div> --%>
		<div id="coffee_head">
			<div class="banner">
				<ul>
					<li><img src="${pageContext.request.contextPath}/pic/coffee_head01.jpg" width="980" height="320"></li>
					<li><img src="${pageContext.request.contextPath}/pic/coffee_head02.jpg" width="980" height="320"></li>
					<li><img src="${pageContext.request.contextPath}/pic/coffee_head03.jpg" width="980" height="320"></li>
					<li><img src="${pageContext.request.contextPath}/pic/coffee_head04.jpg" width="980" height="320"></li>
				</ul>
			</div>
		</div>
		</section>
		<article>
			<div class="coffee_show">
				<h3>추천 상품</h3>
				<hr>
				<%-- <img src="${pageContext.request.contextPath}/pic/coffee_01.jpg"> --%>
				<a href="${pageContext.request.contextPath}/coffee/buyForm?pnum=1">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/coffee_01.jpg">
				</a> <a href="${pageContext.request.contextPath}/coffee/buyForm?pnum=6">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/coffee_06.jpg">
				</a> <a
					href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=11">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/dutch_01.jpg">
				</a> <a
					href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=24">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/event_04.jpg">
				</a>
			</div>
			<div class="coffee_show">
				<h3>신상품</h3>
				<hr>
				<a href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=14">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/dutch_05.jpg">
				</a> <a
					href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=20">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/dutch_11.jpg">
				</a> <a
					href="${pageContext.request.contextPath}/coffee/buyForm2?pnum=15">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/dutch_06.jpg">
				</a> <a href="${pageContext.request.contextPath}/coffee/buyForm?pnum=9">
					<img class="pic"
					src="${pageContext.request.contextPath}/pic/coffee_09.jpg">
				</a>
			</div>
			<div class="coffee_show">
				<h3>후기게시판</h3>
				<hr>
			</div>
		</article>
		<aside>
		
		</aside>
		<footer>
			<hr>

		</footer>
	</div>
</body>
</html>