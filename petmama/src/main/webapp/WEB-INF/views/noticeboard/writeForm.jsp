<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="board_main">
		<div class="main_msg">
			<span class="main_msg_title">PetMama 공지사항 글쓰기</span><br>
			<span class="main_msg_detail">공지사항을 작성하세요.</span>
		</div>
	</div>
	<div class="main-margin">
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$('#write_form').submit(function(){
				if($('input[type=radio]:checked').length < 1){
					alert('전체 공지 게시 여부를 지정하세요!');
					return false;
				}
				if($('#title').val().trim() == ''){
					alert('제목을 입력하세요.');
					$('#title').val('').focus();
					return false;
				}
				if($('#content').val().trim() == ''){
					alert('내용을 입력하세요.');
					$('#content').val('').focus();
					return false;
				}
			});
		});
		</script>
		<form id="write_form" action="noticewrite.do" method="post" enctype="multipart/form-data">
		<div class="notice_select">
			<label>&lt;전체 공지 게시 여부&gt;</label>
				<input type="radio" name="status" value="1" id="status2" checked>미공지 
				<input type="radio" name="status" value="2" id="status1" >전체 공지                  
		</div>
		<div class="row mb-3">
			<label for="title" class="col-sm-2 col-form-label">제목</label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="title" id="title">
			</div>
		</div>
		<div class="row mb-3">
			<label for="content" class="col-sm-2 col-form-label">내용</label>
			<div class="col-sm-10">
				<textarea class="form-control write-textarea-height" name="content" id="content"></textarea>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-2 col-form-label">파일</div>
			<div class="col-sm-10">
				<input type="file" name="filename" id="filename"  accept="image/gif,image/png,image/jpeg">
			</div>
		</div>
		<div class="write-btn">
			<input type="submit" value="등록" class="list-btn">
			<input type="button" value="목록" class="list-btn" onclick="location.href='noticelist.do'">
		</div>
		</form>
	</div>
</div>
</body>
</html>