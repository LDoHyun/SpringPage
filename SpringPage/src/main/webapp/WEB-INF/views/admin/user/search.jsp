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
td.search_td {
   border:1px solid white; 
}
</style>
</head>
<body>

	<div id="search_pnl" class="form-group">
		<form class="form-inline" name="userlistsearch" 
			  action="userlistsearch" method="post">
		<table>
		<tr>
			<td class = "search_td">
			<input type="text" 
				   id="searchWord" name="searchWord" size="20" />
			</td>
			<td class = "search_td">
			<select class="form-control mb-2 mr-sm-2" 
					id="searchKey" name="searchKey">
				<option value="username">아이디</option>
				<option value="name">이름</option>
			</select>
			</td>
			<td class = "search_td">
			<input type="submit" class="btn btn-primary mb-2" value="검색">
			</td>
		</tr>
		</table>	
		</form>
		
	</div>

</body>
</html>