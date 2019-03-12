<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>

<link rel="stylesheet" href="<c:url value='/css/subpage.css' />">

<!-- bootstrap CSS : 4.2.1 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- jQuery : 3.3.1 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- bootstrap JS : 4.2.1 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
	
<!-- AngularJS : 1.7.6 -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.6/angular.min.js"></script>	

<style type="text/css">
/* 등록된 글이 없을 경우, 페이징 처리 */
#emptyArea, #pageList {
	margin: 0 auto;
}

/* readonly 상태시 */
*[readonly].form-control { background-color:transparent; } 

/* textarea 크기 조절 방지  및 외부 간격*/
textarea[id$=boardContent] { 
	resize: none;
}
</style>

<!-- <script src="/custom/member.js" charset="UTF-8"></script> -->


<script>
// angularJS
// 답글 쓰기 제어
var app=angular.module('boardFormApp', []); 
   
app.controller('boardReplyFormController', function($scope) {

	 
});
</script>

<script>
// jQuery
$(document).ready(function(){
	
	// 게시글 팝업(modal) 보기
	$("a[id^=boardNum_]").click(function (e) {
		
		var boardNum = e.target.id.substring(9); // "boardNum_" 뒤부분 "글번호" 취득

		$.ajax ({
			url : "${pageContext.request.contextPath}/notice/noticeDetailJSON.do/boardNum/"+boardNum,
			contentType : "application/json",
			type : "POST",
			success : function (article) {
			
				// 게시글 내용 : modal
				$("#boardNum").val(article.boardNum);
				$("#boardName").val(article.boardName);
				$("#boardSub").val(article.boardSub);
				$("#boardContent").val(article.boardContent);
				// 글 조회수 갱신
				$("#boardReadCount_"+article.boardNum).text(article.boardReadCount);
				
				var boardFile = article.boardFile==null ? 
						        "파일없음": article.boardFile;
				
				if (boardFile == '파일없음')
				  $("#boardFile").text(boardFile);
				else {
				  
				  // 파일 중복 방지위해 접미사 부착 파일 처리
				  var originalFile = boardFile; //.split("_")[0];
				  // var ext = boardFile.split(".")[1];
				  // originalFile = originalFile + "." + ext; 
				  
				  $("#boardFile").html("<a href=\"<c:url value='/noticeUpload/"+boardFile
						  			   +"'/>\" download >"+originalFile+"</a>");
				} //
				
				// 버튼 아이디 변경 : ex) "updateContentBtn_"+article.boardNum
				$("button").attr("id", "updateContentBtn_"+article.boardNum);
		
				// 글 수정 전송 버튼 아이디 변경 : ex) "update_btn_"+article.boardNum
				$("update_btn_").attr("id", "update_submit_btn_"+article.boardNum);
				
			} //success	
			
		}); // ajax
		
	}); //
	
	// 게시글 팝업(modal) 수정
	$("button[id^=updateContentBtn_]").click(function (e) {
		
		var boardNum = e.target.id.substring(17); // "updateContentBtn_" 뒤부분 "글번호" 취득
		
		$.ajax ({
			url : "${pageContext.request.contextPath}/notice/noticeDetailJSON.do/boardNum/"+boardNum,
			contentType : "application/json",
			type : "POST",
			success : function (article) {
			
				// 기존 게시글 내용
				// modal
				$("#update_boardNum").val(article.boardNum);
				$("#update_boardName").val(article.boardName);
				$("#update_boardSub").val(article.boardSub);
				$("#update_boardContent").val(article.boardContent);
				
				// 댓글 여부 점검위한 필드값 할당
				$("#update_boardReLev").val(article.boardReLev);
				
				// alert("article.boardReLev : " + article.boardReLev);
				
				if (article.boardReLev == 0) { // 원글일 경우(답글이 아닐 경우)
				
					// alert("원글");
				
					var fileFldContent  = "<div class=\"input-group\">"
										+ "<div class=\"input-group-prepend\">"
									    + "<label for=\"update_boardFile\" class=\"control-label input-group-text ml-2\">"
									    + "첨부파일 :</label>"
										+ "</div>"		
										+ "<div class=\"custom-file\">"
										+ "		<span class=\"btn btn-default btn-file\">"
										+ "			<label for=\"update_boardFile_new\" class=\"custom-file-label\">파일 선택</label>"
										+ "			<input type=\"file\" class=\"custom-file-input\" id=\"update_boardFile_new\" name=\"update_boardFile_new\" />" 
										+ "		</span>" 
										+ "</div>"
										+ "<div class=\"input-group\">"
										+ "		<div class=\"input-group-prepend\">"	
										+ "			<div class=\"ml-3 mt-2\" id=\"update_boardFile\"></div>"
										+ "		</div>"
										+ "</div>";
				
					// 파일 필드 추가
					$("form[id=updateForm] #article_content").append(fileFldContent);	// fileFldContent
				
					
					var boardFile = article.boardFile == null ? 
					        "파일없음": article.boardFile;
			
					if (boardFile == '파일없음')
					  $("#update_boardFile").text(boardFile);
					else {
					  $("#update_boardFile").html("<a href=\"<c:url value='/boardUpload/"
							  					   +boardFile+"'/>\" >"+boardFile+"</a>");	
					  
					  // 파일 중복 방지위해 접미사 부착 파일 처리
					  var originalFile = boardFile.split("_")[0];
					  var ext = boardFile.split(".")[1];
					  originalFile = originalFile + "." + ext; 
					  
					  $("#update_boardFile").html("<a href=\"<c:url value='/boardUpload/"+boardFile
							  			   +"'/>\" >"+originalFile+"</a>");
					} //
					
				} else { // 답글일 경우
					
					// alert("답글");
				}
				
				// 조회수 업데이트
				$tempId = "#boardReadCount_"+article.boardNum;
				$($tempId).text(article.boardReadCount);
				
			}					
			
		}); // ajax
		
	}); // 게시글 팝업(modal) 수정 끝
	
	// 게시글 팝업(modal) 수정 : 전송
	$("button[id^=update_btn_]").click(function (e) {
		
		alert("글수정 요청");
		
		var boardNum = e.target.id.substring(17); // "updateContentBtn_" 뒤부분 "글번호" 취득
		
		var form = $('form#updateForm')[0];
        var formData = new FormData(form);
        
     	// 파일 필드 초기화 : 버그 패치(초기화하지 않으면 이전 업로드 파일이 반영됨)
        // 수정할 글이 원글이 아닌 댓글이면... : 댓글은 파일 업로드 없음
		if ($("[name=update_boardReLev]").val() == 0) {        
        	$("#update_boardFile_new").val("");
		}	
        
        $.ajax ({
			url : "${pageContext.request.contextPath}/notice/updateNotice.do/"+boardNum,

			cache: false,	 
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            
			type : "POST",
			data : formData,
			
			success : function (result) {
			
				alert(result);
								
				location.reload(); // 페이지 리프레시(재설정)
				
			}, 
			
			error : function(xhr, status) {
                 
                console.log(xhr+" : "+status); // 에러 코드
            } 
		}); // ajax
		
	}); // 게시글 팝업(modal) 수정 : 전송 끝 
	
	// 게시글 답글 쓰기(Modal)
	$("button[id^=replyContentBtn_]").click(function (e) {
		
		var boardNum = e.target.id.substring(17); // "updateContentBtn_" 뒤부분 "글번호" 취득
		
		alert(boardNum);
		
		$.ajax ({
			url : "${pageContext.request.contextPath}/notice/NoticeDetailJSON.do/boardNum/"+boardNum,
			contentType : "application/json",
			type : "POST",
			success : function (article) {
			
				// 기존 게시글 내용
				$("[name=boardNum]").val(article.boardNum);
				
				// 답글 관련 필드값 설정
				$("[name=boardReRef]").val(article.boardReRef);
				$("[name=boardReLev]").val(article.boardReLev);
				$("[name=boardReSeq]").val(article.boardReSeq);
				
				// 이중 답글 방지 : level=1 만 가능하도록 설정함
				if (article.boardReLev==1) {
					
					alert("이중 답글을 쓸 수 없습니다.");
					$("#replyModal").hide();
					location.reload();
					
				} //
			},
			
			error : function(xhr, status) {
                
                console.log(xhr+" : "+status); // 에러 코드
            } 
			
		}); // ajax 
		
	}); // 게시글 답글 쓰기(modal) 끝
	
	// 게시글 답글 처리
	$("button[id^=replySubmitBtn]").click(function (e) {
		
		alert("답글 쓰기 요청");
		alert("page : "+ "${pageVO.page}");
		
		var boardNum = e.target.id.substring(17); // "updateContentBtn_" 뒤부분 "글번호" 취득
		$("#page").val("${pageVO.page}");
		
		var form = $('form#boardReplyForm')[0];
        var formData = new FormData(form);
        
        $.ajax ({
			url : "${pageContext.request.contextPath}/notice/replyWriteNoticeProc.do",
			cache: false,	 
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            
			type : "POST",
			data : formData,
			
			success : function (result) {
			
				// alert(result);
				
				if (result.trim() == "true") {
					alert("답글 저장 성공");
				} else {
					alert("답글 저장 실패");
				}
				
				location.reload(); // 페이지 리프레시(재설정)
				
			}
		}); // ajax
		
	}); // 게시글 팝업(modal) 수정 : 전송 끝 
	
		
}); // jquery
</script>

