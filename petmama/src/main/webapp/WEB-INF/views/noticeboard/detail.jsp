<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지 게시판 상세 정보</title>	
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="board_main">
		<div class="main_msg">
			<span class="main_msg_title">PetMama 공지 게시글 상세보기</span><br>
			<span class="main_msg_detail">선택한 공지 게시글의 상세 내용을 보여줍니다.</span>
		</div>
	</div>
	<div class="main-margin">
		<h2>${board.notice_title}</h2>
		<ul>
			<li class="detail-title">
				<c:if test="${!empty board.pet_photo}">
				<img src="${pageContext.request.contextPath}/upload/${board.pet_photo}" width="40" height="40" class="detail-title-photo">
				</c:if>
				<c:if test="${empty board.pet_photo}">
				<img src="${pageContext.request.contextPath}/images/face.png" width="40" height="40" class="detail-title-photo">
				</c:if>
			</li>
			<li class="detail-title">
				${board.mem_nickname}<br>
				조회 : ${board.notice_hit}
			</li>
			<li class="detail-title float-right">
				작성일 : ${board.notice_reg_date}<br>
				<c:if test="${!empty board.notice_modify_date}">
					(최근 수정일 : ${board.notice_modify_date})
				</c:if>
			</li>
		</ul>
		<hr size="0" noshade="noshade" width="100%">
		<c:if test="${!empty board.notice_filename}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${board.notice_filename}" class="detail-img">
		</div>
		</c:if>
		<p>
			${board.notice_content}
		</p>
		<hr size="1" noshade="noshade" width="100%">
		<div>
			<ul class="detail-ul-height">
				<li class="float-right" style="margin-left: auto; margin-right: auto;">
					<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정, 삭제 가능 --%>
					<input type="button" value="목록" class="list-btn" onclick="location.href='noticelist.do'">
					<c:if test="${user_num == board.mem_num || user_auth == 9}">
					<input type="button" value="수정" class="list-btn" onclick="location.href='noticeupdateForm.do?notice_num=${board.notice_num}'">
					</c:if>
					<c:if test="${user_num == board.mem_num || user_auth == 9}">
					<input type="button" value="삭제" class="list-btn" id="delete_btn">
					<script type="text/javascript">
						let delete_btn = document.getElementById('delete_btn');
						delete_btn.onclick=function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								location.replace('noticedelete.do?notice_num=${board.notice_num}');
							}
						};
					</script>
					</c:if>
				</li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>