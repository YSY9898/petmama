<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage/reservWrite.css">
<body>
	<div class="reserv_cont">

		<c:forEach var="reservation" items="${list}" varStatus="status">

			<div class="reserv_article">

				<!-- petsitter_intro start -->
				<div class="petsitter_intro">
					<span class="petsitter"> <a href="#;"> <img
							class="petsitter_img"
							src="/petmama/upload/${list2[status.index].photo1}">
					</a>
					</span>
					<h4>
						<strong>[${list2[status.index].name} 펫시터가 방문합니다]</strong><br>
						<p>단순 훈련사만이 아닌 심리 안정을 위한 멘토가 되어드리겠습니다
							${list2[status.index].title}</p>
					</h4>

					<div class="bxc_btns">
						<a href="#;" class="btn_bxctrl2 open"> <span class="stit">
								프로필보기 ${list2[status.index].tag} </span>
						</a> <a href="#;" class="btn_bxctrl2 open"> <span class="stit">
								연락하기 ${list2[status.index].tag} </span>
						</a>
					</div>
				</div>
				<!-- petsitter_intro end -->

				<a href="#;" class="btn_bxctrl open"> <span class="stit">
						태그 태그 ${list2[status.index].tag} </span>
				</a>

				<div class="cnt">
					<div class="row first">
						<div class="txt">
							<p>2월 1일(화)${reservation.r_start}</p>
							<p>돌봄 30분</p>
							<p>예약상태</p>
						</div>
						<div class="bx_right">
							<p>오전 9 : 30 ${reservation.r_start}</p>
							<font color="blue">27,000원</font>
							<p>
								<c:if test="${reservation.r_condition == 0}">
									예약상태 : <font color="blue">예약대기중</font>
								</c:if>

							</p>
						</div>
					</div>
					<div class="row second">

						<!-- petsitter_intro start -->
						<div class="pet_intro">
							<span class="pet"> <a href="#;"> <img class="pet_img"
									src="/petmama/upload/${list2[status.index].photo1}">
							</a>

								<h4>
									<strong>[${list2[status.index].name} 티티(2세)]</strong><br>
								</h4>
							</span>
						</div>
						<!-- petsitter_intro end -->
						<div class="txt">
							<p>반려동물&nbsp;&nbsp;&nbsp;</p>
							<p>방문주소&nbsp;&nbsp;&nbsp;</p>
						</div>
						<div class="bx_right">
							<p>티티</p>
							<p>서울 강남구</p>
						</div>
					</div>


				</div>
				<div class="bxc_btn2">
					<a href="#;" class="btn_bxctrl3 open"> <span class="stit">
							예약변경 ${list2[status.index].tag} </span>
					</a> <a href="#;" class="btn_bxctrl3 open"> <span class="stit">
							예약취소 ${list2[status.index].tag} </span>
					</a>
				</div>
		</c:forEach>
	</div>
</body>
</html>