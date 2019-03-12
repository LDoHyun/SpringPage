<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
 <meta charset="UTF-8">
 <title>게시글 보기</title>
 
  <style>
	section#viewForm
	{
		width:600px;
	}
	
	/* 글내용 쓰기 필드 크기 조절 방지 */
	textarea 
	{
		resize: none;
	}
	
	/* 에러 메시지 글자 : tr */
	tr.err_msg
	{
		color:red;
		text-indent:6em;
	}
	
	/* 읽기 전용 문단 처리 */
	input[readonly].fld_background, textarea[readonly].fld_background
	{
		background-color:transparent;
		border:0;
	}
 </style>
	
 <!-- bootstrap CSS : 4.2.1 -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

 <!-- bootstrap JS : 4.2.1 -->
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>

</head>

<body>
	  
	<!-- 게시글 보기 시작 -->
	<section id="viewForm" class="container">
	
		<h3>게시글 보기</h3>
		
		<!-- bootstrap table 적용 -->  
		<table class="table">
			
			<tr class="form-group">
				<td class="col-xs-2">
					<label for="boardName" class="control-label">
						<span style="color:red">*</span>글쓴이
					</label>
				</td>
				<td class="col-xs-10">
					<input type="text" 
						   id="boardName" 
						   name="boardName"
						   readonly
					       class="form-control fld_background" 
					       value="${board.boardName}"/>
		        </td>
			</tr>
			
			<tr>
				<td>
					<label for="boardSub" class="control-label">
						<span style="color:red">*</span>제 목
					</label>
				</td>
				<td>
					<input name="boardSub" 
						   type="text"
					       id="boardSub" 
					       class="form-control fld_background" 
					       readonly
					       value="${board.boardSub}" />
		       </td>
			</tr>
			
			<tr>
				<td>
					<label for="boardContent" class="control-label">
						<span style="color:red">*</span>내 용
					</label>
				</td>
				<td>
					<textarea id="boardContent" 
							  name="boardContent"
							  cols="40" 
							  rows="15" 
							  readonly
							  class="form-control fld_background">${board.boardContent}</textarea>
			     </td>
			</tr>
			
			<tr>
				<td>
					<label for="boardFile" class="control-label">
						 파일 첨부 
					</label>
				</td>
				<td>
					<c:if test="${empty board.boardFile}">
						업로드 파일 없음
					</c:if> 
					
					<c:if test="${not empty board.boardFile}">
						
						<c:set var="uploadFilePath" 
							   value="${pageContext.request.contextPath}/noticeUpload/${boarde.boardFile}" />
						
						<c:set var="uploadFileName" value="${board.boardFile}" />	
						
						<a href="<c:url value="/upload/${board.boardFile}"/>" 
						   id="boardFile" name="boardFile">
		          			${uploadFileName}
	          			</a>   
					</c:if>
		          	
			    </td>
			</tr>
			
		</table>
		
	</section>
	<!-- 게시글 보기 끝 -->
	
</body>
</html>