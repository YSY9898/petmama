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
	<div class="board_main">
		<div class="main_msg">
			<span class="main_msg_title">공지 게시글 수정</span><br>
			<span class="main_msg_detail">공지 게시글을 수정합니다.</span>
		</div>
	</div>
	<div class="main-margin">
		<form id="update_form" action="noticeupdate.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="notice_num" value="${board.notice_num}">
			<div class="notice_select">
			  <label>&lt;전체 공지 게시 여부&gt;</label>
				<input type="radio" name="notice_status" value="1" id="status1" <c:if test="${board.notice_status == 1}">checked</c:if>>전체 공지
				<input type="radio" name="notice_status" value="2" id="status2" <c:if test="${board.notice_status == 2}">checked</c:if>>미공지                   
			</div>
			<div class="row mb-3">
				<label for="title" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" name="notice_title" id="notice_title" value="${board.notice_title}">
				</div>
			</div>
			<div class="row mb-3">
				<label for="content" class="col-sm-2 col-form-label">내용</label>
				<div class="col-sm-10">
					<textarea class="form-control write-textarea-height" name="notice_content" id="notice_content">${board.notice_content}</textarea>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-sm-2 col-form-label">파일</div>
				<div class="col-sm-10">
					<input type="file" name="notice_filename" id="notice_filename"  accept="image/gif,image/png,image/jpeg">
					<c:if test="${!empty board.notice_filename}">
						<div id="file_detail">
							(${board.notice_filename})파일이 등록되어 있습니다.
							<input type="button" value="삭제" id="file_del">
							<script type="text/javascript">
								$(function(){
									$('#file_del').click(function(){
										let choice = confirm('삭제하시겠습니까?');
										if(choice){
											$.ajax({
												url:'noticedeleteFile.do',
												type:'post',
												data:{notice_num:${board.notice_num}},
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
				</form>
			</div>
		<div class="write-btn">
			<input type="submit" value="수정" class="list-btn">
			<input type="button" value="목록" class="list-btn" onclick="location.href='noticelist.do'">
		</div>
</div>
</body>
</html>