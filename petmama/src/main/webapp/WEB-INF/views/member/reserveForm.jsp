<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 프로필 리스트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/petsitter/style.css">
</head>
<body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>

<div class="page_main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h4>펫시터 예약하기</h4>
		<form id="reservation_form" action="${pageContext.request.contextPath}/member/reserve.do" method="post">
			<input type="hidden" name="date" value="${date}">
			<input type="hidden" name="time" value="${time}">
			<input type="hidden" name="sis_work" value="${sis_work}">
			<input type="hidden" name="sis_num" value="${sis_num}">
			<input type="hidden" name="fee" value="${fee}">
			
			<ul>
				<li>
					<label>예약 방식</label>
					<input type="radio" name="visit_status" value="0" checked>펫시터 집으로 부르기
					<input type="radio" name="visit_status"	value="1">펫시터 집에 맡기기
				</li>
				<li>
					<div><c:if test="${sis_work == '1'}">산책</c:if></div>
					<div><c:if test="${sis_work == '2'}">돌봄</c:if></div>
					<div><c:if test="${sis_work == '3'}">산책&돌봄</c:if></div>
				</li>
				<li>
					<div>시작 시간 : ${time}</div>
					<div>선택하신 시간 : 
						<c:if test="${fee == '1'}">하루종일</c:if>
						<c:if test="${fee == '2'}">30분</c:if>
						<c:if test="${fee == '3'}">60분</c:if>
						<c:if test="${fee == '4'}">120분</c:if>
					</div>
				</li>
				<li>
					<label for="pet_note">펫시터에게 전달할 내용</label>
					<input type="text" name="pet_note" id="pet_note" maxlength="90">
				</li>
			</ul>
			<input type="submit" value="등록">
			<input type="button" value="취소">
		</form>
	</div>
</div>
</body>
</html>