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
	<div class="page-list-main">
		<h2><b>PetMama 게시판</b></h2>
		<p>PetMama 회원들이 자유롭게 글을 올릴 수 있는 게시판입니다.<br>우리 모두 PetMama에서 소통해요!</p>
		<div>
		<form id="search_form" action="list.do" method="get">
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
		</div>
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
			<c:forEach var="board" items="${list}">
			<tbody>
				<tr>
					<td>${board.board_num}</td>
					<td class="title"><a href="detail.do?board_num=${board.board_num}">${board.title}</a></td>
					<td>
						<c:if test="${empty board.mem_nickname}">${board.mem_id}</c:if>
						<c:if test="${!empty board.mem_nickname}">${board.mem_nickname}</c:if>
					</td>
					<td>${board.reg_date}</td>
					<td>${board.hit}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="align-right" style="margin-top:20px">
			<c:if test="${!empty user_num}">
			<input type="button" value="글쓰기" class="list-btn" onclick="location.href='writeForm.do'">
			</c:if>
			<input type="button" value="목록" class="list-btn" onclick="location.href='list.do'">
			<input type="button" value="홈으로" class="list-btn" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>