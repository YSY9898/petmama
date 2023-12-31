<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
<script type="text/javascript">
window.onload=function(){
	let myForm = document.getElementById("search_form");
	//이벤트 연결
	myForm.onsubmit=function(){
		let keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요!');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	};
};
</script>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="board_main">
		<div class="main_msg">
			<span class="main_msg_title">PetMama 공지게시판</span><br>
			<span class="main_msg_detail">PetMama 이용에 대한 공지사항 게시판입니다.</span>
		</div>
	</div>
	<div class="main-margin">
	<form id="search_form" action="noticelist.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" style="width:80px;height:30px;">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>작성자</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
					</select>
				</li>
				<li>
					<input type="search" size="20" style="width:300px;height:30px;" name="keyword" id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="검색" class="list-btn">
				</li>
			</ul>
		</form>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="table table-hover" style="background:white">
			<thead>
				<tr class="color">
					<th style="width:10%">글번호</th>
					<th style="width:50%">제목</th>
					<th style="width:10%">작성자</th>
					<th style="width:10%">작성일</th>
					<th style="width:10%">조회</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="board" items="${list}">
				<c:if test="${board.notice_status == 2}">
					<tr>
						<td><b>공지사항</b></td>
						<td class="title"><b><a href="noticedetail.do?notice_num=${board.notice_num}">${board.notice_title}</a></b></td>
						<td><b>관리자</b></td>
						<td><b>${board.notice_reg_date}</b></td>
						<td><b>${board.notice_hit}</b></td>
					</tr>
				</c:if>
			</c:forEach>
			<c:forEach var="board" items="${list}">
				<tr>
					<td>${board.notice_num}</td>
					<td class="title"><a href="noticedetail.do?notice_num=${board.notice_num}">${board.notice_title}</a></td>
					<td>
						<c:if test="${empty board.mem_nickname}">${board.mem_id}</c:if>
						<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
					</td>
					<td>${board.notice_reg_date}</td>
					<td>${board.notice_hit}${boardno.notice_status}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		</c:if>
		<div class="align-right" style="margin-top:20px">
			<c:if test="${user_auth == 9}">
			<input type="button" value="글쓰기" class="list-btn" onclick="location.href='noticewriteForm.do'">
			</c:if>
			<input type="button" value="목록" class="list-btn" onclick="location.href='noticelist.do'">
			<input type="button" value="홈으로" class="list-btn" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<c:if test="${count > 0}">
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>