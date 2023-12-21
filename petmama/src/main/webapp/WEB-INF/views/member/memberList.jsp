<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<script type="text/javascript">
window.onload=function(){
	let myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		let keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<br><br>
	<div class="content-main">
		<h2 class="fw-bold">회원목록(관리자 전용)</h2>
		<br><br>
		<form id="search_form" action="adminList.do" method="get">
			<div class="search d-flex justify-content-center">
				<div>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>ID</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>이름</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>email</option>
					</select>
				</div>
				<div>	
					<input type="search" size="16" name="keyword" id="keyword"
					                                      value="${param.keyword}">
				</div>
				<div>
					<input type="submit" value="찾기">
				</div>
			</div>
			<br><br>
		</form>
		<div class="list-space align-right">
			<input type="button" value="목록" class="btn btn-primary btn-block btn-sm m-t-md"
			     onclick="location.href='adminList.do'">
			<input type="button" value="홈으로" class="btn btn-primary btn-block btn-sm m-t-md"
			    onclick="location.href='${pageContext.request.contextPath}/main/main.do'">     
		</div>
		<br>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 회원정보가 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="table table-striped">
			<thead class="thead-dark">
			<tr>
				<th>ID</th>
				<th>이름</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>가입일</th>
				<th>등급</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="member" items="${list}">
			<tr>
				<td>
					<c:if test="${member.mem_auth > 0}">
					<a href="adminUserForm.do?mem_num=${member.mem_num}">${member.mem_id}</a>
					</c:if>
					<c:if test="${member.mem_auth == 0}">
					${member.mem_id}	
					</c:if>
				</td>
				<td>${member.mem_name}</td>
				<td>${member.mem_email}</td>
				<td>${member.mem_cell}</td>
				<td>${member.mem_rdate}</td>
				<td>
					<c:if test="${member.mem_auth == 0}">탈퇴</c:if>
					<c:if test="${member.mem_auth == 1}">정지</c:if>
					<c:if test="${member.mem_auth == 2}">일반</c:if>
					<c:if test="${member.mem_auth == 9}">관리</c:if>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<br><br>
		
		<nav aria-label="...">
		  <ul class="pagination pagination-sm justify-content-center">
		    <li class="page-item active" aria-current="page">
		      <span class="page-link">${page}</span>
		    </li> 
		  </ul>
		</nav>
		</c:if>
	</div>
</div>
</body>
</html>


