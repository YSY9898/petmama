<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글수정하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-list-main">
		<h2><b>PetMama 게시판 글 수정하기</b></h2>
		<p>PetMama 회원들이 자유롭게 글을 올릴 수 있는 게시판입니다.<br>우리 모두 PetMama에서 소통해요!</p>
	<div>
		<form id="update_form" action="update.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="board_num" value="${board.board_num}">
			<div class="row mb-3">
				<label for="title" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" name="title" id="title" value="${board.title}">
				</div>
			</div>
			<div class="row mb-3">
				<label for="content" class="col-sm-2 col-form-label">내용</label>
				<div class="col-sm-10">
					<textarea class="form-control write-textarea-height" name="content" id="content">${board.content}</textarea>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 col-form-label">파일</div>
				<div class="col-sm-10">
					<input type="file" name="filename" id="filename"  accept="image/gif,image/png,image/jpeg">
					<c:if test="${!empty board.filename}">
						<div id="file_detail">
							(${board.filename})파일이 등록되어 있습니다.
							<input type="button" value="삭제" id="file_del">
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
						</div>
					</c:if>
				</div>
			</div>
			<div class="write-btn">
				<input type="submit" value="수정" class="list-btn">
				<input type="button" value="목록" class="list-btn" onclick="location.href='list.do'">
			</div>
		</form>
	</div>
	</div>
</div>
</body>
</html>