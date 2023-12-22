<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 작성</title>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$('#write_form').submit(function(){
				if($('#title').val().trim()==''){
					alert('제목을 입력하세요.');
					$('#title').val('').focus();
					return false;
				}	
				if($('#content').val().trim()==''){
					alert('내용을 입력하세요.');
					$('#content').val('').focus();
					return false;
				}
			});
		});
		</script>
		<div class="container-fluid bg-info bg-opacity-50" style="padding:100px 20px;">
	      <h3 class="fw-bold text-center text-white text-center">PetMama 후기게시판 글쓰기</h3>
	      <br><br>
	      <h5 class="text-center text-white text-center">PetMama 펫시터는 어떠셨나요?</h5>
	  	</div>
	  	
	  	<div class="container d-flex justify-content-center">
		<div class="col-8 col8md-4">
		<form id="write_form" action="write2.do" method="post" enctype="multipart/form-data">
		<br><br><br><br>
		<h4 class="fw-bold">게시판 글쓰기</h4>
		<hr><br><br>	
			<ul class="list-unstyled">
				<li class="form-floating mb-3">
					<label for="title">제목을 입력해주세요</label>
					<input type="text" name="title" id="title" maxlength="40" 
						class="input-check form-control rounded-3 bg-body-tertiary border-0" placeholder="제목">
				</li>
				<li>
					<textarea rows="30" cols="30" name="content" id="content"
						class="form-control write-textarea-height" placeholder="내용을 입력해주세요"></textarea>
				</li>
			</ul>
			<br>
			<ul class="list-unstyled">	
				<li>
					<input type="file" name="filename" id="filename" 
					accept="image/gif,image/png,image/jpeg" class="input-check form-control rounded-3 bg-body-tertiary border-0"
					placeholder="image">
				</li>
			</ul>
			<br><br>
			
			<div>
				<input type="submit" value="등록" class="btn btn-primary">
				<input type="button" value="목록" onclick="location.href='list2.do'" class="btn btn-primary">
			</div>
			</form>
			<br><br><br><br>
		</div>	
	</div>
</div>
</div>
</body>
</html>