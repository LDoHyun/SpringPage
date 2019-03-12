<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메시지</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<script>
$(function() {
	
	$('#myModal').modal();
	
	$('#close_btn').click(function() {
		location.href="${pageContext.request.contextPath}/admin/user/userlistpaging?curPage=1";
	});
}); 
</script>
</head>
<body>

<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        
        <!-- Modal body -->
        <div class="modal-body" style="text-align:center">
          ${msg}
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button id="close_btn"
          		  type="button" 
          		  class="btn btn-danger" 
          		  data-dismiss="modal">창닫기</button>
        </div>
        
      </div>
    </div>
  </div>
  
</body>
</html>