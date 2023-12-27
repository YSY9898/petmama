<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<br><br>
	<div class="content-main">
		<h2 class="fw-bold">펫시터 목록(관리자 전용)</h2>
		<br><br>
	</div>
	<div>
	<c:if test="${count == 0}">
	<div class="result-display">
		표시할 주문 내역이 없습니다.
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="table table-striped">
		<tr>
			<th>펫시터 번호</th>
			<th>펫시터 이름</th>
			<th>펫시터 상태</th>
			<th>펫시터 지원일</th>
		</tr>
	<c:forEach var="list" items="${list}">
			<tr>
				<td><a href="sitterAdminDetail.do?sis_num=${list.sis_num}">${list.sis_num}</a></td>
				<td>${list.sis_name}</td>
				<td>
					<c:if test="${list.sis_condition == 0}">대기</c:if>
					<c:if test="${list.sis_condition == 1}">시터회원</c:if>
					<c:if test="${list.sis_condition == 2}">정지회원</c:if>
					<c:if test="${list.sis_condition == 3}">탈퇴회원</c:if>
				</td>
				<td>${list.sis_apply_date}</td>
			</tr>	
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>