<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<p>${list2[status.index].title}</p>
					</h4>

					<div class="bxc_btns">
						<a href="/petmama/PSboard/detail.do?sis_num=${list2[status.index].sis_num}" target="_blank" class="btn_bxctrl2 open"> <span class="stit">
								프로필보기</span>
						</a> <a href="tel:${list2[status.index].sis_phone}" class="btn_bxctrl2 open"> <span class="stit">
								연락하기</span>
						</a>
					</div>
				</div>
				<!-- petsitter_intro end -->

				<a href="#;" class="btn_bxctrl open"> <span class="stit">
						${list2[status.index].tag} </span>
				</a>

				<div class="cnt">
					<div class="row first">
						<div class="txt">
							<fmt:parseDate value="${reservation.r_start}" var="registered"
								pattern="yyyy-MM-dd HH:mm:ss" />
							<p>
								<fmt:formatDate value="${registered}" pattern="M월 dd일" />
							</p>
							<p></p>

							<c:if test="${reservation.sis_work == 1}">
										산책 
										</c:if>
							<c:if test="${reservation.sis_work == 2}">
										돌봄 
										</c:if>
							<c:if test="${reservation.sis_work == 3}">
										산책&돌봄 
										</c:if>

							<c:if test="${reservation.fee == 1}">
										&nbsp;종일
										</c:if>

							<c:if test="${reservation.fee == 2}">
										&nbsp;30분
										</c:if>

							<c:if test="${reservation.fee == 3}">
										&nbsp;60분
										</c:if>

							<c:if test="${reservation.fee == 4}">
										&nbsp;120분
										</c:if>
							<p>예약상태</p>
						</div>
						<div class="bx_right">
							<p>
								<fmt:formatDate value="${registered}" pattern="HH:mm:ss" />
							</p>
							<p>
								<font color="blue">27,000원</font>
							</p>
							<p>
								<c:if test="${reservation.r_condition == 0}">
									<font color="blue">예약대기중</font>
								</c:if>
								<c:if test="${reservation.r_condition == 1}">
									<font color="blue">예약확정</font>
								</c:if>
								<c:if test="${reservation.r_condition == 2}">
									<font color="blue">예약취소</font>
								</c:if>
								<c:if test="${reservation.r_condition == 3}">
									<font color="blue">펫시터 예약취소</font>
								</c:if>

							</p>
						</div>
					</div>
					<div class="row second">

						<!-- petsitter_intro start -->
						<div class="pet_intro">
							<span class="pet"> <a href="#;"> <img class="pet_img"
									src="/petmama/upload/${list3[status.index].pet_photo}">
							</a>

								<h4>
									<strong>[${list3[status.index].pet_name}
										(${list3[status.index].pet_age}세)]</strong><br>
								</h4>
							</span>
						</div>
						<!-- petsitter_intro end -->
						<div class="txt">
							<p>반려동물&nbsp;&nbsp;&nbsp;</p>
							<p>방문주소&nbsp;&nbsp;&nbsp;</p>
						</div>
						<div class="bx_right">
							<p>${list3[status.index].pet_name}</p>
							<p>${list4[status.index].mem_address1}${list4[status.index].mem_address2}</p>
						</div>
					</div>


				</div>
				<c:if test="${!empty user_num && user_auth == 3}">
					<div class="bxc_btn2">
						<a href="#;" class="btn_bxctrl3 open"> <span class="stit">
								예약변경요청 </span>
						</a> <a href="#;" class="btn_bxctrl3 open"> <span class="stit">
								예약취소 </span>
						</a>
					</div>
				</c:if>
				<c:if test="${!empty user_num && user_auth != 3}">
					<div class="bxc_btn2">
						<a href="#;" class="btn_bxctrl3 open"> <span class="stit">
								예약변경 </span>
						</a> <a href="#;" class="btn_bxctrl3 open"> <span class="stit">
								예약취소 </span>
						</a>
					</div>
				</c:if>
			</div>
		</c:forEach>
	</div>
</body>
</html>