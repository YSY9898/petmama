<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 - 자주묻는질문</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/customer/style.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	type="text/javascript"></script>
<script>
	function openTab(tabName) {
		var i, tabContent;
		tabContent = document.getElementsByClassName("tab-content");
		for (i = 0; i < tabContent.length; i++) {
			tabContent[i].style.display = "none";
		}
		document.getElementById(tabName).style.display = "block";
	}

	function toggleContent(obj) {
		if ($(obj).next().hasClass("active")) {
			$(obj).next().hide();
			$(obj).next().removeClass("active");
			$(obj).find('img').attr("src",
					"/petmama/images/customer/qna_arrow_down.png");
		} else {
			$(obj).next().show();
			$(obj).next().addClass("active");
			$(obj).find('img').attr("src",
					"/petmama/images/customer/qna_arrow_up.png");
		}
	}
</script>
</head>

<body>
	<div>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="slide_msg">
			<span>다정한 펫마마 고객님, 도움이 필요하신가요?</span></br> <span>운영시간 : 평일 오전 11시 ~
				오후 5시</span>
		</div>

		<div class="tab-container">
			<button class="tab-btn" onclick="openTab('tab1')">방문 서비스</button>
			<button class="tab-btn" onclick="openTab('tab2')">이용요금</button>
			<button class="tab-btn" onclick="openTab('tab3')">변경 및 취소</button>
			<button class="tab-btn" onclick="openTab('tab4')">펫시터 문의</button>

			<div id="tab1" class="tab-content">
			<jsp:include page="/WEB-INF/views/customer/qnaList.jsp" />
				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>기본돌봄 이란?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab1 content">
					<p>도그메이트 펫시터가 고객의 집으로 찾아가 돌봄을 진행합니다.</p>
					<p>기본 30분 진행</p>
					<p>배식/급수</p>
					<p>배변 처리</p>
					<p>환경 정리</p>
					<p>요청사항 수행</p>
					<p>기본돌봄만 진행하는 경우 산책은 불가합니다.</p>
					<p>기본돌봄 범위에 해당하지 않는 요청사항 수행은 불가합니다.</p>
					<p>별도 요청사항이 없는 경우 기본돌봄 내용대로 진행됩니다.</p>
					<p>(수돗물 급여, 용변 변기처리, 쓰레기 휴지통 처리)</p>
				</div>

				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>산책돌봄 이란?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab1 content">
					<p>도그메이트 펫시터가 고객의 집으로 찾아가 산책을 진행합니다.</p>
					<p>기본 60분 진행</p>
					<p>산책준비 (하네스 및 이중산책줄 착용)</p>
					<p>산책</p>
					<p>산책 마무리 (발 닦기)</p>
					<p>최대 120분까지 가능합니다.</p>
					<p>반려동물 중 일부만 선택하여 신청 가능합니다.</p>
					<p>산책돌봄의 경우 기본돌봄 진행은 불가합니다.</p>
					<p>산책돌봄의 시간 추가를 원하는 경우 산책 옵션을 추가해야 합니다.</p>
					<p>별도의 요청사항이 없는 경우 기본돌봄 내용대로 진행됩니다.(물티슈 발세척)</p>
				</div>
			</div>
			
			<div id="tab2" class="tab-content">
				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>기본 돌봄이란2?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab2 content">
					<h2>여기에 내용이 들어갑니다</h2>
					<p>이 부분은 버튼을 누르면 나타나거나 사라집니다.</p>
				</div>

				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>기본 산책이란2?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab2 content">
					<h2>여기에 내용이 들어갑니다</h2>
					<p>이 부분은 버튼을 누르면 나타나거나 사라집니다.</p>
				</div>
			</div>

			<div id="tab3" class="tab-content">
				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>기본 돌봄이란3?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab3 content">
					<h2>여기에 내용이 들어갑니다</h2>
					<p>이 부분은 버튼을 누르면 나타나거나 사라집니다.</p>
				</div> 

				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>기본 산책이란3?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab3 content">
					<h2>여기에 내용이 들어갑니다</h2>
					<p>이 부분은 버튼을 누르면 나타나거나 사라집니다.</p>
				</div>
			</div>
			<div id="tab4" class="tab-content">
			</div>
		</div>
	</div>
</body>
</html>
