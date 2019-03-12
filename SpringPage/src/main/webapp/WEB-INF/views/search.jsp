<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>회원정보 검색</title>
<style>
div#search_pnl
{
/* 	background:yellow;  */
	float:left;
	width:200px;
	height:s0px;
	display:flex;
	align-items:center;
	justify-content:center;
}	
</style>
</head>
<body>

	<div id="search_pnl" class="form-group">
	
		<form class="form-inline" name="boardsearch" 
			  action="boardsearch" method="post">
			
			<select class="form-control mb-2 mr-sm-2" 
					id="searchKey" name="searchKey">
				<option value="boardName">글쓴이</option>
				<option value="boardSub">제목</option>
			</select>
			
			<input type="text" 
				   id="searchWord" name="searchWord" size="20" />
			
			<input type="submit" class="btn btn-primary mb-2" value="검색">
			
		</form>
		
	</div>

</body>
</html>