<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 프로필 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/petsitter/style.css">
</head>
<body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<form id="reservation_form" action="${pageContext.request.contextPath}/member/reserve.do" method="post">
	<!-- 전달하려는 값 -->
	<input type="hidden" name="date" value="${date}">
	<input type="hidden" name="time" value="${time}">
	<input type="hidden" name="sis_work" value="${sis_work}">
	<input type="hidden" name="sis_num" value="${sis_num}">
	<input type="hidden" name="fee" value="${fee}">
	<input type="hidden" name="endtime" value="${endtime}">
	<div class="application">
		<!-- 
		<div class="main">
			<h2>펫시터 예약하기</h2>
		</div>
		-->
		<div class="main">
			<section class="head_section">
				<p>예약 정보</p>
				<div class="main_section">
					<article class="article">
						<div class="article_content">
							<p>방문 방식</p>
							<span class="select">
								<input type="radio" name="visit_status" id="select1" value="0" checked><label for="select1">펫시터 집으로 부르기</label>
								<input type="radio" name="visit_status"	id="select2" value="1"><label for="select2">펫시터의 집에 맡기기</label>
							</span>
						</div>
					</article>
					<article class="article">
						<div class="article_content">
							<p>날짜 : ${date}</p>
							<p>시작 시간 : ${time}</p>
							<p>선택하신 시간 : 
								<c:if test="${fee == '1'}">하루종일</c:if>
								<c:if test="${fee == '2'}">30분</c:if>
								<c:if test="${fee == '3'}">60분</c:if>
								<c:if test="${fee == '4'}">120분</c:if>
							</p>
							<p>종료 시간 : ${endtime}</p>
						</div>
					</article>
					<article class="article">
						<div class="article_content">
							<p>돌봄 유형 :
								<c:if test="${sis_work == '1'}">산책</c:if>
								<c:if test="${sis_work == '2'}">돌봄</c:if>
								<c:if test="${sis_work == '3'}">산책&돌봄</c:if>
							</p>
						</div>
					</article>
					<article class="article">
						<div class="article_content">
							<p>펫시터에게 남길 메모 :
								<input type="text" name="pet_note" id="pet_note" maxlength="90">
							</p>
						</div>
					</article>
					
					<article class="article">
						<div class="article_content">
							<input type="submit" style="width:380px;" value="등록">
							<input type="button" style="width:380px;" value="취소">
						</div>
					</article>
					
				</div>
				
				
			</section>
			
			
		</div>
	</div>
</form>
</body>
</html>