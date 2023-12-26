<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 지원하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div>
	<h3>펫시터 지원 상세 페이지</h3>
	<br><br>
	<table class="table">
		<tr>
			<th>펫시터 번호</th>
			<th>펫시터 이름</th>
			<th>펫시터 상태</th>
			<th>펫시터 유형</th>
		</tr>
		<tr>
			<td>${list.sis_num}</td>
			<td>${list.sis_name}</td>
			<td>
				<c:if test="${list.sis_condition == 0}">대기</c:if>
				<c:if test="${list.sis_condition == 1}">시터회원</c:if>
				<c:if test="${list.sis_condition == 2}">정지회원</c:if>
				<c:if test="${list.sis_condition == 3}">탈퇴회원</c:if>
			</td>
			<td>
				<c:if test="${list.sis_work == 1}">산책</c:if>
				<c:if test="${list.sis_work == 2}">돌봄</c:if>
				<c:if test="${list.sis_work == 3}">산책&돌봄</c:if>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<th>전화번호</th>
			<th>우편번호</th>
			<th>주소</th>
			<th>상세주소</th>
		</tr>
		<tr>
			<td>${list.sis_email}</td>
			<td>${list.sis_phone}</td>
			<td>${list.sis_zipcode}</td>
			<td>${list.sis_address1}</td>
			<td>${list.sis_address2}</td>
		</tr>
		<tr>
			<th>프로필 사진</th>
			<th>소개 사진</th>
			<th>소개 제목</th>
			<th>소개 태그</th>
		</tr>
		<tr>
			<td>
				<img src="${pageContext.request.contextPath}/upload/${list.sis_photo1}" class="detail-img" width="300px">
			</td>
			<td>
				<img src="${pageContext.request.contextPath}/upload/${list.sis_photo2}" class="detail-img" width="400px">
			</td>
			<td>${list.title}</td>
			<td>${list.tag}</td>
		</tr>
		<tr>	
			<th>지원일</th>
			<th>수락일</th>
		</tr>
		<tr>			
			<td>${list.sis_apply_date}</td>
			<td>${list.sis_accept_date}</td>
		</tr>
	</table>
	<ul>
		<li class="align-center">
			<input type="button" class="list-btn" value="펫시터 상태 수정" 
			 onclick="location.href='sitterStatusForm.do?sis_num=${list.sis_num}'">
			<input type="button" class="list-btn" value="펫시터 목록" 
			  onclick="location.href='sitterAdminList.do'">  
		</li>
	</ul>
</div>
</body>
</html>