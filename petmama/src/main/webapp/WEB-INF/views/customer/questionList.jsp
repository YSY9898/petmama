<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 - 자주묻는질문</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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

		<section class="slide_section">
			<div class="slide_msg">
				<span class="slide_msg_greeting">다정한 펫마마 고객님, 도움이 필요하신가요?</span></br> <span
					class="slide_msg_time">운영시간 : 평일 오전 11시 ~ 오후 5시</span>
			</div>
		</section>

		<div class="tab-container">

			<div class="tab-button">
				<button class="tab-btn" onclick="openTab('tab1')">방문 서비스</button>
				<button class="tab-btn" onclick="openTab('tab2')">이용요금</button>
				<button class="tab-btn" onclick="openTab('tab3')">변경 및 취소</button>
				<button class="tab-btn" onclick="openTab('tab4')">고객센터 문의</button>
			</div>

		</div>
			<div id="tab1" class="tab-content" style="display: block;">
			
				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>기본돌봄 이란?</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab1 tabcontent">
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
				<div class="tab1 tabcontent">
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
					<p>돌봄 서비스</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab2 tabcontent">
					<p>기본/고양이 서비스</p>
					<p>30분</p>
					<p>15,000원</p>
					<p>기본 추가 (30분)</p>
					<p>10,500원</p>
					<p>마리 추가</p>
					<p>5,000원</p>
					<p>대형견 (15~29kg)</p>
					<p>10,000원</p>
					<p>초대형견 (30kg~)</p>
					<p>15,000원</p>
					<p>공휴일/주말</p>
					<p>5,000원</p>
					<p>명절</p>
					<p>10,000원</p>
					<p>요청하는 서비스에 따라 마리 추가 금액이 발생할 수 있습니다.</p>
					<p>배식/배변처리(기본돌봄)와 산책을 희망하는 경우 기본돌봄에 산책 옵션을 추가해야 합니다.</p>
				</div>

				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>산책 서비스</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab2 tabcontent">
					<p>30분</p>
					<p>18,000원</p>
					<p>산책 옵션 (30분)</p>
					<p>10,500원</p>
					<p>마리 추가</p>
					<p>5,000원</p>
					<p>대형견 (15~29kg)</p>
					<p>10,000원</p>
					<p>초대형견 (30kg~)</p>
					<p>15,000원</p>
					<p>공휴일/주말</p>
					<p>5,000원</p>
					<p>명절</p>
					<p>10,000원</p>
					<p>요청하는 서비스에 따라 마리 추가 금액이 발생할 수 있습니다.</p>
					<p>배식/배변처리(기본돌봄)와 산책을 희망하는 경우 기본돌봄에 산책 옵션을 추가해야 합니다.</p>
				</div>
			</div>

			<div id="tab3" class="tab-content">
				<div class="toggle-btn" onclick="toggleContent(this);">
					<p>서비스 예약 변경 및 취소</p>
					<img
						src="${pageContext.request.contextPath}/images/customer/qna_arrow_down.png"
						width="25" height="25" class="my-photo">
				</div>
				<div class="tab3 tabcontent">
					<p>예약 변경</p>
					<p>• 돌봄 3일 전 : 변경 가능</p>
					<p>• 돌봄 1~2일 전 : 결제 금액의 20% 수수료 발생</p>
					<p>• 돌봄 당일 : 변경 불가</p>

					<p>예약 취소</p>
					<p>• 돌봄 3일 전 : 전액 환불</p>
					<p>• 돌봄 1~2일 전 : 결제 금액의 50% 환불</p>
					% 환불
					</p>
					<p>• 돌 봄 시작 3시간 이내 : 환불금 없음</p>
					<p>수수료는 할인 전 청구금액을 기준으로 합니다.</p>
				</div>
			</div>
			<div id="tab4" class="tab-content">
				<jsp:include page="/WEB-INF/views/customer/qnaList.jsp" />
			</div>
	</div>
</body>
</html>