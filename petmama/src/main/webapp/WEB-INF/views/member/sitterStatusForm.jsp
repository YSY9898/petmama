<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[관리자]펫시터 상태 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/board/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>펫시터 상태 수정</h2>
		<form action="sitterModifyStatus.do" method="post" id="status_modify">
			<input type="hidden" name="sis_num" value="${petsitter.sis_num}">
			<ul>
				<li>
					<label>펫시터 상태</label>
					<input type="radio" name="status" id="status1" value="0" <c:if test="${petsitter.sis_condition == 0}">checked</c:if>>대기
					<input type="radio" name="status" id="status2" value="1" <c:if test="${petsitter.sis_condition == 1}">checked</c:if>>시터회원
					<input type="radio" name="status" id="status3" value="2" <c:if test="${petsitter.sis_condition == 2}">checked</c:if>>정지회원
				</li>
			</ul>
			<div class="align-center">
				<c:if test="${petsitter.sis_num != 3}">
				<input type="submit" value="수정" class="list-btn">
				</c:if>
				<input type="button" value="펫시터 상세" onclick="location.href='sitterAdminDetail.do?sis_num=${petsitter.sis_num}'" class="list-btn">
			</div>
		</form>
	</div>
</div>
</body>
</html>