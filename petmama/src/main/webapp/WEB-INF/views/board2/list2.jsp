<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board2/style.css">
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container-fluid bg-info bg-opacity-50" style="padding:100px 20px;">
	      <h3 class="fw-bold text-center text-white text-center">PetMama 후기게시판 글쓰기</h3>
	      <br><br>
	      <h5 class="text-center text-white text-center">PetMama 펫시터는 어떠셨나요?</h5>
</div>
<br><br>	  	
<div class="page-main">
	<div class="content-main">
		<div class="container">
		<form id="search_form" action="list2.do" method="get"> <!-- 검색을 제외하고 데이터베이스를 전송할땐 post방식 써야함 -->
			<ul class="search search d-flex justify-content-center list-unstyled">
				<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>작성자</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="검색" class="btn btn-primary btn-sm">
				</li>
			</ul>
		</form>
		<br>
		
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">

		<table class="table">
		<thead class="table-light">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회</th>
			</tr>
		</thead>
		<tbody>	
			<c:forEach var="board1" items="${list}">
			<tr>
				<td>${board1.board_num}</td>
				<td><a href="detail2.do?board_num=${board1.board_num}">${board1.title}</a></td>
				<td>
					<c:if test="${!empty board1.mem_nickname}">${board1.mem_nickname}</c:if>
					<c:if test="${empty board1.mem_nickname}">${board1.mem_id}</c:if>
				</td>
				<td>${board1.reg_date}</td>
				<td>${board1.hit}</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>	
		
		<div class="list-space d-flex mb-3">
			<div class="me-auto p-2">
			<input type="button" value="글쓰기" onclick="location.href='writeForm2.do'" class="btn btn-primary btn-sm"
				<c:if test="${empty user_num}">disabled="disabled"</c:if>> <!-- 경로가 같기 떄문에 writeForm.do라고 명시 -->
			</div>	
			<div class="p-2">
			<input type="button" value="목록" onclick="location.href='list2.do'" class="btn btn-primary btn-sm">
			</div>
			<div class="p-2">
			<input type="button" value="홈으로" class="btn btn-primary btn-sm"
				onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>	
		</div>
		<br>
		<ul class="pagination pagination-sm justify-content-center">
		    <li class="page-item active" aria-current="page">
		      ${page}
		    </li> 
		</ul>
		</c:if>
		
		
	</div>
</div>
</div>
</body>
</html>