</head>

<body ng-app="boardFormApp">
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
	<br>
	<hr>
	<!-- 인자들 -->
	<%-- <div>
		총 게시글 수 : ${pageVO.listCount}<br> 
		현재 페이지 : ${pageVO.page}<br>
		총 페이지 : ${pageVO.maxPage}<br> 
		시작 페이지 : ${pageVO.startPage}<br>
		끝 페이지 : ${pageVO.endPage}
	</div> --%>
	
	<!-- 게시글정보 보기(팝업) 시작 -->
	<%@ include file="viewNoticePopup.jspf" %>	
	<!-- 게시글정보 보기(팝업) 끝 -->
	
	<!-- 게시글정보 수정(팝업) 시작 -->
	<%@ include file="updateNoticePopup.jspf" %>
	<!-- 게시글정보 수정(팝업) 끝 -->
	
	<!-- 게시글 답글(댓글) 쓰기(팝업) 시작 -->
	<%@ include file="replyNoticePopup.jspf" %>
	<!-- 게시글 답글(댓글) 쓰기(팝업) 끝 -->

	<br>

	<!-- 게시판 리스트 시작 -->
	<section id="listForm" style="width: 800px; margin: auto;">

		<c:if test="${not empty articleList && pageVO.listCount > 0}">

			<!-- 게시글 부분 시작 -->
			<table id="board" class="table table-striped table-hover">

				<tr id="tr_top">
					<td>번호</td>
					<td>글번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>날짜</td>
					<td>조회수</td>
				</tr>

				<c:forEach var="article" items="${articleList}" varStatus="st">

					<tr>
						<td>${st.count + (pageVO.page-1)*10}</td>
						<td>${article.boardNum}</td>

						<td><c:choose>
								<c:when test="${article.boardReLev != 0}">
									<c:forEach var="a" begin="0" end="${article.boardReLev * 2}"
										step="1" varStatus="st">
										&nbsp;
									</c:forEach>
									 	▶ 
								</c:when>
								<c:otherwise>
									▶ 
								</c:otherwise>
							</c:choose> 
							
							<%-- <a href="../viewBoard.do/${article.boardNum}">
								${article.boardSubject}</a> --%>
								
							<a href="#?page=1" id="boardNum_${article.boardNum}"
										data-toggle="modal" 
										data-target="#myModal">
								${article.boardSub}
							</a>	
								
						</td>

						<td>${article.boardName}</td>
						<td><fmt:formatDate value="${article.boardDate}" pattern="yyyy년 MM월 dd일" /></td>
						<td id="boardReadCount_${article.boardNum}">
							${article.boardReadCount}
						</td>
					</tr>

				</c:forEach>

			</table>
			<!-- 게시글 부분 끝 -->
			<h6 align="right">
				<a href="../writeNoticeForm.do">게시판글쓰기</a>
			</h6>
			<!-- 페이징(paging) -->
			<section id="pageList" style="width: 800px; ">

				<ul class="pagination justify-content-center" style="width: 800px; ">

					<c:choose>
						<c:when test="${pageVO.page <= 1}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
							<li class="page-item">
								<a class="page-link" href="../noticeList.do/1">이전</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="../noticeList.do/${pageVO.page - 1}">이전</a>
							</li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="a" begin="${pageVO.startPage}"
						end="${pageVO.endPage}">

						<c:choose>
							<c:when test="${a == pageVO.page}">
								<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
								<li class="page-item active">
									<a class="page-link" href="../noticeList.do/${a}">${a}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="../noticeList.do/${a}">${a}</a>
								</li>
							</c:otherwise>
						</c:choose>

					</c:forEach>

					<c:choose>
						<c:when test="${pageVO.page >= pageVO.maxPage}">
							<li class="page-item">
								<a class="page-link" href="../noticeList.do/${pageVO.page}">다음</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
								<a class="page-link" href="../noticeList.do/${pageVO.page + 1}">다음</a>
							</li>
						</c:otherwise>
					</c:choose>

				</ul>

			</section>
			<!-- 페이징 끝 -->

		</c:if>

		<!-- 등록글 없을 경우 -->
		<c:if test="${empty articleList || pageVO.listCount==0}">
			<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:if>


	</section>
	<!-- 게시판 리스트 끝 -->

</body>
</html>
