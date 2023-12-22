<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage/reservlist.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>예약 현황</title>
</head>
<script>
	$(function(){
		const searchParams = new URLSearchParams(location.search);
	
		for (const param of searchParams) {
		  if(param[0] == 'keyfield') {
		  	$(".align-center a").eq(0).attr("href", $(".align-center a").eq(0).attr("href") + "&keyfield=" + param[1]);
		  	$(".align-center a").eq(1).attr("href", $(".align-center a").eq(1).attr("href") + "&keyfield=" + param[1]);
		  	$(".align-center a").eq(2).attr("href", $(".align-center a").eq(2).attr("href") + "&keyfield=" + param[1]);
		  	$(".align-center a").eq(3).attr("href", $(".align-center a").eq(3).attr("href") + "&keyfield=" + param[1]);
		  	$(".align-center a").eq(4).attr("href", $(".align-center a").eq(4).attr("href") + "&keyfield=" + param[1]);
		  }
		}
	});
	
	function beforeSearchReserv(beforeORafter) {
		if(beforeORafter == 0) {
				$("#keyfield").val("ing");
			} else {
				$("#keyfield").val("after");
		}
		$("#search_form").submit();
	}
</script>
<!-- header 시작 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<!-- header 끝 -->
<!-- side bar 시작 -->
<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
<!-- side bar 끝 -->
<body>
	<div class="page-main d-flex justify-content-around">
		<div class="content-main">
			<br> <br>
			<h2 class="text-center fw-bold">예약현황</h2>
			<br> <br>

		<form id="search_form" action="list.do" method="get" onsubmit="beforeSearchReserv">
		<input type="hidden" id="keyfield" name="keyfield" value="ing">
			<div class="reserv_menu grid">
				<div class="reserv_menu-div">
					<a href="javascript:beforeSearchReserv(0);"><h4 class="fw-bold">진행예약</h4></a> <a
						href="javascript:beforeSearchReserv(1);"><h4 class="fw-bold">지난예약</h4></a>
				</div>
			</div>
		</form>

			<div class="reserv_cont">

				<c:forEach var="reservation" items="${list}"  varStatus="status">

					<div class="reserv_article">

						<!-- petsitter_intro start -->
						<div class="petsitter_intro">
							<span class="petsitter"> <a href="#;"> <img
									class="petsitter_img" src="/petmama/upload/${list2[status.index].photo1}">
							</a>
							</span>
							<h4>
								<strong>[${list2[status.index].name} 펫시터]</strong><br>
								<p>${list2[status.index].title}</p>
							</h4>
							<a href="#;"  onclick="window.open('writeForm.do?r_num=${reservation.r_num}', '_blank', 'width=410, height=300'); return false;" class="btn_detail" >예약정보 상세보기 &gt;</a>
						</div>
						<!-- petsitter_intro end -->

						<a href="#;" class="btn_bxctrl open"> 
						<span class="stit"> ${list2[status.index].tag} </span> 
						</a>

						<div class="cnt">
							<div class="row first">
								<div class="txt">
									<h5>
										산책 <span class="bar"></span> 30분
									</h5>
									<p>
										예약시작시간 <span class="bar"></span> ${reservation.r_start}
									</p>

									<p>
										예약종료시간 <span class="bar"></span> ${reservation.r_end}
									</p>
								</div>
								<div class="bx_right">
								<c:if test="${reservation.r_condition == 0}">
									예약상태 : <font color="blue">예약대기중</font>				
								</c:if>
								<c:if test="${reservation.r_condition == 1}">
									예약상태 : <font color="blue">예약확정</font>				
								</c:if>
								<c:if test="${reservation.r_condition == 2}">
									예약상태 : <font color="blue">예약취소</font>				
								</c:if>
								<c:if test="${reservation.r_condition == 3}">
									예약상태 : <font color="blue">펫시터 예약취소</font>				
								</c:if>
								</div>
							</div>
						</div>

					</div>

				</c:forEach>
			</div>

			<div class="align-center">${page}</div>
		</div>
	</div>
</body>
</html>