<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board2/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#update_form').submit(function(){
		if($('#title').val()trim()==''){
			alert('제목을 입력하세요');
			$('#title').val('').focus();
			return false;
		}
		if($('#content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#content').val('').focus();
			return false;
		}
	});
});
</script>
<script type="text/javascript">
							$(function(){
								$('#file_del').click(function(){
									let choice = confirm('삭제하시겠습니까?');
									if(choice){
										$.ajax({
											url:'deleteFile.do',
											type:'post',
											data:{board_num:${board.board_num}},
											dataType:'json',
											success:function(param){
												if(param.result == 'logout'){
													alert('로그인 후 사용하세요');
												}else if(param.result == 'success'){
													$('#file_detail').hide();
												}else if(param.result == 'wrongAccess'){
													alert('잘못된 접속입니다.');
												}else{
													alert('파일 삭제 오류 발생');
												}
											},
											error:function(){
												alert('네트워크 오류 발생');
											}
										});
									}
								});
							});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="container-fluid bg-info bg-opacity-50" style="padding:100px 20px;">
	      <h3 class="fw-bold text-center text-white text-center">PetMama 후기게시판 글쓰기</h3>
	      <br><br>
	      <h5 class="text-center text-white text-center">PetMama 펫시터는 어떠셨나요?</h5>
	  	</div>
	  	
<div class="page-main">
	<div class="content-main">
	<div class="container d-flex justify-content-center">
		<div class="col-8 col8md-4">
	<form id="update_form" action="update.do" method="post"
		                       enctype="multipart/form-data">
		    <input type="hidden" name="board_num" 
		                            value="${board.board_num}">                   
			<br><br><br>
			<h4 class="fw-bold">게시판 후기 수정</h4>
			<hr><br><br>
			<ul class="list-unstyled">
				<li class="form-floating mb-3">
					<input type="text" name="title" id="title" maxlength="40" 
						class="input-check form-control rounded-3 bg-body-tertiary border-0" 
						placeholder="제목" value="${board.title}">
				</li>
				<li>
					<textarea rows="30" cols="30" name="content" id="content"
						class="form-control write-textarea-height">${board.content}</textarea>
				</li>
			</ul>
			<br>
			<ul class="list-unstyled">
				<li>
					<label for="filename">파일</label>
					<input type="file" name="filename"
					  id="filename" accept="image/gif,image/png,image/jpeg">
					<c:if test="${!empty board.filename}">
					<div id="file_detail">
						(${board.filename})파일이 등록되어 있습니다.
						<input type="button" value="파일삭제"
						                       id="file_del">
					</div>	                       
					</c:if> 	                       
				</li>
			</ul>	

			<div>
				<input type="submit" value="수정" class="btn btn-primary">
				<input type="button" value="목록" onclick="location.href='list2.do'" class="btn btn-primary">
			</div>
			</form>			                       			                       
			</div> 
		  </div>
		</div>
	</div>
</body>
</html>